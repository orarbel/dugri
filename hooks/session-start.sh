#!/usr/bin/env bash
# Puts the dugri voice into every session. The skill body is the single source.
set -euo pipefail
echo "dugri plugin is on. Use the voice below for every reply in this session, until the user says \"stop dugri\" or \"normal mode\"."
echo
awk 'BEGIN{n=0} /^---$/ && n<2 {n++; next} n>=2' "${CLAUDE_PLUGIN_ROOT}/skills/dugri/SKILL.md"
