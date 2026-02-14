#!/bin/bash
# VERSION 1/fire-gem.sh [CVBGOD AUTHORITY]
set -e

ASM_INI="VERSION 1/fire-asm.ini"

echo "[AVIS-SH] CVBGOD Smithy: Striking Forge Manifest..."

# 1. Execute the forged NASM and LD commands from the INI
# Using eval to run the hardware-level strings
eval $(grep "CMD_LOG_OBJ:" "$ASM_INI" | cut -d':' -f2-)
eval $(grep "CMD_GEM_OBJ:" "$ASM_INI" | cut -d':' -f2-)
eval $(grep "CMD_GEM_LNK:" "$ASM_INI" | cut -d':' -f2-)
eval $(grep "CMD_END_OBJ:" "$ASM_INI" | cut -d':' -f2-)
eval $(grep "CMD_END_LNK:" "$ASM_INI" | cut -d':' -f2-)

# 2. Sequential Build for the remaining chain
for f in "VERSION 1"/*.asm; do
    name=$(basename "$f" .asm)
    if [[ "$name" != "fire-gem" && "$name" != "fire-log" && "$name" != "fire-end" ]]; then
        echo "[AVIS-SH] Forging: $name"
        nasm -f elf64 "$f" -o "VERSION 1/$name.o"
        ld "VERSION 1/$name.o" "VERSION 1/fire-log.o" -o "VERSION 1/$name.exe"
    fi
done

echo "[AVIS-SH] Forge Complete. Ignition sequence start. HAHA!"
"./VERSION 1/fire-gem.exe"
