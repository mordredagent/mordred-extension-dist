# Chrome Web Store submission record

This directory is the repository source of truth for the Mordred Chrome Web
Store listing and review preparation. The Chrome Web Store Developer Dashboard
does not sync from these files automatically; copy the reviewed values into the
Dashboard and keep both sides aligned.

## Current item

| Field | Value |
| --- | --- |
| Publisher | `INTMAX` |
| Extension ID | `hjdjaknfdfcmlndipbcoflplecpofdbl` |
| Dashboard status | Published - public; 0.2.7 pending review (submitted 2026-08-31, auto-publish on approval) |
| Prepared package version | `0.2.7` |
| Default listing language | English (`en`) |
| Category | Tools |

Exact Dashboard field values and asset paths are in
[`listing.json`](./listing.json). Review-related working notes are split into
[`privacy-practices.md`](./privacy-practices.md) and
[`test-instructions.md`](./test-instructions.md).

## Submission workflow

1. Update the generated extension under `dist/` and increment
   `dist/manifest.json`'s `version` for every new Store package.
2. Keep the root README's **Current version** and
   `listing.json`'s `item.lastPreparedForVersion` equal to the manifest version.
3. Run `./scripts/package-chrome-web-store.sh` and smoke-test the generated ZIP.
4. Prepare the required images according to [`assets/README.md`](./assets/README.md).
5. Upload the complete ZIP from `release/` on the Dashboard's **Package** page.
6. Apply the values from `listing.json` on **Store listing**.
7. Recheck and complete **Privacy**, **Distribution**, and **Test
   instructions** using the repository notes. Store reviewer-only credentials
   in the Dashboard, never in Git.
8. Save the draft and review every Dashboard section before submitting.

## Source-of-truth boundaries

- Package title, summary, version, permissions, and executable entries come
  from `dist/manifest.json`.
- Long description, category, language, URLs, maturity setting, and asset
  choices come from `listing.json`.
- Screenshots and promo graphics live under `assets/` when they are approved.
- The Dashboard remains authoritative for submission state, rollout,
  distribution visibility, reviewer-only access data, and final declarations.

Do not commit passwords, pairing codes, Slack or Discord tokens, API keys,
wallet material, unpublished customer information, or screenshots containing
private workspace data.
