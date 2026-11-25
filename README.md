# mordred-extension-dist

Prebuilt, ready-to-load distribution repository for the **Mordred** browser
extension on Chromium-based browsers (Chrome, Brave, Arc, and Edge).

This repository contains compiled, minified, non-obfuscated output only. It has
no source code, package manifest, or local build command; the source lives in
the private `mordredagent/mordred-extension` repository.

Current version: **0.3.0**

## What it does

- Connects by itself to the **Mordred-Hermes** agent on this Mac: opening the
  popup is enough. The Mac installer (`Mordred.pkg`) registers a native
  messaging host (`com.mordred.hermes`) that tells the extension where Hermes
  listens. A new browser is admitted once, with Touch ID on the Mac, after
  checking that the Mac and the popup show the same code.
- Chat with Hermes, and search what you did before: conversations and mail
  that Hermes has imported, grouped by topic and event.
- Select text on any page to see related topics, events and conversations from
  Hermes, its recommendations, and a translation by Hermes's local model when
  the selection is in another language.
- Start and follow Hermes's imports (for example Gmail with an app password, or
  Claude Code and Antigravity sessions). The import itself runs in Hermes.
- Exposes a Mordred Web3 wallet provider to HTTPS sites and local development
  pages. Sites must request access, and sensitive wallet actions are shown in a
  separate approval window before Hermes signs them. Wallet signing keys stay
  on the Hermes side.
- The interface is available in 25 languages and follows the browser's
  language.

Slack and Discord channel encryption is no longer part of this extension
(removed in 0.3.0).

## Requirements

- A Chromium-based browser (Chrome, Brave, Arc, Edge).
- Mordred-Hermes on a Mac with Apple silicon, installed with `Mordred.pkg`.
  The installer registers the native messaging host for Brave and Chrome, so
  the extension finds Hermes on its own (by default
  `ws://127.0.0.1:47711/ext`; the installer moves to a free port in
  47714–47799 if that one is taken).
- A Hermes on another computer can still be added by typing its address in the
  popup.

## Install

1. Clone or download this repository.
2. Open the browser's extensions page:
   - Chrome or Arc: `chrome://extensions`
   - Brave: `brave://extensions`
   - Edge: `edge://extensions`
3. Enable **Developer mode**.
4. Select **Load unpacked** and choose this repository's `dist/` directory.
5. Pin Mordred to the toolbar so its connection state is easy to reach.

Do not select the repository root: `dist/manifest.json` must be the manifest
loaded by the browser.

## Connect to Hermes

Open the Mordred popup. On a Mac where `Mordred.pkg` is installed, the
extension finds Hermes and asks it to admit this browser. The Mac shows a
Touch ID sheet with a short code; check that the popup shows the same code,
then approve with Touch ID. After that, opening the popup connects with no
further step.

The approval is only raised for this extension: the native host gives the
extension a ticket for that code, and Hermes refuses an approval request
without it. Unpacked development builds have another extension ID, which has
to be added on the Mac (see the Mordred-Hermes installer documentation).

## Update an existing installation

1. Replace or pull the complete contents of this repository, including every
   file below `dist/`.
2. Return to the browser's extensions page.
3. Click **Reload** on Mordred.
4. Open the popup and confirm that it connects to Hermes.

Reloading the unpacked extension keeps its stored connection state. Removing
and reinstalling the extension clears it, so Hermes asks to admit the browser
again with Touch ID.

## Create a Chrome Web Store package

Chrome Web Store accepts a ZIP archive, not an individual JavaScript file. Run:

```sh
./scripts/package-chrome-web-store.sh
```

The script reads the version from `dist/manifest.json` and creates:

```text
release/mordred-extension-0.3.0.zip
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

Chrome Web Store listing values, review notes, and asset requirements are kept
under [`chrome-web-store/`](chrome-web-store/README.md). Treat those files as
the reviewable repository record; the Developer Dashboard must still be updated
manually.

## Browser access

The Manifest V3 bundle requests the following access:

| Access | Purpose |
| --- | --- |
| `nativeMessaging` | Ask the Mordred native host on this Mac where Hermes listens, and for the ticket that lets Hermes raise the approval for this browser. |
| `activeTab` | Attach the current tab's address to a chat message when that setting is on (off by default). |
| `scripting` | After an install or update, add the selection panel to tabs that were already open. |
| `alarms` | Maintain background reconnect and housekeeping work. |
| `http://localhost/*`, `http://127.0.0.1/*` | Communicate with the local Hermes gateway on the port the installer chose. |
| All HTTP and HTTPS pages | The selection panel (it reacts only to a text selection the user makes) and the Web3 provider (HTTPS and localhost pages). |

Connection state, settings and wallet connection state are stored locally in
extension-scoped IndexedDB, which requires no additional manifest permission.

Review site connection and wallet approval prompts carefully. The extension's
ability to run on HTTPS pages is broad because the wallet provider must be
available to dapps, even though a site is not connected to a wallet until its
request is approved.

## Security notes

- The extension talks only to the user's own Hermes. Selected text and chat
  messages are sent to that Hermes; the extension itself sends nothing to
  INTMAX or any third party.
- A new browser is admitted only after the user approves it on the Mac with
  Touch ID, and only for this extension's ID.
- Wallet signing remains on the Hermes side. Treat every connection or
  signature approval as security-sensitive.
- The bundle uses Chrome Web Store-permitted minification and descriptive
  filenames. It does not encode string literals or apply other obfuscation and
  contains no source maps. Browser extensions run on the user's machine and
  can always be inspected.

## Distribution contents

- `dist/manifest.json` — Manifest V3 metadata, permissions, and entry points
- `dist/popup.html`, `dist/popup.js`, `dist/popup.css` — extension popup
- `dist/src/sign/index.html`, `dist/sign.js`, `dist/sign.css` — wallet approval
  window
- `dist/background.js` — background service worker
- `dist/content-recall.js` — the selection panel
- `dist/content-web3.js`, `dist/injected-provider.js` — Web3 bridge and provider
- `dist/icons/` — extension icons
- `scripts/package-chrome-web-store.sh` — validated Chrome Web Store ZIP
  packaging
- `chrome-web-store/` — Store listing metadata, privacy/reviewer notes, and
  approved asset guidance
- `release/` — generated upload packages (ignored by Git)

There are intentionally no `.ts`, `.tsx`, `.map`, dependency directories, or
build-tool files in this repository.

