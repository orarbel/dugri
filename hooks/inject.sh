#!/usr/bin/env bash
# Puts the dugri voice into the session.
# First hook call in a session (SessionStart, or the first prompt after a
# mid-session install) gets the full rules; later prompts get a one-line reminder.
set -uo pipefail
input=$(cat)
sid=$(printf '%s' "$input" | sed -n 's/.*"session_id"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' | head -1)
marker="${TMPDIR:-/tmp}/dugri-sessions/${sid:-unknown}"

if [ "${1:-}" = "start" ] || [ ! -e "$marker" ]; then
  mkdir -p "$(dirname "$marker")" && touch "$marker"
  echo "dugri plugin is on. Use the voice below for every reply in this session, until the user says \"stop dugri\" or \"normal mode\"."
  echo
  awk 'BEGIN{n=0} /^---$/ && n<2 {n++; next} n>=2' "${CLAUDE_PLUGIN_ROOT}/skills/dugri/SKILL.md"
else
  echo "dugri is on: answer this in the dugri voice (talk like an Israeli, verdict first, literal-English Hebrew idioms, no transliteration), unless the user said \"stop dugri\"."
fi
