# Mordred Browser Extension — Privacy Policy

**Publisher:** INTMAX
**Extension:** Mordred (Chrome Web Store item ID `hjdjaknfdfcmlndipbcoflplecpofdbl`)
**Effective date:** 2026-11-25 (version 0.3.0)

## Summary

Mordred is a bridge between your browser and **your own Mordred-Hermes agent
on your Mac**. Its single purpose is to let you work with that local agent from
the browser: chat with it, look up related past conversations and mail it
holds (including for text you select on a page), and review and approve Web3
wallet connection and signing requests before they are forwarded to it.

Mordred is local-first. The data it handles is exchanged only with **your own
Hermes agent**: on your Mac over `http://127.0.0.1` / `http://localhost`, or at
another Hermes address you enter yourself. It also talks to the web pages you
use it on, and to the Mordred native host that the Mordred-Hermes installer
registers on your Mac. **INTMAX does not operate a server that receives your
content, and the extension sends no analytics, telemetry, or usage data to
INTMAX or any third party.**

## Data the extension handles

Mordred processes the following categories of data solely to provide the
features you use:

- **Personal communications.** Your chat with your Hermes agent. It also shows
  the conversations and mail that your Hermes agent has imported, when you
  search them or select text on a page.
- **Website content.** Text you select on a page, which is sent to your Hermes
  agent to find related results. The address of the current tab, attached to a
  chat message only if you turn that setting on (it is off by default). The
  data a site sends in a Web3 request.
- **Authentication information.**
  - The key that lets your Hermes agent recognize this browser after you
    approved it on your Mac.
  - Sign-in details you type in Mordred to let your Hermes agent import your
    data: for example a Gmail app password, or a Telegram phone number, login
    code and password. Mordred passes them to your Hermes agent and does not
    keep them.
- **Financial information.** Wallet addresses, networks, transaction requests,
  and signature requests handled when you use the Web3 features. Private wallet
  signing keys stay on the Hermes side and are never packaged in, or exported
  by, the extension.

Mordred does **not** collect your name, email address, physical address, age,
government identifiers, health data, location/GPS, browsing history, or
behavioral activity (clicks, keystrokes, mouse movement, or scroll).

## How data is used and stored

- Handled data is used **only** to deliver the feature you use. It is exchanged
  only with your Hermes agent and the site you are using.
- The extension uses extension-scoped IndexedDB to keep these on your device:
  - your settings;
  - the connection state for your agent(s), including the key described above;
  - per-site Web3 connection metadata (which origins you approved).
- No wallet connection or signature is exposed to a site until **you explicitly
  approve** it in Mordred.
- What your Hermes agent does with data, for example storing imported mail or
  using an AI model you chose, is governed by the Mordred-Hermes software on
  your Mac. It is not part of this extension.

## Data sharing

- INTMAX does **not** sell or transfer your data to third parties.
- INTMAX does **not** use or transfer your data for any purpose unrelated to the
  extension's single purpose.
- INTMAX does **not** use or transfer your data to determine creditworthiness or
  for lending purposes.

## Remote code

Mordred does not load or execute remotely hosted code. All JavaScript is
packaged in the extension; the connection to your Hermes agent carries data
only.

## Retention and deletion

Data stored by the extension lives in its browser-scoped IndexedDB and on your
Hermes agent. Removing the extension clears its browser-stored data. Data held
by your Hermes agent is under your control.

## Contact

Questions or requests:
<https://github.com/mordredagent/mordred-extension-dist/issues>

## Changes

Material changes to this policy will be reflected here with an updated effective
date.
