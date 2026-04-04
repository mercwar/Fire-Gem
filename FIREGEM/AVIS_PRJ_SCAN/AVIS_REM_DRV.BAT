@echo off
setlocal EnableExtensions

rem ============================================================================
rem AVIS PROJECT SCAN - SMART DRIVE ANCHORING
rem ============================================================================
rem ROLE: Anchors environment to script location and tests for Removable status.
rem ============================================================================

rem --- STEP 1: INITIAL ANCHORING ---
rem We set REMDRV to the drive letter where THIS batch file lives immediately.
                                                             
rem echo    --------------------------------------------------------------
echo                    [AVIS] ANCHORING SYSTEM TO DRIVE: %REMDRV%
set "REMDRV=%~d0"
rem --- STEP 2: HARDWARE VALIDATION (HARMLESS TEST) ---
rem We query the system to see if the anchored drive is a "Removable" type (3).
rem If it isn't (e.g., C:), the script continues anyway, fulfilling the harmless test.

wmic logicaldisk where "DeviceID='%REMDRV%'" get DriveType /value | findstr "DriveType=3" >nul
echo    --------------------------------------------------------------
if %errorlevel% equ 0 (

    echo    [AVIS] HARDWARE TYPE : REMOVABLE STORAGE DETECTED
) else (
    echo    [AVIS] HARDWARE TYPE : FIXED / INTERNAL DRIVE
)

echo    [AVIS] STATUS        : DRIVE MAPPING LOCKED
rem echo    --------------------------------------------------------------
rem ----------------------------------------------------------------------------
rem THE PROTECTED BRIDGE
rem ----------------------------------------------------------------------------
endlocal  & set "AVIS_OMIT_KEYDIR_AND_BUILD=%AVIS_OMIT_KEYDIR_AND_BUILD%" & set "AVIS_OMIT_KEYDIR=%AVIS_OMIT_KEYDIR%" &     set "PRJ_DRV_KEY=%PRJ_DRV_KEY%" &     set "PRJ_DIR_KEY=%PRJ_DIR_KEY%" &     set "PRJ_ROOT_KEY=%PRJ_ROOT_KEY%" &     set "PRJ_APP_KEY=%PRJ_APP_KEY%" &     set "REMDRV=%REMDRV%" &     set "PROJECT_ROOT=%PROJECT_ROOT%" &     set "PROJECT_APPROOT=%PROJECT_APPROOT%" &     set "CONFIG_FILE=%CONFIG_FILE%" &     set "LOG_FILE=%LOG_FILE%" &     set "PROJECT_PATH=%PROJECT_PATH%" &     set "PROJ_PATH=%PROJ_PATH%" &     set "LOG_PATH=%LOG_PATH%" &     set "LOG_AI=%LOG_AI%"

exit /b 0