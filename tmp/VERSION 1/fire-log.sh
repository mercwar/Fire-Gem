#!/bin/bash
# AVIS-LOG BRIDGE: WIPE ON INIT | APPEND ON STRIKE
TXT="VERSION 1/fire-gem-txt.log"
[ "$1" == "INIT" ] && echo "[AVIS-SH] $(date -u): SECTOR_CLEANED. HAHA!" > "$TXT" || echo "[AVIS-SH] $(date -u): $1" >> "$TXT"
