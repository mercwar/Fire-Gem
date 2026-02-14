#!/bin/bash
set -e
export TERM=xterm
INI="VERSION 1/fire-gem.ini"
TXT=$(grep "TXT_AUDIT=" "$INI" | cut -d'=' -f2)

# PROFESSIONAL AVIS PROGRESS BAR
avis_progress() {
    local label=$1
    echo -ne "\r[AVIS] $label [░░░░░░░░░░] 0%"
    sleep 0.1
    echo -ne "\r[AVIS] $label [▓▓▓▓▓▓░░░░] 60%"
    sleep 0.1
    echo -ne "\r[AVIS] $label [▓▓▓▓▓▓▓▓▓▓] 100% DONE\n"
    ./VERSION 1/fire-log.sh "$label COMPLETE"
}

# 1. ATOMIC PURGE
chmod +x "VERSION 1/fire-log.sh"
./VERSION 1/fire-log.sh "INIT"

# 2. VISUAL STRIKES
clear
echo "------------------------------------------------------------"
echo "  AVIS RECURSIVE ENGINE // IDENTITY: JOE TRON"
echo "------------------------------------------------------------"

avis_progress "SECTOR_INITIALIZATION"
mkdir -p "VERSION 1/fire-log"

avis_progress "HARDWARE_LINKER_STRIKE"
chmod +x "VERSION 1/fire-link.sh"
"./VERSION 1/fire-link.sh"

avis_progress "MASTER_BRAIN_IGNITION"
"./VERSION 1/fire-gem.exe"

# 3. AUDIT DUMP
echo "--- FINAL AUDIT [$TXT] ---"
cat "$TXT"


