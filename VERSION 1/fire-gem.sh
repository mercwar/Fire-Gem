#!/bin/bash
# =============================================================================
#  AVIS-SMITHY: VERSION 1 HARDCODE LOADER
#  FILE: fire-gem.sh
# =============================================================================
set -e

echo "[AVIS-SH] Smithy Engaged: Forging VERSION 1 Artifacts..."

# 1. Forge the Master Objects (Voice and Brain)
nasm -f elf64 "VERSION 1/fire-log.asm" -o "VERSION 1/fire-log.o"
nasm -f elf64 "VERSION 1/fire-gem.asm" -o "VERSION 1/fire-gem.o"

# 2. THE LINKER STRIKE: Fuse Brain and Voice
ld "VERSION 1/fire-gem.o" "VERSION 1/fire-log.o" -o "VERSION 1/fire-gem.exe"

# 3. Forge the remaining Chain Artifacts (FVS, Seed, Spec, Net, Site)
for f in "VERSION 1"/*.asm; do
    name=$(basename "$f" .asm)
    if [[ "$name" != "fire-gem" && "$name" != "fire-log" ]]; then
        echo "[AVIS-SH] Forging: $name"
        nasm -f elf64 "$f" -o "VERSION 1/$name.o"
        ld "VERSION 1/$name.o" "VERSION 1/fire-log.o" -o "VERSION 1/$name.exe"
    fi
done

# 4. Handoff to Version 1 Master Engine
echo "[AVIS-SH] Smithy Complete. Launching Master Engine. HAHA!"
"./VERSION 1/fire-gem.exe"
