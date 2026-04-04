@echo off
:: [AVIS_COORD: C:\Apache24\htdocs\FIRE-GEM\LLM | FILE: BUILD_ASSISTANT.bat]
:: AVIS_COMMENT: LAUNCHES UCRT64 BUILD WITH PERSISTENT LOGGING

set "MSYS_CMD=C:\msys64\msys2_shell.cmd"
set "SH_PATH=/c/Apache24/htdocs/FIRE-GEM/LLM/FIRE-GEM.sh"
set "LOG_FILE=C:\Apache24\htdocs\FIRE-GEM\LLM\LOG\assistant_build.log"
taskkill //F //IM assistant.exe

if not exist "C:\Apache24\htdocs\FIRE-GEM\LLM\LOG" mkdir "C:\Apache24\htdocs\FIRE-GEM\LLM\LOG"

echo [AVIS] %DATE% %TIME% > "%LOG_FILE%"
echo [AVIS] Triggering UCRT64 Pipeline...
echo [LOG] Writing to: %LOG_FILE%

:: Execute shell script and pipe all output to the log
"%MSYS_CMD%" -ucrt64 -defterm -no-start -here -c "\"%SH_PATH%\"" >> "%LOG_FILE%" 2>&1

type "%LOG_FILE%"
pause
