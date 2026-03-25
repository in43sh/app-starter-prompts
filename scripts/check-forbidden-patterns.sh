#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
failures=0

check_forbidden_pattern() {
  local description="$1"
  local pattern="$2"

  local matches
  matches="$(cd "$ROOT_DIR" && rg -n --glob 'docs/**' --glob 'examples/**' "$pattern" . || true)"

  if [[ -n "$matches" ]]; then
    echo "Forbidden pattern found: $description"
    echo "$matches"
    echo
    failures=1
  fi
}

check_forbidden_pattern "stale success metrics section" '^## Success Metrics$'
check_forbidden_pattern "duration estimate language" 'Estimated duration|time estimates?'
check_forbidden_pattern "time-horizon success question" 'What does success look like in 3 months\? In 1 year\?'
check_forbidden_pattern "stakeholder question" 'Who are the stakeholders'
check_forbidden_pattern "deadline question" 'deadline|deadlines'
check_forbidden_pattern "branching strategy question" "What's the git branching strategy\\?|What's the branching/deployment strategy\\?"
check_forbidden_pattern "deployment strategy question" "How does deployment work\\?|What's the branching/deployment strategy\\?"
check_forbidden_pattern "repository reference question" 'Is there a deployed URL or repository I should reference\?'
check_forbidden_pattern "complexity budget question" "What's the target complexity budget\\?"
check_forbidden_pattern "old roadmap duration field" '^.*Estimated review time per report.*$'

if ((failures > 0)); then
  echo "Forbidden pattern check failed."
  exit 1
fi

echo "Forbidden pattern check passed."
