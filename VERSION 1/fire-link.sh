#!/bin/bash
# =============================================================
#  AVIS-LINKER // EXPORT FORGE [VERSION 1]
#  FILE: fire-link.sh
# =============================================================
set -e

TXT_FILE=$(grep "TXT_AUDIT=" "VERSION 1/fire-gem.ini" | cut -d'=' -f2)

# FORGE STRIKE
echo "[SH-STRIKE] $(date -u): LINKER_FORGE_START" >> "$TXT_FILE"

nasm -f elf64 "VERSION 1/fire-log.asm" -o "VERSION 1/fire-log.o"
nasm -f elf64 "VERSION 1/fire-gem.asm" -o "VERSION 1/fire-gem.o"
nasm -f elf64 "VERSION 1/fire-compile.asm" -o "VERSION 1/fire-compile.o"

# SUPREME LINK
ld "VERSION 1/fire-gem.o" "VERSION 1/fire-log.o" "VERSION 1/fire-compile.o" -o "VERSION 1/fire-gem.exe"

echo "[SH-STRIKE] $(date -u): LINKER_FORGE_COMPLETE" >> "$TXT_FILE"
