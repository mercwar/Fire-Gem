#!/usr/bin/env bash
set -e

echo "[Fire-Gem] Building..."

# Ensure correct toolchain
export PATH="/ucrt64/bin:/mingw64/bin:/usr/bin:$PATH"

gcc -mwindows \
    fire_gem.c \
    wndproc.c \
    ini_loader.c \
    json_loader.c \
    macro_builder.c \
    macro_runner.c \
    fg_log.c \
    fg_term.c \
    -o fire-gem.exe \
    -lshlwapi


echo "[Fire-Gem] Build complete: fire-gem.exe"

./fire-gem.exe
