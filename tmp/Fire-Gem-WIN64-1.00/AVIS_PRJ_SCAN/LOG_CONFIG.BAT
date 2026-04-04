@echo off
setlocal EnableExtensions

rem ============================================================================
rem AVIS PROJECT SCAN - LOG INITIALIZATION MODULE
rem ============================================================================
rem ROLE: Creates the primary log file and writes system environment headers.
rem FILE: LOG_CONFIG.BAT
rem ============================================================================

rem ----------------------------------------------------------------------------
rem STEP 7: PREPARE LOG FILE
rem ----------------------------------------------------------------------------
echo [AVIS] INITIALIZING OPERATION LOG...

(
    echo AVIS PROJECT SCAN LOG
    echo Generated: %DATE% %TIME%
    echo Removable Drive: %REMDRV%
    echo Project Root: %PROJECT_ROOT%
    echo App Root: %PROJECT_APPROOT%
    echo.
) > "%LOG_AI%"

echo [AVIS] STATUS        : LOG HEADER WRITTEN
echo [AVIS] TARGET FILE   : %LOG_FILE%

rem ----------------------------------------------------------------------------
rem STEP 8: VARIABLE EXPORT BRIDGE (THE PROTECTED BRIDGE)
rem ----------------------------------------------------------------------------
rem Preserving the environment state for the next module in the sequence.
endlocal  & set "AVIS_OMIT_KEYDIR_AND_BUILD=%AVIS_OMIT_KEYDIR_AND_BUILD%" & set "AVIS_OMIT_KEYDIR=%AVIS_OMIT_KEYDIR%" &     set "PRJ_DRV_KEY=%PRJ_DRV_KEY%" &     set "PRJ_DIR_KEY=%PRJ_DIR_KEY%" &     set "PRJ_ROOT_KEY=%PRJ_ROOT_KEY%" &     set "PRJ_APP_KEY=%PRJ_APP_KEY%" &     set "REMDRV=%REMDRV%" &     set "PROJECT_ROOT=%PROJECT_ROOT%" &     set "PROJECT_APPROOT=%PROJECT_APPROOT%" &     set "CONFIG_FILE=%CONFIG_FILE%" &     set "LOG_FILE=%LOG_FILE%" &     set "PROJECT_PATH=%PROJECT_PATH%" &     set "PROJ_PATH=%PROJ_PATH%" &     set "LOG_PATH=%LOG_PATH%" &     set "LOG_AI=%LOG_AI%"

exit /b 0