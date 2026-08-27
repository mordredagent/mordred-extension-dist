# Privacy practices working record

This is a review checklist for the Chrome Web Store **Privacy** page, not a
final legal declaration. Revalidate it against the exact bundle being submitted
and the Dashboard's current definitions before saving or certifying anything.

## Single purpose draft

Mordred connects the browser to a user-controlled local Mordred-Hermes agent to
provide secure agent chat, end-to-end encrypted Slack and Discord channels, and
user-approved Web3 wallet connections and signing requests.

## Permission justification drafts

| Permission or host access | Current purpose |
| --- | --- |
| `activeTab` | Work with the active Slack or Discord page during guided setup and channel management. |
| `alarms` | Schedule background reconnect and housekeeping work for the Hermes connection. |
| `localhost:7788`, `127.0.0.1:7788` | Communicate with the user-operated local Mordred-Hermes browser-extension gateway. |
| Slack and Discord hosts | Identify registered channels and encrypt or decrypt supported messages and attachments. |
| All HTTPS pages and localhost development pages | Make the Mordred Web3 provider available to dapps and relay user-approved wallet requests. A site is not wallet-connected until the user approves it. |

Persistent local state is stored in extension-scoped IndexedDB. IndexedDB does
not require a `storage` permission in the extension manifest.

## Data-handling inventory to verify

The current features can handle data that may fall under these Dashboard
categories. Confirm the exact definitions shown by Chrome Web Store at
submission time:

- Personal communications: Hermes chat plus registered Slack/Discord message
  and supported attachment content.
- Authentication information: short-lived pairing and WebAuthn/passkey
  authentication material.
- Financial and payment information: wallet addresses, networks, transaction
  requests, and signature requests handled for Web3 functionality.
- Website content: supported Slack/Discord content and dapp request data needed
  to provide the requested feature.
- User activity: connected-site origins and user-initiated wallet RPC actions,
  if the Dashboard definition includes them.

## Architecture notes

- The packaged host allowlist connects directly to the local Hermes gateway,
  Slack, Discord, their supported media hosts, and pages receiving the Web3
  provider.
- Wallet signing stays on the Hermes side; private wallet signing keys are not
  packaged in the extension.
- Shared Slack/Discord channel keys are stored by the extension so encryption
  can continue while Hermes is temporarily offline.
- The package is minified but not obfuscated. Minification is not a privacy or
  security control.

## Finalized Dashboard answers — Privacy page (v0.2.3, 2026-08-27)

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
