#!/bin/sh

set -eu

SCRIPT_DIR=$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)
REPO_ROOT=$(CDPATH='' cd -- "$SCRIPT_DIR/.." && pwd)
DIST_DIR="$REPO_ROOT/dist"
MANIFEST_PATH="$DIST_DIR/manifest.json"

fail() {
  printf 'error: %s\n' "$*" >&2
  exit 1
}

command -v node >/dev/null 2>&1 || fail "node is required"
command -v zip >/dev/null 2>&1 || fail "zip is required"
command -v unzip >/dev/null 2>&1 || fail "unzip is required"

[ -f "$MANIFEST_PATH" ] || fail "missing $MANIFEST_PATH"

# JavaScript template literals below are intentionally protected from the shell.
# shellcheck disable=SC2016
VERSION=$(node -e '
  const fs = require("fs");
  const manifest = JSON.parse(fs.readFileSync(process.argv[1], "utf8"));
  if (manifest.manifest_version !== 3) {
    throw new Error(`expected Manifest V3, got ${manifest.manifest_version}`);
  }
  if (typeof manifest.version !== "string" || !manifest.version) {
    throw new Error("manifest version is missing");
  }
  process.stdout.write(manifest.version);
' "$MANIFEST_PATH")

case "$VERSION" in
  *[!0-9A-Za-z._-]*|'') fail "manifest version is unsafe for a filename: $VERSION" ;;
esac

DEFAULT_OUTPUT="$REPO_ROOT/release/mordred-extension-$VERSION.zip"
OUTPUT_PATH=${1:-$DEFAULT_OUTPUT}

case "$OUTPUT_PATH" in
  /*) ;;
  *) OUTPUT_PATH="$REPO_ROOT/$OUTPUT_PATH" ;;
esac

case "$OUTPUT_PATH" in
  *.zip) ;;
  *) fail "output path must end in .zip" ;;
esac

case "$OUTPUT_PATH" in
  "$DIST_DIR"/*) fail "output ZIP must be outside dist/" ;;
esac

SYMLINK=$(find "$DIST_DIR" -type l -print -quit)
[ -z "$SYMLINK" ] || fail "symlinks are not allowed in the package: $SYMLINK"

UNEXPECTED=$(find "$DIST_DIR" -type f ! \( \
  -name '*.js' -o \
  -name '*.css' -o \
  -name '*.html' -o \
  -name '*.json' -o \
  -name '*.png' \
\) -print)
[ -z "$UNEXPECTED" ] || fail "unexpected file type in dist/: $UNEXPECTED"

node - "$DIST_DIR" <<'NODE'
const fs = require('fs');
const path = require('path');

const dist = path.resolve(process.argv[2]);
const manifest = JSON.parse(fs.readFileSync(path.join(dist, 'manifest.json'), 'utf8'));
const references = new Set();

function addReference(value) {
  if (typeof value === 'string' && value) references.add(value.replace(/^\//, ''));
}

addReference(manifest.background?.service_worker);
addReference(manifest.action?.default_popup);
Object.values(manifest.action?.default_icon || {}).forEach(addReference);
Object.values(manifest.icons || {}).forEach(addReference);

for (const entry of manifest.content_scripts || []) {
  (entry.js || []).forEach(addReference);
  (entry.css || []).forEach(addReference);
}

function collectHtmlReferences(directory) {
  for (const item of fs.readdirSync(directory, { withFileTypes: true })) {
    const itemPath = path.join(directory, item.name);
    if (item.isDirectory()) {
      collectHtmlReferences(itemPath);
    } else if (item.name.endsWith('.html')) {
      const html = fs.readFileSync(itemPath, 'utf8');
      for (const match of html.matchAll(/(?:src|href)="\/?([^"#?]+)["#?]/g)) {
        addReference(match[1]);
      }
    }
  }
}

collectHtmlReferences(dist);

const missing = [...references].filter((reference) => {
  const target = path.resolve(dist, reference);
  return !target.startsWith(`${dist}${path.sep}`) || !fs.existsSync(target);
});

if (missing.length) {
  throw new Error(`missing or unsafe bundle references: ${missing.join(', ')}`);
}
NODE

OUTPUT_DIR=$(dirname -- "$OUTPUT_PATH")
mkdir -p "$OUTPUT_DIR"

TEMP_DIR=$(mktemp -d "${TMPDIR:-/tmp}/mordred-cws.XXXXXX")
TEMP_ZIP="$TEMP_DIR/package.zip"
trap 'rm -rf "$TEMP_DIR"' EXIT HUP INT TERM

(
  cd "$DIST_DIR"
  COPYFILE_DISABLE=1 zip -X -q -r "$TEMP_ZIP" . \
    -x '*.DS_Store' '__MACOSX/*'
)

unzip -tq "$TEMP_ZIP" >/dev/null
unzip -Z1 "$TEMP_ZIP" | grep -qx 'manifest.json' \
  || fail "manifest.json is not at the ZIP root"

if unzip -Z1 "$TEMP_ZIP" | grep -q '^dist/'; then
  fail "ZIP incorrectly contains a top-level dist/ directory"
fi

mv -f "$TEMP_ZIP" "$OUTPUT_PATH"

printf 'Created Chrome Web Store package:\n%s\n' "$OUTPUT_PATH"
printf 'Version: %s\n' "$VERSION"
FILE_COUNT=$(unzip -Z1 "$OUTPUT_PATH" | grep -c -v '/$')
printf 'Files: %s\n' "$FILE_COUNT"
