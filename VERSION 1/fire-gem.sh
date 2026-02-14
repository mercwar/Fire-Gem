#!/bin/bash
# VERSION 1/fire-gem.sh
set -e

# 1. Forge the Encapsulator
nasm -f elf64 "VERSION 1/fire-log.asm" -o "VERSION 1/fire-log.o"

# 2. Forge and Link the Engine
nasm -f elf64 "VERSION 1/fire-gem.asm" -o "VERSION 1/fire-gem.o"
ld "VERSION 1/fire-gem.o" "VERSION 1/fire-log.o" -o "VERSION 1/fire-gem.exe"

# 3. Forge the Rest of the Chain
for f in "VERSION 1"/*.asm; do
    name=$(basename "$f" .asm)
    if [[ "$name" != "fire-gem" && "$name" != "fire-log" ]]; then
        nasm -f elf64 "$f" -o "VERSION 1/$name.o"
        ld "VERSION 1/$name.o" "VERSION 1/fire-log.o" -o "VERSION 1/$name.exe"
    fi
done

# 4. Ignition
"./VERSION 1/fire-gem.exe"
