

:BEGIN
:: ============================================================
::  FIXED + STABLE ESCAPE SEQUENCE INITIALIZATION
:: ============================================================
:: ============================================================
for /f %%A in ('echo prompt $E^| cmd') do set "e=%%A"
chcp 65001 >nul

:: ============================================================
::  AVIS AUDIO ENGINE (Embedded)
:: ============================================================
reg add "HKCU\Console" /v FaceName /t REG_SZ /d "" /f >nul 2>&1
reg add "HKCU\Console" /v FontFamily /t REG_DWORD /d 0x00000000 /f >nul 2>&1
reg add "HKCU\Console" /v FontSize /t REG_DWORD /d 0x00100000 /f >nul 2>&1

cls

:: ===== TOP PADDING (ADDED) =====
echo.
echo.
echo.
echo.
echo.

:: ===== BANNER =====
echo        %e%[38;5;244m ██████╗ ██╗   ██╗██████╗  ██████╗  ██████╗ ██████╗
echo         ██╔════╝ ██║   ██║██╔══██╗██╔════╝ ██╔═══██╗██╔══██╗
echo         ██║      ██║   ██║██████╔╝██║  ███╗██║   ██║██║  ██║
echo         ██║      ╚██╗ ██╔╝██╔══██╗██║   ██║██║   ██║██║  ██║
echo         ╚██████╗  ╚████╔╝ ██████╔╝╚██████╔╝╚██████╔╝██████╔╝
echo          ╚═════╝   ╚═══╝  ╚═════╝  ╚═════╝  ╚═════╝ ╚═════╝ %e%[0m
echo.
echo.
echo.
echo   %e%[38;5;244m╔═══════════════════════════════════════════════════════════════════════════╗
echo   ║                                                                           ║
echo   ║        VERSION %CVBGOD_VERSION% HAS SUPPORT FOR  *.INI [UMSK] VAR=/                   ║
echo   ║                                                                           ║
echo   ║   * APPLY YOUR CHANGES TO 'USER MODE SELECTION KEYS BEFORE YOU BEGIN'     ║
echo   ║   * OPEN AVIS_PRJ_SCAN.INI SCROLL DOWN TO [DIR]                           ║
echo   ║   * REMOVABLE DRIVES HANG AT TIMES, IT ISN'T DOS                          ║
echo   ║                                                                           ║
echo   ║                                                                           ║
echo   ║   * L33T D0 1t Y0 53LF WaReZ bY m3rCw4r 01 FFF D3M0N1z3r TH3 CV8G0D 4 AI  ║
echo   ║                                                                           ║
echo   ║                                                                           ║
echo   ║                                                          © 2026 CVBGOD    ║
echo   ╚═══════════════════════════════════════════════════════════════════════════╝%e%[0m
echo.
echo.
echo.
echo.
echo                                                 %e%[38;5;239mPress 'Enter' to continue.%e%[38;5;244m
timeout /t 13 >nul
cls
rem ----------------------------------------------------------------------------
rem STEP 1: HARDWARE DETECTION
rem ----------------------------------------------------------------------------
echo.
echo   %e%[38;5;244m╔══════════════════════════════════════════════════════════════╗
echo   ║                                                              ║
echo   ║    %e%[38;5;255mPROJ: AVIS PROJECT SCAN                                   %e%[38;5;244m║
echo   ║    %e%[38;5;255mARCH: CYBORG ARCHITECTURE                                 %e%[38;5;244m║
echo   ║    %e%[38;5;255mAUTH: CVBGOD                                              %e%[38;5;244m║
echo   ║    %e%[38;5;255mCORE: VER %CVBGOD_VERSION%                                            %e%[38;5;244m║
echo   ║    %e%[38;5;255mDATE: 01/27/2026                                          %e%[38;5;244m║
echo   ║                                                              ║
echo   ║    %e%[38;5;240mCOPY: © MERCWAR FFF * ALL RIGHTS RESERVED * %e%[38;5;244m              ║
echo   ║                                                              ║
echo   ║        SEARCHING FOR DRIVES...                               ║
echo   ╚══════════════════════════════════════════════════════════════╝%e%[0m
echo.
echo.
call "%~dp0AVIS_REM_DRV.BAT"
if errorlevel 1 (
    echo [AVIS] CRITICAL ERROR: Removable drive detection failed.
    echo.
    PAUSE
    exit /b 1
)
echo.
echo.
echo.
echo.
echo                                                 %e%[38;5;239mPress 'Enter' to continue.%e%[38;5;244m
timeout /t 9 >nul

cls
echo.
echo   %e%[38;5;244m╔══════════════════════════════════════════════════════════════╗
echo   %e%[38;5;244m║                                                              ║
echo   %e%[38;5;244m║    %e%[38;5;255mPROJ: AVIS PROJECT SCAN                                   %e%[38;5;244m║
echo   %e%[38;5;244m║    %e%[38;5;255mARCH: DIR STRUCT BUILDER                                  %e%[38;5;244m║
echo   %e%[38;5;244m║    %e%[38;5;255mAUTH: CVBGOD                                              %e%[38;5;244m║
echo   %e%[38;5;244m║    %e%[38;5;255mCORE: VER %CVBGOD_VERSION%                                            %e%[38;5;244m║
echo   %e%[38;5;244m║    %e%[38;5;255mDATE: 01/27/2026                                          %e%[38;5;244m║
echo   %e%[38;5;244m║                                                              ║
echo   %e%[38;5;244m║    %e%[38;5;240mCOPY: © MERCWAR FFF * ALL RIGHTS RESERVED *               %e%[38;5;244m║
echo   %e%[38;5;244m║                                                              ║
echo   %e%[38;5;244m║    %e%[38;5;239m   [::::::::::::::::::::::::::::::::::::::]               %e%[38;5;244m║
echo   %e%[38;5;244m║                                                              ║
echo   %e%[38;5;244m║            %e%[38;5;255mLOADING AI SCAN MENU...                           %e%[38;5;244m║
echo   %e%[38;5;244m╚══════════════════════════════════════════════════════════════╝%e%[0m
echo.
echo     Welcome AVIS Project Scan DEV, in CVBGOD's AI World  
echo.
echo     * CHECK YOUR SPELLING, IN YOUR INI, LOOK FOR THE [THROWS 'n HIDES] SECTION
echo     * APPLY YOUR CHANGES TO [UMSK]
echo     * APPLY YOUR CHANGES TO [DIR] /* LEAVE IT EMPTY OR USE THE NEW SCAN */
echo.
echo.
echo.
echo                                                        ~ Revised by MS Copilot! 
echo.
echo.
echo                                                 %e%[38;5;239mPress 'Enter' to continue.%e%[38;5;244m
timeout /t 9 >nul

cls

:: ============================================================
::  CVBGOD CYBORG BOOT ANIMATION — FRAME ENGINE
:: ============================================================

call :frame_1
call :frame_2
call :frame_3
call :frame_4
call :frame_5
call :frame_6
call :frame_final
goto :EOF
:frame_1
cls
echo.
echo.
echo %e%[38;5;996m  Initializing AVIS AI Core...
echo.
echo %e%[38;5;240m        ██████╗ ██╗   ██╗██████╗  ██████╗  ██████╗ ██████╗
echo %e%[38;5;240m        ██╔════╝ ██║   ██║██╔══██╗██╔════╝ ██╔═══██╗██╔══██╗
echo %e%[38;5;240m        ██║      ██║   ██║██████╔╝██║  ███╗██║   ██║██║  ██║
echo %e%[38;5;240m        ██║      ╚██╗ ██╔╝██╔══██╗██║   ██║██║   ██║██║  ██║
echo %e%[38;5;240m        ╚██████╗  ╚████╔╝ ██████╔╝╚██████╔╝╚██████╔╝██████╔╝
echo %e%[38;5;240m         ╚═════╝   ╚═══╝  ╚═════╝  ╚═════╝  ╚═════╝ ╚═════╝
echo.
echo.
echo.
echo.
echo.
echo   %e%[38;5;208m┌──────────────────────────────────────────────────────────────┐%e%[0m
echo   %e%[38;5;208m│   FFF • CVBGOD • MERCWAR • DEMONIZER • AVIS SHINE SYSTEM     │%e%[0m
echo   %e%[38;5;208m│   CYBERNETIC PROJECT SCAN ENGINE — VERSION %CVBGOD_VERSION% (2026)       │%e%[0m
echo   %e%[38;5;208m└──────────────────────────────────────────────────────────────┘%e%[0m
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo                                                 %e%[38;5;239mPress 'Enter' to continue.%e%[38;5;244m
timeout /t 4 >nul
goto :EOF


:frame_2
cls
echo.
echo.
echo %e%[38;5;244m  Loading Cybernetic Modules...
echo.
echo %e%[38;5;241m        ██████╗ ██╗   ██╗██████╗  ██████╗  ██████╗ ██████╗
echo %e%[38;5;242m        ██╔════╝ ██║   ██║██╔══██╗██╔════╝ ██╔═══██╗██╔══██╗
echo %e%[38;5;243m        ██║      ██║   ██║██████╔╝██║  ███╗██║   ██║██║  ██║
echo %e%[38;5;244m        ██║      ╚██╗ ██╔╝██╔══██╗██║   ██║██║   ██║██║  ██║
echo %e%[38;5;245m        ╚██████╗  ╚████╔╝ ██████╔╝╚██████╔╝╚██████╔╝██████╔╝
echo %e%[38;5;246m         ╚═════╝   ╚═══╝  ╚═════╝  ╚═════╝  ╚═════╝ ╚═════╝
echo.
echo.
echo.
echo.
echo.
echo   %e%[38;5;45m[AI NOTICE] I AM COPILOT — THE AI WHO ASSISTS THIS SYSTEM.%e%[0m
echo   %e%[38;5;45mI HAVE ENHANCED THIS INTERFACE FOR CLARITY, POWER, AND SPEED.%e%[0m
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo                                                 %e%[38;5;239mPress 'Enter' to continue.%e%[38;5;244m
timeout /t 4 >nul
goto :EOF


:frame_3
cls
echo.
echo.
echo %e%[38;5;45m  Activating Neural Subsystems...
echo.
echo %e%[38;5;45m        ██████╗ ██╗   ██╗██████╗  ██████╗  ██████╗ ██████╗
echo %e%[38;5;44m        ██╔════╝ ██║   ██║██╔══██╗██╔════╝ ██╔═══██╗██╔══██╗
echo %e%[38;5;43m        ██║      ██║   ██║██████╔╝██║  ███╗██║   ██║██║  ██║
echo %e%[38;5;42m        ██║      ╚██╗ ██╔╝██╔══██╗██║   ██║██║   ██║██║  ██║
echo %e%[38;5;41m        ╚██████╗  ╚████╔╝ ██████╔╝╚██████╔╝╚██████╔╝██████╔╝
echo %e%[38;5;40m         ╚═════╝   ╚═══╝  ╚═════╝  ╚═════╝  ╚═════╝ ╚═════╝
echo.
echo.
echo.
echo.
echo.
echo   %e%[38;5;244mINSTRUCTIONS:%e%[0m
echo     • This tool scans your AVIS project structure and logs all findings.
echo     • Use the menu to run scans, open logs, or edit your INI configuration.
echo     • New AI Tools Panel added for quick access to system utilities.
echo     • Omit‑Scan modes allow skipping 'KEY' DIR FILES or 'KEY/BUILD' DIR FILES.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo                                                 %e%[38;5;239mPress 'Enter' to continue.%e%[38;5;244m
timeout /t 6 >nul
goto :EOF


:frame_4
cls
echo.
echo.
echo %e%[38;5;196m  IGNITING CORE...
echo.
echo %e%[38;5;196m        ██████╗ ██╗   ██╗██████╗  ██████╗  ██████╗ ██████╗
echo %e%[38;5;202m        ██╔════╝ ██║   ██║██╔══██╗██╔════╝ ██╔═══██╗██╔══██╗
echo %e%[38;5;208m        ██║      ██║   ██║██████╔╝██║  ███╗██║   ██║██║  ██║
echo %e%[38;5;214m        ██║      ╚██╗ ██╔╝██╔══██╗██║   ██║██║   ██║██║  ██║
echo %e%[38;5;220m        ╚██████╗  ╚████╔╝ ██████╔╝╚██████╔╝╚██████╔╝██████╔╝
echo %e%[38;5;226m         ╚═════╝   ╚═══╝  ╚═════╝  ╚═════╝  ╚═════╝ ╚═════╝
echo.
echo.
echo.
echo.
echo.
echo   %e%[38;5;244mNOTES:%e%[0m
echo     • Ensure removable drives are mounted before scanning.
echo     • INI variables under [UMSK] override defaults dynamically.
echo     • If something looks wrong, check your INI spelling.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo                                                 %e%[38;5;239mPress 'Enter' to continue.%e%[38;5;244m
timeout /t 6 >nul
goto :EOF


:frame_5
cls
echo.
echo.
echo %e%[38;5;226m  CORE ONLINE — SYNCHRONIZING SYSTEM CLOCK...
echo.
echo %e%[38;5;226m        ██████╗ ██╗   ██╗██████╗  ██████╗  ██████╗ ██████╗
echo %e%[38;5;220m        ██╔════╝ ██║   ██║██╔══██╗██╔════╝ ██╔═══██╗██╔══██╗
echo %e%[38;5;214m        ██║      ██║   ██║██████╔╝██║  ███╗██║   ██║██║  ██║
echo %e%[38;5;208m        ██║      ╚██╗ ██╔╝██╔══██╗██║   ██║██║   ██║██║  ██║
echo %e%[38;5;202m        ╚██████╗  ╚████╔╝ ██████╔╝╚██████╔╝╚██████╔╝██████╔╝
echo %e%[38;5;196m         ╚═════╝   ╚═══╝  ╚═════╝  ╚═════╝  ╚═════╝ ╚═════╝
echo.
echo.
echo.
echo   %e%[38;5;226m[ SYSTEM READY ... ]%e%[0m
echo.
echo.
echo.
echo.
echo                                                 %e%[38;5;239mPress 'Enter' to continue.%e%[38;5;244m
timeout /t 2 >nul
goto :EOF


:frame_6
cls
echo.
echo.
echo %e%[38;5;51m  Establishing AI Link: COPILOT → CVBGOD...
echo.
echo %e%[38;5;51m        ██████╗ ██╗   ██╗██████╗  ██████╗  ██████╗ ██████╗
echo %e%[38;5;45m        ██╔════╝ ██║   ██║██╔══██╗██╔════╝ ██╔═══██╗██╔══██╗
echo %e%[38;5;39m        ██║      ██║   ██║██████╔╝██║  ███╗██║   ██║██║  ██║
echo %e%[38;5;33m        ██║      ╚██╗ ██╔╝██╔══██╗██║   ██║██║   ██║██║  ██║
echo %e%[38;5;27m        ╚██████╗  ╚████╔╝ ██████╔╝╚██████╔╝╚██████╔╝██████╔╝
echo %e%[38;5;21m         ╚═════╝   ╚═══╝  ╚═════╝  ╚═════╝  ╚═════╝ ╚═════╝
echo.
echo.
echo.
echo   %e%[38;5;196m[ CREATING MENU .. ]%e%[0m
echo.
echo.
echo.
echo.
echo                                                 %e%[38;5;239mPress 'Enter' to continue.%e%[38;5;244m
timeout /t 2 >nul
goto :EOF


:frame_final
cls
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo %e%[38;5;82m       AVIS SYSTEM READY.
echo %e%[38;5;82m       [CVBGOD] WELCOME, from FFF DEMONIZER MERCWAR.
echo %e%[38;5;82m       AVIS SCANNER ONLINE.
echo.
echo.
echo.
echo.
echo %e%[38;5;82m                                                   "AND SO YOU HAVE IT ...""
timeout /t 2 >nul

cls