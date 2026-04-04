@echo off
setlocal EnableExtensions

rem ============================================================================
rem AVIS PROJECT SCAN - RESULTS & EXPORT SUMMARY
rem ============================================================================
rem ROLE: Finalizes the scan sequence and displays the exported environment state.
rem FILE: SCAN_RESULTS.BAT
rem ============================================================================

rem ----------------------------------------------------------------------------
rem STEP 10: EXPORT VERIFICATION
rem ----------------------------------------------------------------------------
echo [AVIS] EXPORTS FOR AVIS_PRJ_SCAN_EXEC.BAT:
echo     CONFIG_FILE     = %CONFIG_FILE%
echo     LOGFILE         = %LOG_FILE%
echo     REMDRV          = %REMDRV%
echo     PROJECT_ROOT    = %PROJECT_ROOT%
echo     PROJECT_APPROOT = %PROJECT_APPROOT%
echo.

rem ----------------------------------------------------------------------------
rem STEP 11: SCAN RESULTS SUMMARY
rem ----------------------------------------------------------------------------
echo [AVIS] SHINE SCAN SUMMARY:
echo ------------------------------------------------------------
if exist "%LOG_AI%" (
    echo [STATUS] LOG CREATED  : SUCCESS
    echo [STATUS] LOG LOCATION : %LOG_AI%
) else (
    echo [STATUS] LOG CREATED  : FAILED
)

if exist "%CONFIG_FILE%.tmp" (
    echo [STATUS] TEMP CONFIG  : GENERATED
)

echo [AVIS] ALL PROJECT MODULES SYNCHRONIZED.
echo.

rem ----------------------------------------------------------------------------
rem STEP 12: FINAL VARIABLE TUNNEL (THE PROTECTED BRIDGE)
rem ----------------------------------------------------------------------------
rem Final hand-off to ensure the parent process retains the full system state.
endlocal  & set "AVIS_OMIT_KEYDIR_AND_BUILD=%AVIS_OMIT_KEYDIR_AND_BUILD%" & set "AVIS_OMIT_KEYDIR=%AVIS_OMIT_KEYDIR%" &     set "PRJ_DRV_KEY=%PRJ_DRV_KEY%" &     set "PRJ_DIR_KEY=%PRJ_DIR_KEY%" &     set "PRJ_ROOT_KEY=%PRJ_ROOT_KEY%" &     set "PRJ_APP_KEY=%PRJ_APP_KEY%" &     set "REMDRV=%REMDRV%" &     set "PROJECT_ROOT=%PROJECT_ROOT%" &     set "PROJECT_APPROOT=%PROJECT_APPROOT%" &     set "CONFIG_FILE=%CONFIG_FILE%" &     set "LOG_FILE=%LOG_FILE%" &     set "PROJECT_PATH=%PROJECT_PATH%" &     set "PROJ_PATH=%PROJ_PATH%" &     set "LOG_PATH=%LOG_PATH%" &     set "LOG_AI=%LOG_AI%"

exit /b 0