#!/usr/bin/env bash
set -euo pipefail

AGENT_DOCK_HOME="${AGENT_DOCK_HOME:-/mnt/agent-dock}"

if [[ -d ~/.profile.d ]]; then
  cp "${AGENT_DOCK_HOME}/lib/copilot/env.sh" ~/.profile.d/copilot.sh
elif [[ -f ~/.profile ]]; then
  echo >> ~/.profile
  cat "${AGENT_DOCK_HOME}/lib/copilot/env.sh" >> ~/.profile
fi

curl -fsSL https://gh.io/copilot-install | bash
