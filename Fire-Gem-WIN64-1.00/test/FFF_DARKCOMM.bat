@echo off
setlocal enabledelayedexpansion

:: [AVIS_COORD: C:\Apache24\htdocs\FIRE-GEM | FILE: LLM.bat]
:: AVIS_COMMENT: GUFF_INIT_SEQUENCE

:: Switch to correct drive
REM C:
set "FIRE_PATH=fire-gem-android\test"
cd "\Apache24\htdocs\%FIRE_PATH%"
set "EXE_FILE=test"
::set "EXE_FILE2=FFF_DARKCOMM2"
:: MSYS2 launcher
set "MSYS_CMD=C:\msys64\msys2_shell.cmd"

:: Log file
set "LOG_FILE=C:\Apache24\htdocs\%FIRE_PATH%\%EXE_FILE%.log"

:: POSIX path to the shell script
set "SH_PATH=/c/Apache24/htdocs/%FIRE_PATH%/%EXE_FILE%.sh"
::set "SH_PATH=/c/Apache24/htdocs/%FIRE_PATH%/%EXE_FILE2%.sh"


type nul > "%LOG_FILE%"

"%MSYS_CMD%" -ucrt64 -defterm -no-start -here -c "\"%SH_PATH%\"" >> "%LOG_FILE%" 2>&1

exit /b 0
