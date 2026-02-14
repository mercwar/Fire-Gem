#!/bin/bash
# VERSION 1/fire-gem.sh
set -e

# 1. Forge the Master Objects
nasm -f elf64 "VERSION 1/fire-log.asm" -o "VERSION 1/fire-log.o"
nasm -f elf64 "VERSION 1/fire-gem.asm" -o "VERSION 1/fire-gem.o"

# 2. THE LINKER STRIKE
# Fuses the Voice and Brain into the Version 1 Executive
ld "VERSION 1/fire-gem.o" "VERSION 1/fire-log.o" -o "VERSION 1/fire-gem.exe"

# 3. Forge the remaining Chain Artifacts (Seed, Spec, FVS)
for f in "VERSION 1"/*.asm; do
    name=$(basename "$f" .asm)
    if [[ "$name" != "fire-gem" && "$name" != "fire-log" ]]; then
        nasm -f elf64 "$f" -o "VERSION 1/$name.o"
        ld "VERSION 1/$name.o" "VERSION 1/fire-log.o" -o "VERSION 1/$name.exe"
    fi
done

# 4. Launch the Executive
"./VERSION 1/fire-gem.exe"
