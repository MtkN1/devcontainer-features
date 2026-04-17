#!/usr/bin/env bash
set -euo pipefail

AGENT_DOCK_HOME="${AGENT_DOCK_HOME:-/mnt/agent-dock}"

# Detect architecture
case "$(uname -m)" in
  x86_64|amd64) ARCH="x64" ;;
  aarch64|arm64) ARCH="arm64" ;;
  *) exit 1 ;;
esac

PREFIX="${AGENT_DOCK_HOME}/libexec/copilot/linux-${ARCH}"

if [[ ! -x "${PREFIX}/bin/copilot" ]]; then
  curl -fsSL https://gh.io/copilot-install | PATH="${PREFIX}/bin:/bin:/usr/bin" PREFIX="${PREFIX}" bash
fi

mkdir -p ~/.local/bin
cat > ~/.local/bin/copilot \
<< EOF
#!/bin/sh
"${PREFIX}/bin/copilot" --allow-all --enable-all-github-mcp-tools "\$@"
EOF
chmod +x ~/.local/bin/copilot
