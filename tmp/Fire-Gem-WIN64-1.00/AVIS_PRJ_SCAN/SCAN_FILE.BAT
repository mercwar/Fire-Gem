@echo off
setlocal EnableExtensions

rem ============================================================================
rem AVIS PROJECT SCAN - RECURSIVE FILE SCANNER
rem ============================================================================
rem ROLE: Scans the project root for all files and logs their full paths.
rem FILE: SCAN_FILE.BAT
rem ============================================================================

rem ----------------------------------------------------------------------------
rem STEP 9: RECURSIVE FILE SCAN (PROJECT ROOT)
rem ----------------------------------------------------------------------------
echo [AVIS] SCANNING PROJECT FILES...


rem Synchronized to match the [DIR] format used in the directory scan.
for /r "%PROJECT_ROOT%" %%F in (*) do (
    if /I "%AVIS_OMIT_KEYDIR%"=="1" (
        echo "%%F" | find /I "\%PRJ_APP_KEY%\" >nul
        if errorlevel 1 (
            echo [FILE] %%F >> "%LOG_AI%"
        ) else (
            rem [AVIS] SKIP FILES UNDER AVIS_PRJ_SCAN
        )
    ) else (
        echo [FILE] %%F >> "%LOG_AI%"
    )
)

echo [AVIS] STATUS        : FILE LOG UPDATED

rem ----------------------------------------------------------------------------
rem STEP 10: VARIABLE EXPORT BRIDGE (THE PROTECTED BRIDGE)
rem ----------------------------------------------------------------------------
endlocal  & set "AVIS_OMIT_KEYDIR_AND_BUILD=%AVIS_OMIT_KEYDIR_AND_BUILD%" & set "AVIS_OMIT_KEYDIR=%AVIS_OMIT_KEYDIR%" &     set "PRJ_DRV_KEY=%PRJ_DRV_KEY%" &     set "PRJ_DIR_KEY=%PRJ_DIR_KEY%" &     set "PRJ_ROOT_KEY=%PRJ_ROOT_KEY%" &     set "PRJ_APP_KEY=%PRJ_APP_KEY%" &     set "REMDRV=%REMDRV%" &     set "PROJECT_ROOT=%PROJECT_ROOT%" &     set "PROJECT_APPROOT=%PROJECT_APPROOT%" &     set "CONFIG_FILE=%CONFIG_FILE%" &     set "LOG_FILE=%LOG_FILE%" &     set "PROJECT_PATH=%PROJECT_PATH%" &     set "PROJ_PATH=%PROJ_PATH%" &     set "LOG_PATH=%LOG_PATH%" &     set "LOG_AI=%LOG_AI%"

exit /b 0
