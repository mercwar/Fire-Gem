#!/bin/bash
# =============================================================
#  AVIS-SMITHY: VOCAL BOOTSTRAP [VERSION 1]
#  FILE: fire-gem.sh
# =============================================================
set -e

# LOG FUNCTION - THE SHELL'S VOICE
strike_log() {
    ./"VERSION 1/fire-log.sh" "[AVIS-SH] $1"
}

strike_log "SH_IGNITION: Sector VERSION 1 Secured."

# 1. FORGE VOICE
nasm -f elf64 "VERSION 1/fire-log.asm" -o "VERSION 1/fire-log.o"
strike_log "VOICE_FORGED: fire-log.o Seated."

# 2. LINK CORE
# Fusing existing Gem with the new Voice
ld "VERSION 1/fire-gem.o" "VERSION 1/fire-log.o" -o "VERSION 1/fire-gem.exe"
strike_log "CORE_LINKED: fire-gem.exe Ignited."

# 3. INTERNAL HANDOFF
strike_log "HANDOFF: Master Brain Seizing Control. HAHA!"
"./VERSION 1/fire-gem.exe"
