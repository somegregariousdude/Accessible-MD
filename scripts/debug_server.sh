#!/bin/bash
# ==============================================================================
# SCRIPT: debug_server.sh (THEME DEV MODE)
# PURPOSE: Run Hugo using the exampleSite data/config
# ==============================================================================

LOG_FILE="errors.txt"

# Cleanup old processes
pkill hugo > /dev/null 2>&1

echo "--- New Session: $(date) ---" > "$LOG_FILE"
echo "Starting Hugo Server (Theme Mode)..."

# Run Hugo pointing to exampleSite
hugo server \
  --source exampleSite \
  --themesDir ../.. \
  --theme . \
  --disableFastRender \
  -D -E -F \
  --gc \
  --printI18nWarnings \
  > "$LOG_FILE" 2>&1 &

HUGO_PID=$!
echo "✅ Hugo is running using exampleSite (PID: $HUGO_PID)."
echo "📄 Logs: $LOG_FILE"
