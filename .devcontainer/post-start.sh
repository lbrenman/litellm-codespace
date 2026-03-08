#!/bin/bash

mkdir -p /workspace/data/litellm

LOG=/workspace/data/litellm/autostart.log

# Load .env
while IFS= read -r line; do
  [[ "$line" =~ ^#.*$ ]] && continue
  [[ -z "$line" ]] && continue
  export "$line"
done < /workspace/.env

# Use setsid to fully detach litellm from this shell session
setsid litellm --config /workspace/config/litellm_config.yaml --port 4000 > "$LOG" 2>&1 < /dev/null &

echo "✅ LiteLLM started. Logs: $LOG"
