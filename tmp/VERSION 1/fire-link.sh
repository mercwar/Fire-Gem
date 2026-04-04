#!/bin/bash
# =============================================================
#  AVIS-LINKER // EXPORT FORGE [VERSION 1]
#  FILE: fire-link.sh
# =============================================================
set -e
export TERM=xterm

INI="VERSION 1/fire-gem.ini"
# INTAKE EXPORT NAMES FROM ROOT
VOICE_EXP=$(grep "STRIKE_VOICE=" "$INI" | cut -d'=' -f2)
GCC_EXP=$(grep "STRIKE_GCC=" "$INI" | cut -d'=' -f2)

# PROFESSIONAL AVIS PROGRESS BAR
link_progress() {
    local label=$1
    echo -ne "\r[AVIS-LINK] $label [░░░░░░░░░░] 0%"
    sleep 0.1
    echo -ne "\r[AVIS-LINK] $label [▓▓▓▓▓▓▓▓▓▓] 100% DONE\n"
    # QUOTED BRIDGE CALL - THIS IS THE FIX FOR LINE 23
    "./VERSION 1/fire-log.sh" "LINKER_STRIKE: $label"
}

# 1. FORGE THE HARDWARE OBJECTS
link_progress "FORGING_CORE_OBJECTS"
nasm -f elf64 "VERSION 1/fire-log.asm" -o "VERSION 1/fire-log.o"
nasm -f elf64 "VERSION 1/fire-gem.asm" -o "VERSION 1/fire-gem.o"
nasm -f elf64 "VERSION 1/fire-compile.asm" -o "VERSION 1/fire-compile.o"

# 2. THE SUPREME LINK STRIKE
link_progress "EXECUTING_SYMBOL_FUSION"
ld "VERSION 1/fire-gem.o" \
   "VERSION 1/fire-log.o" \
   "VERSION 1/fire-compile.o" \
   -o "VERSION 1/fire-gem.exe"

# 3. VERIFY EXPORTS (Striking the NM check)
link_progress "VERIFYING_HARDWARE_VECTORS"
# ENSURING TXT_FILE IS WRAPPED IN QUOTES
TXT_FILE=$(grep "TXT_AUDIT=" "$INI" | cut -d'=' -f2)
nm "VERSION 1/fire-gem.exe" | grep -E "$VOICE_EXP|$GCC_EXP" >> "$TXT_FILE"

"./VERSION 1/fire-log.sh" "LINKER_COMPLETE: Symbols Seated. HAHA!"
