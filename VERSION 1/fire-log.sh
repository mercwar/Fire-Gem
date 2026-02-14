#!/bin/bash
# AVIS-LOG BRIDGE
LOG_FILE="VERSION 1/fire-gem.log"
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
echo "[AVIS-YML-STRIKE] $TIMESTAMP: $1" >> "$LOG_FILE"
