# LiteLLM Proxy — GitHub Codespaces

A ready-to-use [LiteLLM](https://docs.litellm.ai/) proxy setup for GitHub Codespaces. Spin up a unified OpenAI-compatible API gateway in front of multiple LLM providers in seconds.

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/YOUR_ORG/YOUR_REPO)

---

## Features

- **One-click setup** via `devcontainer.json`
- **Persistent SQLite database** survives container rebuilds
- **Pre-configured models**: OpenAI, Anthropic, Azure, Gemini (add/remove as needed)
- **VS Code REST Client** requests file for instant testing
- **Codespace Secrets** support for keeping API keys out of your codebase

---

## Quick Start

### 1. Add your API keys as Codespace Secrets

Go to **GitHub → Settings → Codespaces → Secrets** and add any of:

| Secret Name | Description |
|---|---|
| `LITELLM_MASTER_KEY` | Auth key for your proxy (any string, e.g. `sk-mykey`) |
| `OPENAI_API_KEY` | OpenAI API key |
| `ANTHROPIC_API_KEY` | Anthropic API key |
| `AZURE_API_KEY` | Azure OpenAI API key |
| `AZURE_API_BASE` | Azure endpoint URL |
| `GEMINI_API_KEY` | Google Gemini API key |

> **Tip:** Only add keys for the providers you actually use.

### 2. Open the Codespace

Click the badge above or open this repo in a new Codespace. The `post-create.sh` script will auto-install dependencies on first launch.

### 3. Start the proxy

```bash
bash scripts/start.sh
```

The proxy starts on **port 4000**. Codespaces will prompt you to forward it — set visibility to **Public** if you need to call it from outside the Codespace.

### 4. Test it

```bash
# Run the smoke-test script
bash scripts/test.sh

# Or test a specific model
bash scripts/test.sh claude-haiku
```

Or open `requests.http` in VS Code and use the **REST Client** extension to send requests directly.

---

## Configuration

### Add / remove models

Edit [`config/litellm_config.yaml`](config/litellm_config.yaml). Uncomment the Azure/Gemini/Ollama sections or add any [LiteLLM-supported provider](https://docs.litellm.ai/docs/providers).

### Change proxy settings

Edit [`.env`](.env.example) (copy from `.env.example` first):

```bash
cp .env.example .env
```

| Variable | Default | Description |
|---|---|---|
| `LITELLM_MASTER_KEY` | `sk-changeme-masterkey` | Auth key for the proxy |
| `LITELLM_PORT` | `4000` | Port to run on |
| `LITELLM_AUTOSTART` | `false` | Auto-start proxy on Codespace resume |

---

## File Structure

```
.
├── .devcontainer/
│   ├── devcontainer.json    # Codespace config
│   ├── docker-compose.yml   # LiteLLM + volume mounts
│   ├── post-create.sh       # Runs once on first launch
│   └── post-start.sh        # Runs on every resume
├── config/
│   └── litellm_config.yaml  # Model list and router settings
├── data/
│   └── litellm/             # Persistent SQLite DB (gitignored)
├── scripts/
│   ├── start.sh             # Start the proxy
│   └── test.sh              # Smoke-test all endpoints
├── requests.http            # VS Code REST Client samples
└── .env.example             # Environment variable template
```

---

## Calling the proxy

The proxy is fully OpenAI-API-compatible. Point any OpenAI SDK at it:

```python
from openai import OpenAI

client = OpenAI(
    base_url="http://localhost:4000",
    api_key="sk-your-master-key"
)

response = client.chat.completions.create(
    model="claude-haiku",   # any model name from your config
    messages=[{"role": "user", "content": "Hello!"}]
)
print(response.choices[0].message.content)
```

---

## Persistence

The SQLite database at `data/litellm/litellm.db` stores virtual keys, spend logs, and model configs when `STORE_MODEL_IN_DB=true`. This directory is bind-mounted into the container so data persists across container rebuilds and Codespace restarts.

The `data/litellm/` folder is gitignored (only `.gitkeep` is tracked), so database files are never committed.
