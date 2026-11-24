#!/usr/bin/env bash
# Cut a new release of the bias-spotter plugin.
#
#   scripts/release.sh            bump the patch version (0.1.0 -> 0.1.1)
#   scripts/release.sh minor      bump the minor version (0.1.3 -> 0.2.0)
#   scripts/release.sh major      bump the major version (0.2.0 -> 1.0.0)
#   scripts/release.sh 1.4.0      set an exact version
#
# It bumps "version" in .claude-plugin/plugin.json (installed plugins only
# update when this number changes), rebuilds bias-spotter.skill so the
# download matches the skill, validates the plugin if the claude CLI is
# installed, and commits everything. It does not push: review the commit,
# then run `git push`.
set -euo pipefail

cd "$(dirname "$0")/.."

MANIFEST=.claude-plugin/plugin.json
SKILL_NAME=bias-spotter
SKILL_FILE=$SKILL_NAME.skill
BUMP=${1:-patch}

NEW_VERSION=$(python3 - "$MANIFEST" "$BUMP" <<'PY'
import json, re, sys

path, bump = sys.argv[1], sys.argv[2]
with open(path) as f:
    manifest = json.load(f)

current = manifest.get("version", "0.0.0")
match = re.fullmatch(r"(\d+)\.(\d+)\.(\d+)", current)
if not match:
    sys.exit(f"Current version {current!r} is not in X.Y.Z form")
major, minor, patch = map(int, match.groups())

if bump == "patch":
    new = f"{major}.{minor}.{patch + 1}"
elif bump == "minor":
    new = f"{major}.{minor + 1}.0"
elif bump == "major":
    new = f"{major + 1}.0.0"
elif re.fullmatch(r"\d+\.\d+\.\d+", bump):
    new = bump
else:
    sys.exit(f"Unknown argument {bump!r}: use patch, minor, major or X.Y.Z")

if new == current:
    sys.exit(f"Version is already {current}")

manifest["version"] = new
with open(path, "w") as f:
    json.dump(manifest, f, indent=2)
    f.write("\n")
print(new)
PY
)

# Rebuild the standalone skill file. The archive holds the skill folder
# itself, without the test cases.
rm -f "$SKILL_FILE"
(cd skills && zip -rqX "../$SKILL_FILE" "$SKILL_NAME" \
  -x "$SKILL_NAME/evals/*" -x '*.DS_Store')

if command -v claude >/dev/null 2>&1; then
  claude plugin validate . --strict
else
  echo "claude CLI not found, skipping plugin validation" >&2
fi

git add -A
git commit -q -m "Release v$NEW_VERSION"

echo "Released v$NEW_VERSION in a local commit. Review it, then run: git push"
