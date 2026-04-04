#!/usr/bin/env bash
# [AVIS_COORD: /c/Apache24/htdocs/FIRE-GEM/LLM | FILE: BUILD_AVIS_CORE.sh]

echo "[AVIS] DEPLOYING WIN64 NEURAL ARCHITECTURE..."
set -euo pipefail

ROOT="/c/Apache24/htdocs/FIRE-GEM/LLM"
BIN_DIR="${ROOT}/BIN"
INC_DIR="${ROOT}/INCLUDE"
LIB_DIR="${ROOT}/lib"

# Ensure BIN directory exists
mkdir -p "${BIN_DIR}"

# Compiler Definitions
CC=gcc
CXX=g++

# CFLAGS: -municode for wWinMain, -m64 for Win64, -std=c++17 for llama.cpp logic
CFLAGS="-municode -m64 -O3 -Wall -I${INC_DIR} -I${ROOT} -DUNICODE -D_UNICODE"
CXXFLAGS="${CFLAGS} -std=c++17"

# LDFLAGS: -mwindows removes the console window.
LDFLAGS="-L${LIB_DIR} -mwindows \
  -Wl,--start-group \
    ${LIB_DIR}/ggml-cpu.a \
    ${LIB_DIR}/ggml-base.a \
    ${LIB_DIR}/ggml.a \
    ${LIB_DIR}/libllama.a \
  -Wl,--end-group \
  -lgomp \
  -lstdc++ -lpthread \
  -lkernel32 -luser32 -lgdi32 -lcomctl32 -lshell32 -lshlwapi
"

echo "[AVIS] COMPILING NEURAL WRAPPER..."
${CXX} ${CXXFLAGS} -c "${ROOT}/avis_llama.cpp" -o "${ROOT}/avis_llama.o"

echo "[AVIS] COMPILING FILE NAVIGATOR..."
${CC} ${CFLAGS} -c "${ROOT}/fire-list.c" -o "${ROOT}/fire-list.o"

echo "[AVIS] STITCHING WIN64 BINARY..."
${CXX} ${CXXFLAGS} \
  "${ROOT}/main.c" \
  "${ROOT}/avis_dispatcher.c" \
  "${ROOT}/avis_terminal.c" \
  "${ROOT}/avis_llama.o" \
  "${ROOT}/fire-list.o" \
  -o "${BIN_DIR}/FIREGEM.exe" ${LDFLAGS}

if [ $? -eq 0 ]; then
    echo "[SUCCESS] FIREGEM.exe IS NOW A NATIVE WIN64 PROGRAM."
    cd "${BIN_DIR}" && ./FIREGEM.exe
else
    echo "[CRITICAL] BUILD FAILED. CHECK SECTOR LOGS."
    exit 1
fi
