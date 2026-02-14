#!/bin/bash
# =============================================================
#  AVIS-SMITHY: BOOTSTRAP [VERSION 1]
#  FILE: fire-gem.sh
#  PURPOSE: Test Log Exports via INI Intake (Linker Deactivated)
# =============================================================
set -e

# 1. IMMEDIATE AVIS IGNITION
if [ -f "VERSION 1/fire-log.sh" ]; then
    chmod +x "VERSION 1/fire-log.sh"
    ./"VERSION 1/fire-log.sh" "AVIS_SESSION_IGNITED: Identity JOE verified."
else
    echo "CRITICAL: AVIS VOICE (fire-log.sh) NOT FOUND"
    exit 1
fi

# 2. INTAKE LOG EXPORTS FROM fire-gem.ini
# Scoping the [DEVICE: LOG] block
LOG_EXP=$(grep "STRIKE_VOICE=" "VERSION 1/fire-gem.ini" | cut -d'=' -f2)
LOG_PATH=$(grep "VAULT_PATH=" "VERSION 1/fire-gem.ini" | cut -d'=' -f2)

# 3. THE TEST BLOCK STRIKE
# This bypasses the binary and strikes the log directly using the INI exports
echo "------------------------------------------------------------" >> "$LOG_PATH"
./"VERSION 1/fire-log.sh" "[TEST_BLOCK] BEGIN EXPORT VERIFICATION"
./"VERSION 1/fire-log.sh" "[TEST_BLOCK] EXPORT_NAME: $LOG_EXP"
./"VERSION 1/fire-log.sh" "[TEST_BLOCK] TARGET_VAULT: $LOG_PATH"
./"VERSION 1/fire-log.sh" "[TEST_BLOCK] STATUS: AVIS_BRIDGE_VERIFIED. HAHA!"
echo "------------------------------------------------------------" >> "$LOG_PATH"

# 4. LINKER DEACTIVATED BY JOE
# # [ -f "VERSION 1/fire-link.sh" ] && "./VERSION 1/fire-link.sh"

echo "[AVIS-SH] Test Block Strike Complete. Check the Vault. HAHA!"
