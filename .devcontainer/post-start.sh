#!/bin/bash

echo "🔄 LiteLLM Codespace starting..."

# Ensure data directory exists
mkdir -p /workspace/data/litellm

# Load .env if it exists
if [ -f /workspace/.env ]; then
  set -a
  source /workspace/.env
  set +a
fi

# Auto-start LiteLLM if LITELLM_AUTOSTART=true
if [ "${LITELLM_AUTOSTART}" = "true" ]; then
  echo "⚡ Auto-starting LiteLLM proxy..."
  bash /workspace/scripts/start.sh &
fi

echo "✅ Ready. Run 'bash scripts/start.sh' to start the proxy."
