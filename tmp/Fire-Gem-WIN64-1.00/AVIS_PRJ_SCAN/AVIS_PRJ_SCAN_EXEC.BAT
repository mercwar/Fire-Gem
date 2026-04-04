@echo off
setlocal EnableExtensions
rem ============================================================
rem AVIS BATCH CBORD.SEED VERSION 1.10
rem FILE: AVIS_PRJ_SCAN_EXEC.BAT
rem ROLE: Project scan executor
rem IMPORTS:
rem    - REMDRV
rem    - PROJECT_ROOT
rem    - PROJECT_APPROOT
rem EXPORTS:
rem    - CONFIG_FILE
rem    - LOGFILE
rem ============================================================
rem ------------------------------------------------------------
rem STEP 0: FORCE WORKING DIRECTORY TO THIS SCRIPT'S LOCATION
rem ------------------------------------------------------------
echo [AVIS] DEBUG: CALL CONFIG_PATH
call "%PROJECT_PATH%CONFIG_PATH.BAT"
echo [AVIS] DEBUG: PATH "%~dp0"
rem ------------------------------------------------------------
rem STEP 1: VERIFY IMPORTS BEFORE SETLOCAL
rem ------------------------------------------------------------
echo [AVIS] DEBUG: REMDRV=%REMDRV%
echo [AVIS] DEBUG: PROJECT_ROOT=%PROJECT_ROOT%
echo [AVIS] DEBUG: PROJECT_APPROOT=%PROJECT_APPROOT%
echo [AVIS] DEBUG: PROJECT_PATH=%PROJECT_APPROOT%
rem ------------------------------------------------------------
rem STEP 2: START LOCAL ENVIRONMENT
rem ------------------------------------------------------------
 echo [AVIS] CONFIG_ROOT DATA...
 call "%PROJECT_PATH%CONFIG_ROOT.BAT"
 echo.
 echo [AVIS] CREATE_STRUCT DATA...
 call "%PROJECT_PATH%CREATE_STRUCT.BAT"
 echo.
 echo [AVIS] LOAD_CONFIG DATA...
 call "%PROJECT_PATH%LOAD_CONFIG.BAT"
 echo.
 echo [AVIS] BAK_CONFIG DATA...
 call "%PROJECT_PATH%BAK_CONFIG.BAT"
 echo.
 echo [AVIS] LOG_CONFIG DATA...
 call "%PROJECT_PATH%LOG_CONFIG.BAT"
 echo.
 echo [AVIS] SCAN_DIR DATA...
 call "%PROJECT_PATH%SCAN_DIR.BAT"
 echo.
 echo [AVIS] SCAN_FILE DATA...
 call "%PROJECT_PATH%SCAN_FILE.BAT"
 echo.
 echo [AVIS] SAVE_LOG DATA...
 call "%PROJECT_PATH%SAVE_LOG.BAT"
 echo.
 echo [AVIS] DATA EXPORT %LOG_AI%...
 echo.
 endlocal  & set "AVIS_OMIT_KEYDIR_AND_BUILD=%AVIS_OMIT_KEYDIR_AND_BUILD%" & set "AVIS_OMIT_KEYDIR=%AVIS_OMIT_KEYDIR%" &     set "PRJ_DRV_KEY=%PRJ_DRV_KEY%" &     set "PRJ_DIR_KEY=%PRJ_DIR_KEY%" &     set "PRJ_ROOT_KEY=%PRJ_ROOT_KEY%" &     set "PRJ_APP_KEY=%PRJ_APP_KEY%" &     set "REMDRV=%REMDRV%" &     set "PROJECT_ROOT=%PROJECT_ROOT%" &     set "PROJECT_APPROOT=%PROJECT_APPROOT%" &     set "CONFIG_FILE=%CONFIG_FILE%" &     set "LOG_FILE=%LOG_FILE%" &     set "PROJECT_PATH=%PROJECT_PATH%" &     set "PROJ_PATH=%PROJ_PATH%" &     set "LOG_PATH=%LOG_PATH%" &     set "LOG_AI=%LOG_AI%"


exit /b 0
