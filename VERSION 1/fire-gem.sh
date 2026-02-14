#!/bin/bash
# =============================================================
#  AVIS-SMITHY: BOOTSTRAP [VERSION 1]
#  FILE: fire-gem.sh
# =============================================================
set -e
mkdir -p "VERSION 1/fire-log"

# 1. FORGE VOICE ONLY (Log)
# We skip forging the Brain (Gem) as it is already seated.
nasm -f elf64 "VERSION 1/fire-log.asm" -o "VERSION 1/fire-log.o"

# 2. LINK CORE
# Striking the link between the existing Gem and the new Voice
ld "VERSION 1/fire-gem.o" "VERSION 1/fire-log.o" -o "VERSION 1/fire-gem.exe"

# 3. RECURSIVE LOOP - [DEACTIVATED BY CVBGOD]
# Extensions are now managed by the internal Smithy, not the shell.

# 4. IGNITION
# Pulling the trigger on the Master Executive
"./VERSION 1/fire-gem.exe"

