#!/bin/bash
# VERSION 1/fire-gem.sh
set -e

# 1. Forge the Master Objects
nasm -f elf64 "VERSION 1/fire-log.asm" -o "VERSION 1/fire-log.o"
nasm -f elf64 "VERSION 1/fire-gem.asm" -o "VERSION 1/fire-gem.o"

# 2. LINKER STRIKE
ld "VERSION 1/fire-gem.o" "VERSION 1/fire-log.o" -o "VERSION 1/fire-gem.exe"

# 3. HANDOFF
"./VERSION 1/fire-gem.exe"
