#!/bin/bash
# =============================================================================
#  AVIS-SMITHY: TRIAD BOOTSTRAP + RECURSIVE LOOP [CVBGOD AUTHORITY]
#  FILE: fire-gem.sh
#  PURPOSE: Forge Core Triad & Automatically Sweep Extensions
# =============================================================================
set -e

# 1. INITIALIZE VAULT
mkdir -p "VERSION 1/fire-log"

# 2. THE TRIAD FORGE: Voice (log), Smith (compile), Brain (gem)
# These are the mandatory anchors for the entire chain.
nasm -f elf64 "VERSION 1/fire-log.asm" -o "VERSION 1/fire-log.o"
nasm -f elf64 "VERSION 1/fire-compile.asm" -o "VERSION 1/fire-compile.o"
nasm -f elf64 "VERSION 1/fire-gem.asm" -o "VERSION 1/fire-gem.o"

# 3. THE LINKER STRIKE: Fuses the Supreme Executive
# fire-gem.exe now contains the Brain, the Smith, and the Voice.
ld "VERSION 1/fire-gem.o" \
   "VERSION 1/fire-compile.o" \
   "VERSION 1/fire-log.o" \
   -o "VERSION 1/fire-gem.exe"

# 4. THE RECURSIVE LOOP: Automatic Extension Loading
# Sweeps the sector for Macro, Term, Net, and any future .asm stubs.
echo "[AVIS-SH] Striking Recursive Loop for Extensions..."
for f in "VERSION 1"/*.asm; do
    name=$(basename "$f" .asm)
    # Skip the Triad (already forged)
    if [[ "$name" != "fire-gem" && "$name" != "fire-log" && "$name" != "fire-compile" ]]; then
        echo "[AVIS-SH] Forging Extension: $name"
        nasm -f elf64 "$f" -o "VERSION 1/$name.o"
        # Link every extension against the Global Voice
        ld "VERSION 1/$name.o" "VERSION 1/fire-log.o" -o "VERSION 1/$name.exe"
    fi
done

# 5. TOTAL HANDOFF TO ASM AUTHORITY
echo "[AVIS-SH] Handoff to fire-gem.exe. HAHA!"
"./VERSION 1/fire-gem.exe"
