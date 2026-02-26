#!/bin/bash
set -e

echo "🚀 Setting up LiteLLM Codespace..."

# Create persistent data directory (survives container rebuilds)
mkdir -p /workspace/data/litellm

# Copy .env.example to .env if it doesn't exist yet
if [ ! -f /workspace/.env ]; then
  cp /workspace/.env.example /workspace/.env
  echo "📋 Created .env from .env.example — add your API keys!"
fi

# Install helper CLI tools
pip install --quiet litellm httpie

echo ""
echo "✅ Setup complete!"
echo ""
echo "Next steps:"
echo "  1. Add your API keys to Codespace Secrets (Settings → Codespaces → Secrets)"
echo "     OR edit /workspace/.env directly (don't commit it!)"
echo "  2. Edit /workspace/config/litellm_config.yaml to add/remove models"
echo "  3. Run: bash scripts/start.sh"
echo ""
