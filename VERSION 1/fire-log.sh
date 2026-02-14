#!/bin/bash
# AVIS-LOG BRIDGE: WIPE ON INITIALIZATION | STRIKE ON CALL
TXT="VERSION 1/fire-gem.txt"

# IF CALL IS 'INIT', WIPE THE FILE. OTHERWISE, APPEND STRIKE.
[ "$1" == "INIT" ] && echo "[AVIS-SH] $(date -u): SECTOR_CLEANED. HAHA!" > "$TXT" || echo "[AVIS-SH] $(date -u): $1" >> "$TXT"
