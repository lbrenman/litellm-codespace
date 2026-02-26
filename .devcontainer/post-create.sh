#!/bin/bash
set -e

echo "🚀 Setting up LiteLLM Codespace..."

# Create persistent data directory (backed by named volume in devcontainer.json)
mkdir -p /workspace/data/litellm

# Copy .env.example to .env if it doesn't exist yet
if [ ! -f /workspace/.env ]; then
  cp /workspace/.env.example /workspace/.env
  echo "📋 Created .env from .env.example — add your API keys!"
fi

echo ""
echo "✅ Setup complete!"
echo ""
echo "Next steps:"
echo "  1. Add your API keys as Codespace Secrets (github.com/settings/codespaces)"
echo "     OR edit /workspace/.env directly (don't commit it!)"
echo "  2. Edit /workspace/config/litellm_config.yaml to add/remove models"
echo "  3. Run: bash scripts/start.sh"
echo ""
