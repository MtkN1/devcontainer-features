# Agent Dock

Installs AI agent CLIs into your dev container.

| Tool | Feature ID |
|------|---------|
| [Claude Code](https://code.claude.com/docs/en/overview) | |
| [Codex CLI](https://developers.openai.com/codex) | |
| [Gemini CLI](https://geminicli.com/docs/) | |
| [GitHub Copilot CLI](https://docs.github.com/en/copilot/how-tos/copilot-cli) | `copilot` |

## Usage

Add to your `devcontainer.json`:

```json
{
  "features": {
    "ghcr.io/mtkn1/agent-dock/copilot:0": {}
  }
}
```
