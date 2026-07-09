#!/usr/bin/env bash
set -euo pipefail
REPO_URL="https://github.com/De-ASI-INTERFACE/x402-bitcoin-extension"
TAG="v1.0.0"
MESSAGE="x402-Bitcoin Extension v1.0.0 — Richard Patterson"
echo "[x402-bitcoin-extension] Cutting tag $TAG"
if [ ! -f "lakefile.lean" ]; then echo "ERROR: Run from repo root."; exit 1; fi
git fetch origin
COMMIT=$(git rev-parse HEAD)
git tag -a "$TAG" "$COMMIT" -m "$MESSAGE"
git push origin "$TAG"
echo "Tag $TAG pushed. Publish at: $REPO_URL/releases/new?tag=$TAG"
