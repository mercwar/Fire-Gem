#!/bin/bash
# VERSION 1/fire-gem.sh
set -e

# Compile the core first
nasm -f elf64 "VERSION 1/fire-log.asm" -o "VERSION 1/fire-log.o"
nasm -f elf64 "VERSION 1/fire-gem.asm" -o "VERSION 1/fire-gem.o"
ld "VERSION 1/fire-gem.o" "VERSION 1/fire-log.o" -o "VERSION 1/fire-gem.exe"

# Compile everything else in the Version 1 sector
for f in "VERSION 1"/*.asm; do
    name=$(basename "$f" .asm)
    if [ "$name" != "fire-gem" ] && [ "$name" != "fire-log" ]; then
        nasm -f elf64 "$f" -o "VERSION 1/$name.o"
        ld "VERSION 1/$name.o" "VERSION 1/fire-log.o" -o "VERSION 1/$name.exe"
    fi
done

# Handoff to Version 1 Master Engine
"./VERSION 1/fire-gem.exe"
