#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "Running example heading checks..."
"$ROOT_DIR/scripts/check-examples-headings.sh"

echo
echo "Running forbidden pattern checks..."
"$ROOT_DIR/scripts/check-forbidden-patterns.sh"

echo
echo "All prompt validation checks passed."
