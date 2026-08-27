# Chrome Web Store reviewer test instructions

This file is the repository template for the Dashboard's **Test instructions**
section. Do not commit reviewer credentials, pairing codes, workspace tokens,
private channel names, or other secrets. Put reviewer-only values directly into
the Dashboard immediately before submission.

## Reviewer prerequisites

- Chromium browser supported by Chrome Web Store review.
- A reachable Mordred-Hermes browser-extension gateway compatible with the
  submitted package.
- Reviewer access to dedicated Slack and Discord test workspaces only if those
  integrations must be exercised.
- A non-production Web3 test site and test wallet/network only if wallet signing
  must be exercised.

## Draft test flow

1. Install Mordred and open its toolbar popup.
2. Confirm that the unpaired onboarding screen loads without a service-worker
   error.
3. Start the reviewer Hermes gateway with `hermes-mordred extension serve` and
   enter the displayed one-time pairing code in the popup.
4. Confirm that the paired agent appears and that a chat message receives a
   response.
5. In the dedicated Slack or Discord test workspace, register the test channel,
   send a message using the extension's encrypted-send interaction, and confirm
   that a paired participant can decrypt it.
6. Open the approved Web3 test page, request a Mordred wallet connection, and
   confirm that Mordred shows an approval prompt before exposing the account.
7. Submit a harmless test-network signing request and confirm that its details
   are shown in the approval window before Hermes signs or rejects it.

## Values to add privately in the Dashboard

- [ ] How the reviewer obtains or reaches the dedicated Hermes gateway.
- [ ] Any reviewer-only installation command or download URL.
- [ ] Dedicated Slack workspace and test-channel access.
- [ ] Dedicated Discord server and test-channel access.
- [ ] Approved Web3 test page, test network, and funded test-only wallet steps.
- [ ] Expected results and known limitations for the submitted version.
- [ ] Support contact for review questions.

Never direct reviewers to production credentials, real funds, private customer
workspaces, or irreversible blockchain transactions.
