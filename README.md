# mordred-extension-dist

Prebuilt, ready-to-load distribution repository for the **Mordred** browser
extension on Chromium-based browsers (Chrome, Brave, Arc, and Edge).

This repository contains compiled and obfuscated output only. It has no source
code, package manifest, or local build command; the source lives in the private
`mordredagent/mordred-extension` repository.

Current version: **0.2.0**

## What it does

- Pairs with one or more local **Mordred-Hermes** agents for chat, key
  management, and wallet approvals.
- Adds end-to-end encryption to registered Slack and Discord channels,
  including teammate-to-teammate channel-key sharing. Once a shared channel
  key is installed, channel encryption can continue without a connected Hermes
  agent.
- Exposes a Mordred Web3 wallet provider to HTTPS sites and local development
  pages. Sites must request access, and sensitive wallet actions are shown in a
  separate approval window before Hermes signs them.
- Keeps wallet signing keys on the Hermes side rather than in the extension.

## Requirements

- A Chromium-based browser with extension developer mode enabled.
- A local Mordred-Hermes installation for pairing, chat, automated channel
  management, or wallet signing.
- The packaged extension connects to the Hermes browser-extension gateway on
  `localhost:7788` (or `127.0.0.1:7788`).

## Install

1. Clone or download this repository.
2. Open the browser's extensions page:
   - Chrome or Arc: `chrome://extensions`
   - Brave: `brave://extensions`
   - Edge: `edge://extensions`
3. Enable **Developer mode**.
4. Select **Load unpacked** and choose this repository's `dist/` directory.
5. Pin Mordred to the toolbar so pairing and approval state are easy to reach.

Do not select the repository root: `dist/manifest.json` must be the manifest
loaded by the browser.

## Pair with Hermes

Start the browser-extension gateway from the Hermes environment:

```sh
hermes-mordred extension serve
```

Open the Mordred popup, choose **Connect a Hermes agent**, and enter the pairing
code printed by the command. The popup also contains guided setup for Slack and
Discord after pairing.

Re-pair the same endpoint when its agent details need refreshing. Do not unpair
or reinstall merely to reconnect: unpairing removes shared channel keys from
the extension.

## Update an existing installation

1. Replace or pull the complete contents of this repository, including every
   file below `dist/`.
2. Return to the browser's extensions page.
3. Click **Reload** on Mordred.
4. Open the popup and confirm the Hermes connection and registered encrypted
   channels.

Reloading the unpacked extension preserves its stored pairing and channel-key
state. Removing and reinstalling the extension may not.

## Create a Chrome Web Store package

Chrome Web Store accepts a ZIP archive, not an individual JavaScript file. Run:

```sh
./scripts/package-chrome-web-store.sh
```

The script reads the version from `dist/manifest.json` and creates:

```text
release/mordred-extension-0.2.0.zip
```

To choose another output path, pass a `.zip` path relative to the repository or
an absolute path:

```sh
./scripts/package-chrome-web-store.sh release/mordred-upload.zip
```

Upload the resulting ZIP as a whole. Its `manifest.json` is at the ZIP root, as
required by the [Chrome Web Store packaging
guide](https://developer.chrome.com/docs/webstore/prepare#zip). For an update to
an existing store item, first increase `version` in `dist/manifest.json`; Chrome
Web Store requires every uploaded update to use a higher version.

## Browser access

The Manifest V3 bundle requests the following access:

| Access | Purpose |
| --- | --- |
| `storage` | Persist pairing, settings, wallet connection state, and encrypted-channel keys. |
| `activeTab` | Work with the active Slack or Discord tab during setup and channel management. |
| `alarms` | Maintain background reconnect and housekeeping work. |
| `localhost:7788`, `127.0.0.1:7788` | Communicate with the local Hermes gateway. |
| Slack and Discord domains | Detect registered channels and encrypt/decrypt their messages and supported attachments. |
| All HTTPS pages plus localhost development pages | Inject the Web3 provider and relay site requests to the extension. |

Review site connection and wallet approval prompts carefully. The extension's
ability to run on HTTPS pages is broad because the wallet provider must be
available to dapps, even though a site is not connected to a wallet until its
request is approved.

## Security notes

- Slack and Discord channel keys are held by the extension so encryption can
  keep working when Hermes is temporarily offline. Unpairing deletes the shared
  keys; export or re-share anything needed before doing so.
- Chat history is stored encrypted on Hermes and is shared with the paired
  extension for display.
- Wallet signing remains on the Hermes side. Treat the endpoint identity and
  every connection or signature approval as security-sensitive.
- The bundle uses opaque filenames, identifier mangling, encoded string
  literals, and no source maps or comments. This reduces distribution noise;
  it is **not** a security boundary. Browser extensions run on the user's
  machine and can always be inspected.

## Distribution contents

- `dist/manifest.json` — Manifest V3 metadata, permissions, and entry points
- `dist/popup.html`, `dist/a6.js`, `dist/a6.css` — extension popup
- `dist/src/sign/index.html`, `dist/a7.js`, `dist/a7.css` — wallet approval
  window
- `dist/a0.js` — background service worker
- `dist/a1.js` through `dist/a5.js` — Slack, Discord, and Web3 integration
- `dist/icons/` — extension icons
- `scripts/package-chrome-web-store.sh` — validated Chrome Web Store ZIP
  packaging
- `release/` — generated upload packages (ignored by Git)

There are intentionally no `.ts`, `.tsx`, `.map`, dependency directories, or
build-tool files in this repository.
