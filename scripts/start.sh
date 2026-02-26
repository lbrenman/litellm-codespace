#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"

# Load .env
if [ -f "$ROOT_DIR/.env" ]; then
  set -a
  source "$ROOT_DIR/.env"
  set +a
fi

# Ensure data dir exists
mkdir -p "$ROOT_DIR/data/litellm"

PORT="${LITELLM_PORT:-4000}"
CONFIG="$ROOT_DIR/config/litellm_config.yaml"

echo "🚀 Starting LiteLLM proxy on port $PORT..."
echo "   Config: $CONFIG"
echo "   Data:   $ROOT_DIR/data/litellm/litellm.db"
echo ""
echo "   Proxy URL:  http://localhost:$PORT"
echo "   Swagger UI: http://localhost:$PORT/docs"
echo "   Health:     http://localhost:$PORT/health"
echo ""

litellm \
  --config "$CONFIG" \
  --port "$PORT" \
  --detailed_debug
