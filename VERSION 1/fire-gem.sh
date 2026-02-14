#!/bin/bash
# =============================================================================
#  AVIS-SMITHY: DUMB BOOTSTRAP [CVBGOD AUTHORITY]
#  FILE: fire-gem.sh
#  PURPOSE: Forge ONLY Log and Gem. No Smithy in the Shell.
# =============================================================================
set -e

# 1. INITIALIZE VAULT
mkdir -p "VERSION 1/fire-log"

# 2. THE DUMB FORGE: Voice (log) and Brain (gem)
nasm -f elf64 "VERSION 1/fire-log.asm" -o "VERSION 1/fire-log.o"
nasm -f elf64 "VERSION 1/fire-gem.asm" -o "VERSION 1/fire-gem.o"

# 3. THE DUMB LINKER STRIKE
# Fuses the Brain and Voice into a single hardware executive.
ld "VERSION 1/fire-gem.o" "VERSION 1/fire-log.o" -o "VERSION 1/fire-gem.exe"

# 4. THE EXTENSION LOOP (Log-Linked Only)
# Sweeps for extensions and links them ONLY to the Voice.
echo "[AVIS-SH] Loading Extensions..."
for f in "VERSION 1"/*.asm; do
    name=$(basename "$f" .asm)
    if [[ "$name" != "fire-gem" && "$name" != "fire-log" ]]; then
        nasm -f elf64 "$f" -o "VERSION 1/$name.o"
        ld "VERSION 1/$name.o" "VERSION 1/fire-log.o" -o "VERSION 1/$name.exe"
    fi
done

# 5. TOTAL HANDOFF TO ASM AUTHORITY
# fire-gem.exe will now use fire-compile.ini to build the Smith.
echo "[AVIS-SH] Handoff to fire-gem.exe. HAHA!"
"./VERSION 1/fire-gem.exe"
