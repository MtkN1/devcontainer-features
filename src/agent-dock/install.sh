#!/usr/bin/env bash
set -e

echo "Activating feature 'agent-dock'"

mkdir \
  "${AGENT_DOCK_BASE_DIR}" \
  "${AGENT_DOCK_BASE_DIR}/secrets"

cp -r \
  ./lib/ \
  ./share/ \
  "${AGENT_DOCK_BASE_DIR}/"

agent_dock_env="${AGENT_DOCK_BASE_DIR}/lib/env.sh"
touch "$agent_dock_env"
if [[ $INSTALLCLAUDECODE == "true" ]]; then
  echo "AGENT_DOCK_INSTALL_CLAUDE_CODE=true" >> "$agent_dock_env"
fi
if [[ $INSTALLCODEXCLI == "true" ]]; then
  echo "AGENT_DOCK_INSTALL_CODEX_CLI=true" >> "$agent_dock_env"
fi
if [[ $INSTALLGEMINICLI == "true" ]]; then
  echo "AGENT_DOCK_INSTALL_GEMINI_CLI=true" >> "$agent_dock_env"
fi
if [[ $INSTALLGITHUBCOPILOTCLI == "true" ]]; then
  echo "AGENT_DOCK_INSTALL_GITHUB_COPILOT_CLI=true" >> "$agent_dock_env"
fi

touch \
  "${AGENT_DOCK_BASE_DIR}/secrets/claude.json" \
  "${AGENT_DOCK_BASE_DIR}/secrets/codex.json" \
  "${AGENT_DOCK_BASE_DIR}/secrets/gemini.json" \
  "${AGENT_DOCK_BASE_DIR}/secrets/gh.yml"

chmod -R 1777 \
  "${AGENT_DOCK_BASE_DIR}/secrets"
