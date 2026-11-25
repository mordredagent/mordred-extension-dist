# Chrome Web Store reviewer test instructions

This file is the repository template for the Dashboard's **Test instructions**
section. Do not commit reviewer credentials, pairing codes, workspace tokens,
private channel names, or other secrets. Put reviewer-only values directly into
the Dashboard immediately before submission.

## Reviewer prerequisites

- Chromium browser supported by Chrome Web Store review.
- A Mac with Apple silicon where Mordred-Hermes is installed with
  `Mordred.pkg` (it registers the native host this extension uses), or a
  reachable Mordred-Hermes gateway whose address the reviewer can type.
- A non-production Web3 test site and test wallet/network only if wallet signing
  must be exercised.

## Draft test flow

1. Install Mordred and open its toolbar popup.
2. On the Mac with Mordred-Hermes, confirm that the popup connects by itself
   and that the Mac shows a Touch ID approval with the same code as the popup.
   Approve it. (Without the Mac, enter the gateway address in the popup.)
3. Send a chat message and confirm that it receives a response.
4. Open the search screen and search for a word in an imported conversation.
5. On any web page, select a few words and confirm that the selection panel
   opens with related results (or an empty result).
6. Open the approved Web3 test page, request a Mordred wallet connection, and
   confirm that Mordred shows an approval prompt before exposing the account.
7. Submit a harmless test-network signing request and confirm that its details
   are shown in the approval window before Hermes signs or rejects it.

## Values to add privately in the Dashboard

- [ ] How the reviewer obtains or reaches the dedicated Hermes gateway.
- [ ] Any reviewer-only installation command or download URL.
- [ ] Approved Web3 test page, test network, and funded test-only wallet steps.
- [ ] Expected results and known limitations for the submitted version.
- [ ] Support contact for review questions.

Never direct reviewers to production credentials, real funds, private customer
workspaces, or irreversible blockchain transactions.
