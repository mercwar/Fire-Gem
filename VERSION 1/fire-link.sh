#!/bin/bash
# =============================================================
#  AVIS-LINKER // EXPORT FORGE [VERSION 1]
# =============================================================
set -e

# LOG TO TXT
./"VERSION 1/fire-log.sh" "LINK_STRIKE: Resolving _start Collision."

# THE SUPREME FUSION
# Linking Gem (The _start) + Compile (The Function) + Log (The Voice)
ld "VERSION 1/fire-gem.o" \
   "VERSION 1/fire-log.o" \
   "VERSION 1/fire-compile.o" \
   -o "VERSION 1/fire-gem.exe"

./"VERSION 1/fire-log.sh" "LINK_COMPLETE: _start Conflict Dead. HAHA!"
