#!/usr/bin/env bash
# Local Apple Silicon build: no CI runner, developer subscription, or notarization service.
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
[[ "$(uname -s)" = Darwin && "$(uname -m)" = arm64 ]] || { echo "Run on an Apple Silicon Mac." >&2; exit 1; }
export MACOS_SIGN_IDENTITY=-
# A native release must never silently omit its multilingual catalogs.
export CRAFT_I18N_REQUIRED=1
export CARGO_BUILD_JOBS="${CARGO_BUILD_JOBS:-4}"
exec "$ROOT/packaging/macos/package.sh" "$@" --arch aarch64
