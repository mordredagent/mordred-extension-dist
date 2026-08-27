# Store listing assets

Keep only approved, submission-ready Chrome Web Store artwork in this
directory. Source screenshots must depict the actual extension; do not use
generated UI imagery that could misrepresent product behavior.

## Current asset plan

| Dashboard asset | Requirement | Repository path or status |
| --- | --- | --- |
| Store icon | Required, 128×128 | `assets/brand/store-icon-128.png` |
| Screenshots | At least 1; up to 5; 1280×800 or 640×400; JPEG or 24-bit PNG without alpha | `assets/screenshots/01-popup-onboarding-1280x800.png` (1 of up to 5) |
| Global promo video | Optional YouTube URL | Omitted |
| Small promo tile | Optional, 440×280; JPEG or 24-bit PNG without alpha | `assets/promo/small-promo-440x280.png` |
| Marquee promo tile | Optional, 1400×560; JPEG or 24-bit PNG without alpha | `assets/promo/marquee-promo-1400x560.png` |

## Brand assets

The Store icon and all four packaged extension icons are rasterized from
`mordred-website/static/favicon.svg`; the two 128px PNGs are byte-for-byte
identical, so the listing and installed extension match. The transparent
website wordmark and promo tiles use the official shield mark, palette, and
type direction from the sibling `mordred-website` repository. The website
wordmark is `assets/brand/mordred-logo.png`; it is retained here for reuse and
is not a Chrome Web Store upload requirement.

Source references and the asset production details are recorded in
[`GENERATION.md`](./GENERATION.md).

## Planned screenshots

Add approved files under `assets/screenshots/` using these names:

1. `01-popup-onboarding-1280x800.png` — real unpaired onboarding and pairing options _(added)_
2. `02-encrypted-channel-1280x800.png` — Slack or Discord encrypted-channel
   status and interaction
3. `03-wallet-approval-1280x800.png` — Web3 connection or harmless test-network
   signing approval

Screenshots must show the real extension UI. AI-generated or reconstructed UI
must not be submitted as a product screenshot. If browser automation cannot
access the extension's internal page, capture the popup manually using a
dedicated demo profile and add the clean original here for final sizing.

After adding a screenshot, append its repository-relative path to
`listing.json`'s `assets.screenshots` array in Dashboard order.

## Capture checklist

- [ ] Use the exact version being submitted.
- [ ] Show real, legible product functionality with no misleading mock data.
- [ ] Remove or mask pairing codes, tokens, wallet addresses, personal names,
      private channels, direct messages, and browser-profile details.
- [ ] Use dedicated demo accounts, channels, and test networks.
- [ ] Export at one of the exact accepted dimensions and verify PNG files have
      no alpha channel.
- [ ] Review spelling, cropping, and consistency at 100% scale.
- [ ] Record the final filenames in `listing.json`.
