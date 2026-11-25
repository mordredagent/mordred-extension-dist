# Privacy practices working record

This is a review checklist for the Chrome Web Store **Privacy** page, not a
final legal declaration. Revalidate it against the exact bundle being submitted
and the Dashboard's current definitions before saving or certifying anything.

## Single purpose draft

Mordred connects the browser to the user's own Mordred-Hermes agent on their
Mac: chat with it, look up related past conversations and mail it holds
(including for text the user selects on a page), and review and approve Web3
wallet connection and signing requests.

## Permission justification drafts

| Permission or host access | Current purpose |
| --- | --- |
| `nativeMessaging` | Ask the native host `com.mordred.hermes` (registered by the Mordred-Hermes installer) for the local Hermes address and for the ticket that lets Hermes raise its Touch ID approval for this extension only. |
| `activeTab` | Attach the current tab's address to a chat message when that setting is on (off by default). |
| `scripting` | After install or update, add the packaged selection-panel script to tabs that were already open. |
| `alarms` | Schedule background reconnect and housekeeping work for the Hermes connection. |
| `http://localhost/*`, `http://127.0.0.1/*` | Communicate with the user's local Mordred-Hermes gateway on the port its installer chose (47711 by default). |
| All HTTP and HTTPS pages (content script) | The selection panel: after the user selects text, send it to the local Hermes and show related results. |
| All HTTPS pages and localhost development pages | Make the Mordred Web3 provider available to dapps and relay user-approved wallet requests. A site is not wallet-connected until the user approves it. |

Persistent local state is stored in extension-scoped IndexedDB. IndexedDB does
not require a `storage` permission in the extension manifest.

## Data-handling inventory to verify

The current features can handle data that may fall under these Dashboard
categories. Confirm the exact definitions shown by Chrome Web Store at
submission time:

- Personal communications: Hermes chat, plus the imported conversations and
  mail that Hermes returns for a search or a selection.
- Authentication information: the browser's device key for Hermes, and the
  sign-in details typed in the popup for an import (Gmail app password, Telegram
  phone number, login code and password). These are sealed and passed to
  Hermes, not stored by the extension.
- Financial and payment information: wallet addresses, networks, transaction
  requests, and signature requests handled for Web3 functionality.
- Website content: text the user selects on a page (sent to the local Hermes),
  the current tab's address when the user enabled it, and dapp request data.
- User activity: connected-site origins and user-initiated wallet RPC actions,
  if the Dashboard definition includes them.

## Architecture notes

- The packaged host allowlist connects to the local Hermes gateway and to pages
  that receive the selection panel and the Web3 provider. Slack and Discord
  access was removed in 0.3.0.
- Wallet signing stays on the Hermes side; private wallet signing keys are not
  packaged in the extension.
- The native host answers only the extension IDs that the Mac installer
  allowed, and only when the calling process is a signed Brave or Chrome.
- The package is minified but not obfuscated. Minification is not a privacy or
  security control.

## 0.3.0 changes to revalidate (2026-11-25)

The answers below were finalized for 0.2.3–0.2.7. 0.3.0 changes the inputs:

- Added the `nativeMessaging` and `scripting` permissions.
- Host access is now `http://localhost/*` and `http://127.0.0.1/*` (any port)
  plus all HTTP/HTTPS pages for the selection panel. Slack, Discord and
  their media hosts were removed.
- New data flows: selected page text goes to the local Hermes; import sign-in
  details are passed to the local Hermes.
- Removed: Slack/Discord message encryption and channel keys.

Before submitting 0.3.0, the product owner must confirm the data categories and
certifications again and update the Dashboard's permission justifications from
`listing.json`.

## Finalized Dashboard answers — Privacy page (v0.2.3, 2026-08-27)

Re-validated unchanged for v0.2.7 (2026-08-31): the manifest gained only the
`key` field (pins the published extension ID); permissions, host access, and
content-script matches are identical to v0.2.3.

Paste-ready values for the Chrome Web Store **Privacy** page.

### Remote code

**No, I am not using remote code.**

Evidence (checked against the submitted `dist/` bundle): all executable
JavaScript is packaged in the extension, with no `eval`, `new Function`,
`importScripts`, or remotely hosted script reference. WebSocket traffic goes
only to the local Hermes gateway (`localhost:7788` / `127.0.0.1:7788`). The
background worker can also fetch encrypted attachment bytes from the
manifest-allowlisted Slack and Discord file hosts. Those responses are handled
strictly as data and are never executed as code.

### Data usage — categories to check

- [x] Financial and payment information — wallet addresses, networks,
      transaction requests, signature requests.
- [x] Authentication information — pairing codes and WebAuthn/passkey material.
- [x] Personal communications — agent chat and registered Slack/Discord messages
      and attachments.
- [x] Website content — Slack/Discord content and connecting-site Web3 request
      data.

Leave **unchecked** (extension does not collect these): Personally identifiable
information, Health information, Location, Web history, User activity. (User
activity is a judgment call — Mordred responds to user-initiated wallet/RPC
actions but does not monitor clicks, keystrokes, scroll, or the network; leave
unchecked unless the product owner decides otherwise.)

### Certifications — check all three (all true)

- [x] Do not sell or transfer user data to third parties outside approved use
      cases.
- [x] Do not use or transfer user data for purposes unrelated to the single
      purpose.
- [x] Do not use or transfer user data to determine creditworthiness or for
      lending.

### Privacy policy URL

Publish `PRIVACY.md` (repo root) and enter its public URL, e.g.
`https://github.com/mordredagent/mordred-extension-dist/blob/main/PRIVACY.md`
(confirm the repo is public and the file is pushed before submitting).

## Submission TODOs

- [ ] Recheck the exact submitted manifest and bundled network endpoints.
- [ ] Confirm every applicable Dashboard data category with the product owner.
- [ ] Confirm whether any analytics, diagnostics, or server-side retention has
      been added outside this distribution repository.
- [ ] Confirm the Dashboard declarations for sale, transfer, advertising,
      creditworthiness, and purposes unrelated to the extension's single
      purpose.
- [ ] Publish and enter an approved privacy-policy URL if the Dashboard requires
      one.
- [ ] Verify that no remotely hosted executable code is used.
- [ ] Have the final declarations reviewed by the person responsible for the
      product's privacy and legal commitments.
