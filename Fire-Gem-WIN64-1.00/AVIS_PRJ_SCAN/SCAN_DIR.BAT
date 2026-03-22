@echo off
setlocal EnableExtensions

rem ============================================================================
rem AVIS PROJECT SCAN - RECURSIVE DIRECTORY SCANNER
rem ============================================================================
rem ROLE: Scans the project root for subdirectories and updates the system map.
rem FILE: SCAN_DIR.BAT
rem ============================================================================

rem ----------------------------------------------------------------------------
rem STEP 8: RECURSIVE DIRECTORY SCAN (PROJECT ROOT)
rem ----------------------------------------------------------------------------
echo [AVIS] SCANNING DIRECTORY STRUCTURE...

rem === LIST DIRECTORIES ===
rem Iterates through the project root and logs each found path.
REM AI.BEGIN COPILOT DO THIS: ADD IGNORE PRJ_APP_KEY=AVIS_PRJ_SCAN TO OMIT FROM RESULT INI 
rem === LIST DIRECTORIES ===
rem Iterates through the project root and logs each found path.
rem AI.BEGIN COPILOT DO THIS: ADD IGNORE PRJ_APP_KEY=AVIS_PRJ_SCAN TO OMIT FROM RESULT INI 
for /d /r "%PROJECT_ROOT%" %%D in (*) do (
    rem If omit flag is set and this dir is the app key, skip it
    if /I "%AVIS_OMIT_KEYDIR%"=="1" (
        if /I "%%~nD"=="%PRJ_APP_KEY%" (
            rem [AVIS] SKIP AVIS_PRJ_SCAN DIR
        ) else (
            echo [DIR] %%D >> "%LOG_AI%"
            echo DIR_%%~nD=%%D >> "%CONFIG_FILE%.tmp"
        )
    ) else (
        echo [DIR] %%D >> "%LOG_AI%"
        echo DIR_%%~nD=%%D >> "%CONFIG_FILE%.tmp"
    )
)



echo [AVIS] STATUS        : DIRECTORY MAP UPDATED

rem ----------------------------------------------------------------------------
rem STEP 9: VARIABLE EXPORT BRIDGE (THE PROTECTED BRIDGE)
rem ----------------------------------------------------------------------------
rem Preserving the environment state for the next module in the sequence.
endlocal  & set "AVIS_OMIT_KEYDIR_AND_BUILD=%AVIS_OMIT_KEYDIR_AND_BUILD%" & set "AVIS_OMIT_KEYDIR=%AVIS_OMIT_KEYDIR%" &     set "PRJ_DRV_KEY=%PRJ_DRV_KEY%" &     set "PRJ_DIR_KEY=%PRJ_DIR_KEY%" &     set "PRJ_ROOT_KEY=%PRJ_ROOT_KEY%" &     set "PRJ_APP_KEY=%PRJ_APP_KEY%" &     set "REMDRV=%REMDRV%" &     set "PROJECT_ROOT=%PROJECT_ROOT%" &     set "PROJECT_APPROOT=%PROJECT_APPROOT%" &     set "CONFIG_FILE=%CONFIG_FILE%" &     set "LOG_FILE=%LOG_FILE%" &     set "PROJECT_PATH=%PROJECT_PATH%" &     set "PROJ_PATH=%PROJ_PATH%" &     set "LOG_PATH=%LOG_PATH%" &     set "LOG_AI=%LOG_AI%"

exit /b 0