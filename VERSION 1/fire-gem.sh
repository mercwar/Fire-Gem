#!/bin/bash
# =============================================================
#  AVIS-SMITHY: VOCAL BOOTSTRAP [VERSION 1]
#  FILE: fire-gem.sh
# =============================================================
set -e

# THE VOICE OF THE SHELL
strike_log() {
    ./"VERSION 1/fire-log.sh" "[AVIS-SH] $1"
}

# 0. THE PURGE
strike_log "PURGE_INIT: Cleaning Sector VERSION 1..."
rm -f "VERSION 1/"*.o "VERSION 1/"*.exe

# 1. FORGE CORE
strike_log "CORE_FORGE: Seating Brain and Voice..."
nasm -f elf64 "VERSION 1/fire-log.asm" -o "VERSION 1/fire-log.o"
nasm -f elf64 "VERSION 1/fire-gem.asm" -o "VERSION 1/fire-gem.o"

# 2. LINK CORE
strike_log "CORE_LINK: Fusing Triad into fire-gem.exe..."
ld "VERSION 1/fire-gem.o" "VERSION 1/fire-log.o" -o "VERSION 1/fire-gem.exe"

# 3. RECURSIVE LOOP
strike_log "RECURSIVE_FORGE: Sweeping extensions..."
for f in "VERSION 1"/*.asm; do
    name=$(basename "$f" .asm)
    if [[ "$name" != "fire-gem" && "$name" != "fire-log" ]]; then
        strike_log "EXT_STRIKE: Forging $name.o"
        nasm -f elf64 "$f" -o "VERSION 1/$name.o"
        ld "VERSION 1/$name.o" "VERSION 1/fire-log.o" -o "VERSION 1/$name.exe"
    fi
done

# 4. IGNITION
strike_log "IGNITION: Handoff to Master Executive. HAHA!"
"./VERSION 1/fire-gem.exe"
