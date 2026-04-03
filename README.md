# devcontainer-features

## Agent Dock

Installs AI coding agent CLIs into your dev container.

| Tool | Default |
|------|---------|
| [Claude Code](https://github.com/anthropics/claude-code) | ✓ |
| [Codex CLI](https://github.com/openai/codex) | ✓ |
| [Gemini CLI](https://github.com/google-gemini/gemini-cli) | ✓ |
| [GitHub Copilot CLI](https://github.com/github/copilot.vim) | ✓ |

Credentials are stored in a shared Docker volume (`agent-dock`). This lets you reuse credentials across containers without re-logging in each time.

#### Usage

Add to your `devcontainer.json`:

```json
{
  "features": {
    "ghcr.io/mtkn1/devcontainer-features/agent-dock:0": {}
  }
}
```

#### Options

```json
{
  "features": {
    "ghcr.io/mtkn1/devcontainer-features/agent-dock:0": {
      "installClaudeCode": true,
      "installCodexCli": true,
      "installGeminiCli": true,
      "installGitHubCopilotCli": true
    }
  }
}
```
