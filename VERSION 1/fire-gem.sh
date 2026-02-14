#!/bin/bash
# =============================================================================
#  AVIS-SMITHY: VERSION 1 HARDCODE LOADER
#  FILE: fire-gem.sh
# =============================================================================
set -e

# 1. Forge Identity Artifacts
nasm -f elf64 "VERSION 1/fire-log.asm" -o "VERSION 1/fire-log.o"
nasm -f elf64 "VERSION 1/fire-gem.asm" -o "VERSION 1/fire-gem.o"

# 2. THE LINKER STRIKE
ld "VERSION 1/fire-gem.o" "VERSION 1/fire-log.o" -o "VERSION 1/fire-gem.exe"

# 3. Ignition
"./VERSION 1/fire-gem.exe"
