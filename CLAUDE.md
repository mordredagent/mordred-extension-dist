# Repository instructions

## Repository purpose

This repository, `mordredagent/mordred-extension-dist`, is the load-unpacked
distribution of the private `mordredagent/mordred-extension` project. It
contains generated, Chrome Web Store-ready Manifest V3 artifacts only. There is
no source tree, package manager configuration, or supported build command here.

Do not treat this as the source repository and do not hand-edit generated
JavaScript or CSS unless the user explicitly requests an emergency patch. A
normal release update replaces the complete generated `dist/` output from the
private source repository.

## Distribution layout

The descriptive filenames are intentional. Their current roles are:

| Path | Role |
| --- | --- |
| `dist/manifest.json` | Extension metadata, permissions, and entry-point wiring |
| `dist/background.js` | Background service worker; Hermes transport, pairing, channel-key state, and wallet request routing |
| `dist/content-slack.js` | Slack content script (isolated world) |
| `dist/content-discord.js` | Discord content script (isolated world) |
| `dist/content-web3.js` | Isolated-world Web3 bridge |
| `dist/injected-provider.js` | Main-world Web3 provider |
| `dist/injected-slack-quill.js` | Main-world Slack editor integration |
| `dist/popup.html`, `dist/popup.js`, `dist/popup.css` | Popup application |
| `dist/src/sign/index.html`, `dist/sign.js`, `dist/sign.css` | Wallet request approval window |
| `dist/icons/` | Browser extension icons |
| `scripts/package-chrome-web-store.sh` | Validates and packages `dist/` for Chrome Web Store upload |
| `chrome-web-store/` | Versioned Store listing values, review notes, and approved asset guidance |
| `release/*.zip` | Generated Chrome Web Store packages; intentionally ignored by Git |

Keep HTML references and `manifest.json` entry points consistent when replacing
artifacts. Do not rename generated files independently.

## Release-update rules

- Preserve the compiled-output-only shape: do not add source files, source
  maps, dependency directories, build caches, or private-repository material.
- Replace the whole generated bundle, not only the files that appear changed.
  Generated entries can depend on one another even when their names remain stable.
- Keep `manifest.json`'s `version` and README's **Current version** in sync.
- Keep `chrome-web-store/listing.json`'s `item.lastPreparedForVersion` in sync
  with the submitted manifest. Update Dashboard status only from confirmed
  Dashboard state.
- Create Chrome Web Store ZIPs with
  `./scripts/package-chrome-web-store.sh`; do not zip the `dist/` directory as a
  top-level folder because `manifest.json` must be at the archive root.
- Reconcile README features, browser access, gateway requirements, and file
  layout whenever the manifest or UI behavior changes.
- Review every permission and match-pattern change deliberately. In particular,
  the Web3 bridge currently runs on all HTTPS pages plus localhost development
  pages, while Slack and Discord have platform-specific scripts and host access.
- Never add credentials, Slack/Discord tokens, pairing codes, channel keys,
  wallet material, `.env` files, or source maps.
- Never commit reviewer-only access data or screenshots containing workspace,
  wallet, account, or browser-profile secrets. Store reviewer credentials only
  in the Chrome Web Store Dashboard.
- Do not obfuscate the distribution. Chrome Web Store permits minification but
  prohibits encoded strings and other transforms that conceal functionality.

## Validation

For documentation-only changes, inspect the rendered Markdown and verify every
path and command against the current bundle. For a distribution update, also:

1. Parse `dist/manifest.json` and confirm its declared version.
2. Verify that every script, popup, icon, and approval-window file referenced by
   the manifest or HTML exists.
3. Confirm there are no source maps, source files, dependency directories, or
   unexpected untracked artifacts.
4. Load `dist/` through the browser's **Load unpacked** flow and check for
   manifest or service-worker errors.
5. Smoke-test the popup, Hermes pairing/reconnect, the relevant Slack/Discord
   channel flow, and Web3 connection/signing when those areas changed.
6. Review `git diff --stat`, `git diff`, and `git status --short` before commit.

Useful read-only checks:

```sh
node -e "const fs=require('fs'); JSON.parse(fs.readFileSync('dist/manifest.json', 'utf8')); console.log('manifest OK')"
node -e "const fs=require('fs'); const m=JSON.parse(fs.readFileSync('dist/manifest.json')); const l=JSON.parse(fs.readFileSync('chrome-web-store/listing.json')); if (m.version !== l.item.lastPreparedForVersion) throw new Error('Store listing version mismatch'); console.log('store listing OK')"
find dist -type f | sort
find dist -type f \( -name '*.map' -o -name '*.ts' -o -name '*.tsx' \)
./scripts/package-chrome-web-store.sh
git status --short
```

## Git commit identity

Every commit in this repository must use `mordred-poc <poc@localhost>` as both
the author and committer identity. Do not rely on or modify the user's local or
global Git configuration. Create commits with:

```sh
git -c user.name=mordred-poc -c user.email=poc@localhost commit ...
```
