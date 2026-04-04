@echo off
setlocal EnableExtensions

rem ============================================================================
rem AVIS PROJECT SCAN - STRUCTURE INITIALIZATION MODULE
rem ============================================================================
rem ROLE: Ensures the physical directory structure exists before logging begins.
rem FILE: CREATE_STRUCT.BAT
rem ============================================================================

rem ----------------------------------------------------------------------------
rem STEP 4: DIRECTORY VALIDATION & CREATION
rem ----------------------------------------------------------------------------

rem Check if variable was actually passed from parent scope.
if "%LOG_PATH%"=="" (
    echo [AVIS] CRITICAL ERROR: LOG_PATH is not defined.
    exit /b 1
)

echo [AVIS] SCANNING TARGET : "%LOG_PATH%"


    if not exist "%LOG_PATH%" (
        echo [AVIS] STATUS          : PATH NOT FOUND - CREATING...
        mkdir "%LOG_PATH%"
    ) else (
        echo [AVIS] STATUS          : PATH VERIFIED
    )


rem ----------------------------------------------------------------------------
rem STEP 5: VARIABLE EXPORT BRIDGE
rem ----------------------------------------------------------------------------
rem Preserving the environment state for the next module in the sequence.
endlocal  & set "AVIS_OMIT_KEYDIR_AND_BUILD=%AVIS_OMIT_KEYDIR_AND_BUILD%" & set "AVIS_OMIT_KEYDIR=%AVIS_OMIT_KEYDIR%" &     set "PRJ_DRV_KEY=%PRJ_DRV_KEY%" &     set "PRJ_DIR_KEY=%PRJ_DIR_KEY%" &     set "PRJ_ROOT_KEY=%PRJ_ROOT_KEY%" &     set "PRJ_APP_KEY=%PRJ_APP_KEY%" &     set "REMDRV=%REMDRV%" &     set "PROJECT_ROOT=%PROJECT_ROOT%" &     set "PROJECT_APPROOT=%PROJECT_APPROOT%" &     set "CONFIG_FILE=%CONFIG_FILE%" &     set "LOG_FILE=%LOG_FILE%" &     set "PROJECT_PATH=%PROJECT_PATH%" &     set "PROJ_PATH=%PROJ_PATH%" &     set "LOG_PATH=%LOG_PATH%" &     set "LOG_AI=%LOG_AI%"

exit /b 0
