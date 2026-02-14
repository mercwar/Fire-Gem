#!/bin/bash
# =============================================================
#  AVIS-SMITHY: BOOTSTRAP [VERSION 1]
#  FILE: fire-gem.sh
# =============================================================
set -e
mkdir -p "VERSION 1/fire-log"

# 1. FORGE CORE
nasm -f elf64 "VERSION 1/fire-log.asm" -o "VERSION 1/fire-log.o"
nasm -f elf64 "VERSION 1/fire-gem.asm" -o "VERSION 1/fire-gem.o"

# 2. LINK CORE
ld "VERSION 1/fire-gem.o" "VERSION 1/fire-log.o" -o "VERSION 1/fire-gem.exe"

# 3. RECURSIVE LOOP
echo "[AVIS-SH] Loading Extensions..."
for f in "VERSION 1"/*.asm; do
    name=$(basename "$f" .asm)
    if [[ "$name" != "fire-gem" && "$name" != "fire-log" ]]; then
        echo "[AVIS-SH] Forging Extension: $name"
        nasm -f elf64 "$f" -o "VERSION 1/$name.o"
        # LINK ONLY TO LOG
        ld "VERSION 1/$name.o" "VERSION 1/fire-log.o" -o "VERSION 1/$name.exe"
    fi
done

"./VERSION 1/fire-gem.exe"
