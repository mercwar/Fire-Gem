#!/bin/bash
# =============================================================================
#  AVIS-SMITHY: VERSION 1 HARDCODE LOADER [CVBGOD AUTHORITY]
#  FILE: fire-gem.sh
# =============================================================================
set -e

# 1. Forge the Global Voice (fire-log) and RPC Surface (fire-net)
nasm -f elf64 "VERSION 1/fire-log.asm" -o "VERSION 1/fire-log.o"
nasm -f elf64 "VERSION 1/fire-net.asm" -o "VERSION 1/fire-net.o"
nasm -f elf64 "VERSION 1/fire-gem.asm" -o "VERSION 1/fire-gem.o"

# 2. THE LINKER STRIKE: Fuse Brain, Voice, and Network
ld "VERSION 1/fire-gem.o" "VERSION 1/fire-log.o" -o "VERSION 1/fire-gem.exe"
ld "VERSION 1/fire-net.o" "VERSION 1/fire-log.o" -o "VERSION 1/fire-net.exe"

# 3. Forge the remaining Chain Artifacts
for f in "VERSION 1"/*.asm; do
    name=$(basename "$f" .asm)
    if [[ "$name" != "fire-gem" && "$name" != "fire-log" && "$name" != "fire-net" ]]; then
        nasm -f elf64 "$f" -o "VERSION 1/$name.o"
        ld "VERSION 1/$name.o" "VERSION 1/fire-log.o" -o "VERSION 1/$name.exe"
    fi
done

# 4. Handoff to Version 1 Master Engine
"./VERSION 1/fire-gem.exe"
