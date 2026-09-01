@echo off
cd /d "%~dp0"

if exist firegem.exe (
    echo.
    echo ============================================================
    echo ✅ Launching Fire Gem...
    echo ============================================================
    echo.
    firegem.exe
) else (
    echo.
    echo ============================================================
    echo ❌ ERROR: firegem.exe not found . 
    echo ============================================================
)

pause