#!/bin/bash

echo "🔄 LiteLLM Codespace starting..."

# Ensure data directory exists
mkdir -p /workspace/data/litellm

# Load .env using export on each line (works in non-interactive shells)
if [ -f /workspace/.env ]; then
  while IFS='=' read -r key value; do
    # Skip comments and empty lines
    [[ "$key" =~ ^#.*$ ]] && continue
    [[ -z "$key" ]] && continue
    # Strip inline comments and surrounding quotes from value
    value=$(echo "$value" | sed 's/#.*//' | xargs)
    export "$key=$value"
  done < /workspace/.env
fi

# Auto-start LiteLLM if LITELLM_AUTOSTART=true
if [ "${LITELLM_AUTOSTART}" = "true" ]; then
  echo "⚡ Auto-starting LiteLLM proxy..."
  nohup bash /workspace/scripts/start.sh > /workspace/data/litellm/autostart.log 2>&1 &
  echo "   Logs: /workspace/data/litellm/autostart.log"
fi

echo "✅ Ready."