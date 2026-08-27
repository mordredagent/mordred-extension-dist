# Mordred Browser Extension — Privacy Policy

**Publisher:** INTMAX
**Extension:** Mordred (Chrome Web Store item ID `hjdjaknfdfcmlndipbcoflplecpofdbl`)
**Effective date:** 2026-08-27

## Summary

Mordred is a bridge between your browser and a **local, user-operated
Mordred-Hermes agent**. Its single purpose is to let you talk to that local
agent: chat, send and receive end-to-end encrypted messages in Slack and
Discord channels you register, and review and approve Web3 wallet connection
and signing requests before they are forwarded to your local agent.

Mordred is local-first. The data it handles is exchanged only with **your own
local Hermes agent** (over `http://localhost:7788` / `http://127.0.0.1:7788`)
and with the Slack, Discord, and web pages you choose to use it on. **INTMAX
does not operate a server that receives your content, and the extension sends
no analytics, telemetry, or usage data to INTMAX or any third party.**

## Data the extension handles

Mordred processes the following categories of data solely to provide the
features you invoke:

- **Personal communications** — your chat with the paired agent and the
  messages (and supported attachments) in the Slack/Discord channels you
  register for encryption.
- **Authentication information** — short-lived pairing codes and
  WebAuthn/passkey material used to pair the extension with your local Hermes
  agent.
- **Financial information** — wallet addresses, networks, transaction requests,
  and signature requests handled when you use the Web3 features. Private wallet
  signing keys stay on the Hermes side and are never packaged in, or exported
  by, the extension.
- **Website content** — the Slack/Discord content and the connecting site's
  Web3 request data needed to perform the action you asked for.

Mordred does **not** collect your name, email address, physical address, age,
government identifiers, health data, location/GPS, browsing history, or
behavioral activity (clicks, keystrokes, mouse movement, or scroll).

## How data is used and stored

- Handled data is used **only** to deliver the feature you invoke and is
  exchanged only with your local Hermes agent and the site you are using.
- The extension uses extension-scoped IndexedDB to keep, on your device, the
  settings and pairing state for your agent(s), the list of channels you
  registered, per-site Web3 connection metadata (which origins you approved),
  and the encrypted channel keys needed to encrypt and decrypt registered
  channels while your local agent is temporarily offline.
- No wallet connection or signature is exposed to a site until **you explicitly
  approve** it in Mordred.

## Data sharing

- INTMAX does **not** sell or transfer your data to third parties.
- INTMAX does **not** use or transfer your data for any purpose unrelated to the
  extension's single purpose.
- INTMAX does **not** use or transfer your data to determine creditworthiness or
  for lending purposes.

## Remote code

Mordred does not load or execute remotely hosted code. All JavaScript is
packaged in the extension; the local-gateway connection carries data only.

## Retention and deletion

Data stored by the extension lives in its browser-scoped IndexedDB and on your
local Hermes agent. Removing the extension clears its browser-stored data; data
held by your local agent is under your control.

## Contact

Questions or requests:
<https://github.com/mordredagent/mordred-extension-dist/issues>

## Changes

Material changes to this policy will be reflected here with an updated effective
date.
