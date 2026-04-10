#!/usr/bin/env bash
set -euo pipefail

echo "Activating feature 'copilot'"

AGENT_DOCK_HOME="${AGENT_DOCK_HOME:-/mnt/agent-dock}"

mkdir -p -m 1777 \
  "${AGENT_DOCK_HOME}/.copilot" \
  "${AGENT_DOCK_HOME}/lib/copilot"

cp -a \
  ./lib/. \
  "${AGENT_DOCK_HOME}/lib/copilot/"
