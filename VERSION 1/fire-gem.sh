#!/bin/bash
# =============================================================================
#  AVIS-SMITHY: DUMB BOOTSTRAP + EXTENSION LOOP [CVBGOD AUTHORITY]
#  FILE: fire-gem.sh
# =============================================================================
set -e

# 1. FORGE THE MANDATORY CORE (Log and Gem Only)
nasm -f elf64 "VERSION 1/fire-log.asm" -o "VERSION 1/fire-log.o"
nasm -f elf64 "VERSION 1/fire-gem.asm" -o "VERSION 1/fire-gem.o"

# 2. THE DUMB LINKER STRIKE
# Fuses the Brain and Voice into a single hardware executive.
ld "VERSION 1/fire-gem.o" "VERSION 1/fire-log.o" -o "VERSION 1/fire-gem.exe"

# 3. THE RECURSIVE EXTENSION LOOP
# Sweeps the sector for any .asm extension (ext-1, spec, seed, etc.)
# FORGES THEM AND LINKS THEM TO THE VOICE.
echo "[AVIS-SH] Striking Extensions..."
for f in "VERSION 1"/*.asm; do
    name=$(basename "$f" .asm)
    # Skip the Core
    if [[ "$name" != "fire-gem" && "$name" != "fire-log" ]]; then
        echo "[AVIS-SH] Loading Extension: $name"
        nasm -f elf64 "$f" -o "VERSION 1/$name.o"
        # Extensions only care about the Voice
        ld "VERSION 1/$name.o" "VERSION 1/fire-log.o" -o "VERSION 1/$name.exe"
    fi
done

# 4. IGNITION
"./VERSION 1/fire-gem.exe"
