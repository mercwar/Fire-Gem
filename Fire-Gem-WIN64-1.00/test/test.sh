#!/usr/bin/env bash

echo "[build] test.sh running"
echo "[build] compiling test.c..."

# Ensure GCC is available
export PATH="/ucrt64/bin:/mingw64/bin:/usr/bin:$PATH"

# Compile test.c into test.exe (GUI WinMain version)
gcc -mwindows -v test.c -o test.exe
status=$?

if [ $status -ne 0 ]; then
    echo "[build] ERROR: gcc failed with code $status"
    exit $status
fi

echo "[build] running test.exe..."
./test.exe
runstatus=$?

echo "[build] program exited with code $runstatus"
echo "[build] script finished."
