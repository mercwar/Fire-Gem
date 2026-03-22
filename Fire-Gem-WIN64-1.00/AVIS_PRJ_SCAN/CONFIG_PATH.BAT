@echo off
setlocal EnableExtensions

rem ============================================================================
rem AVIS PROJECT SCAN - PATH ANCHOR MODULE
rem ============================================================================
rem ROLE: Synchronizes the working directory to the script's physical location.
rem FILE: CONFIG_PATH.BAT
rem ============================================================================

rem ----------------------------------------------------------------------------
rem STEP X: ANCHOR WORKING DIRECTORY
rem ----------------------------------------------------------------------------
echo [AVIS] INITIALIZING DIRECTORY ANCHOR...

rem Capture the script's origin path into a local variable.
set "SCRIPT_DIR=%~dp0"

rem Tunnel out of local scope to apply the PUSHD command globally to the session.
endlocal & pushd "%SCRIPT_DIR%"

echo [AVIS] CURRENT DIR : "%CD%"

rem ----------------------------------------------------------------------------
rem STEP Y: VARIABLE EXPORT BRIDGE
rem ----------------------------------------------------------------------------
rem Preserving all environment variables through the endlocal barrier.
endlocal  & set "AVIS_OMIT_KEYDIR_AND_BUILD=%AVIS_OMIT_KEYDIR_AND_BUILD%" & set "AVIS_OMIT_KEYDIR=%AVIS_OMIT_KEYDIR%" &     set "PRJ_DRV_KEY=%PRJ_DRV_KEY%" &     set "PRJ_DIR_KEY=%PRJ_DIR_KEY%" &     set "PRJ_ROOT_KEY=%PRJ_ROOT_KEY%" &     set "PRJ_APP_KEY=%PRJ_APP_KEY%" &     set "REMDRV=%REMDRV%" &     set "PROJECT_ROOT=%PROJECT_ROOT%" &     set "PROJECT_APPROOT=%PROJECT_APPROOT%" &     set "CONFIG_FILE=%CONFIG_FILE%" &     set "LOG_FILE=%LOG_FILE%" &     set "PROJECT_PATH=%PROJECT_PATH%" &     set "PROJ_PATH=%PROJ_PATH%" &     set "LOG_PATH=%LOG_PATH%" &     set "LOG_AI=%LOG_AI%"

exit /b 0