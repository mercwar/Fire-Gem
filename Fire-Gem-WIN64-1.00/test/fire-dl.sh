#!/usr/bin/env bash

ROOT_DIR="$(pwd)"
EXEC_DIR="$ROOT_DIR/exec"
VERSION="$1"

if [ -z "$VERSION" ]; then
    echo "Usage: copy_test.sh <version>"
    exit 1
fi

DEST="$EXEC_DIR/$VERSION"

mkdir -p "$DEST"

if [ ! -f "test.exe" ]; then
    echo "ERROR: test.exe not found in current directory."
    exit 1
fi

cp -f "test.exe" "$DEST/"

echo "Copied test.exe to $DEST/"
