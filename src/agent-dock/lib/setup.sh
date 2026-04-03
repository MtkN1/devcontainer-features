#!/usr/bin/env bash
set -e

# dotfiles
cp -rT "${AGENT_DOCK_BASE_DIR}/share/dotfiles/skel/" "${HOME}/"
mkdir "${HOME}/.profile.d" "${HOME}/.bashrc.d"

# mise
if ! command -v mise >/dev/null 2>&1; then
  curl -fL https://mise.run | sh
  cp -T "${AGENT_DOCK_BASE_DIR}/share/dotfiles/bashrc.d/mise.sh" "${HOME}/.bashrc.d/mise.sh"
fi

source "${AGENT_DOCK_BASE_DIR}/lib/env.sh"
tools=()

# Claude Code
if [[ $AGENT_DOCK_INSTALL_CLAUDE_CODE == "true" ]]; then
  if [[ -z $CLAUDE_CONFIG_DIR ]]; then
    claude_config_dir="${HOME}/.claude"
    claude_json_path="${HOME}/.claude.json"
  else
    claude_config_dir="${CLAUDE_CONFIG_DIR}"
    claude_json_path="${CLAUDE_CONFIG_DIR}/.claude.json"
  fi
  mkdir --parents "$claude_config_dir"
  cp -T "${AGENT_DOCK_BASE_DIR}/share/claude/settings.json" "${claude_config_dir}/settings.json"
  cp -T "${AGENT_DOCK_BASE_DIR}/share/claude/.claude.json" "${claude_json_path}"
  ln -sf "${AGENT_DOCK_BASE_DIR}/secrets/claude.json" "${claude_config_dir}/.credentials.json"

  if [[ ! " ${tools[*]} " =~ " node " ]]; then
    tools+=("node")
  fi
  tools+=("npm:@anthropic-ai/claude-code")
fi

# Codex CLI
if [[ $AGENT_DOCK_INSTALL_CODEX_CLI == "true" ]]; then
  codex_home="${CODEX_HOME:-${HOME}/.codex}"
  mkdir --parents "${codex_home}"
  cat "${AGENT_DOCK_BASE_DIR}/share/codex/config.toml" | envsubst '$PWD' > "${codex_home}/config.toml"
  ln -sf "${AGENT_DOCK_BASE_DIR}/secrets/codex.json" "${codex_home}/auth.json"

  if [[ ! " ${tools[*]} " =~ " node " ]]; then
    tools+=("node")
  fi
  tools+=("npm:@openai/codex")
fi

# Gemini CLI
if [[ $AGENT_DOCK_INSTALL_GEMINI_CLI == "true" ]]; then
  gemini_cli_home="${GEMINI_CLI_HOME:-${HOME}/.gemini}"
  mkdir --parents "${gemini_cli_home}"
  cp -T "${AGENT_DOCK_BASE_DIR}/share/dotfiles/bashrc.d/gemini.sh" "${HOME}/.bashrc.d/gemini.sh"
  cp -T "${AGENT_DOCK_BASE_DIR}/share/gemini/settings.json" "${gemini_cli_home}/settings.json"
  cp -T "${AGENT_DOCK_BASE_DIR}/share/gemini/trustedFolders.json" "${gemini_cli_home}/trustedFolders.json"
  ln -sf "${AGENT_DOCK_BASE_DIR}/secrets/gemini.json" "${gemini_cli_home}/oauth_creds.json"

  if [[ ! " ${tools[*]} " =~ " node " ]]; then
    tools+=("node")
  fi
  tools+=("npm:@google/gemini-cli")
fi

# GitHub Copilot CLI
if [[ $AGENT_DOCK_INSTALL_GITHUB_COPILOT_CLI == "true" ]]; then
  copilot_home="${COPILOT_HOME:-${HOME}/.copilot}"
  gh_config_dir="${GH_CONFIG_DIR:-${HOME}/.config/gh}"
  mkdir --parents "${copilot_home}" "${gh_config_dir}"
  cp -T "${AGENT_DOCK_BASE_DIR}/share/dotfiles/bashrc.d/copilot.sh" "${HOME}/.bashrc.d/copilot.sh"
  cp -T "${AGENT_DOCK_BASE_DIR}/share/copilot/config.json" "${copilot_home}/config.json"
  ln -sf "${AGENT_DOCK_BASE_DIR}/secrets/gh.yml" "${gh_config_dir}/hosts.yml"

  if [[ ! " ${tools[*]} " =~ " node " ]]; then
    tools+=("node")
  fi
  tools+=("aqua:cli/cli" "npm:@github/copilot")
fi

# Install
if (( ${#tools[@]} > 0 )) ; then
  mise use -g "${tools[@]}"
fi
