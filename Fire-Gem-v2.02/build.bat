:: AVIS Neon Core - FireGem Build Script
:: AIFVS-ARTIFACT
:: Filename: build_firegem.bat
:: Purpose: Compile FireGem sources into firegem.exe using MSVC with shader-ready structure

@echo off
cd /d "%~dp0"

:: Initialize MSVC environment
call "C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\VC\Auxiliary\Build\vcvars64.bat"

:: Clean up old outputs
if exist firegem.exe del /f /q firegem.exe
if exist *.obj del /f /q *.obj

:: Compile sources from src/ folder
cl.exe /O2 /W4 /wd4201 ^
    src\main.c ^
    src\ui_main.c ^
    src\llm_wrapper.c ^
    src\json_loader.c ^
    src\implant.c ^
    src\dispatch.c ^
    src\prompt_formatter.c ^
    cJSON\cJSON.c ^
    /Fe:firegem.exe ^
    /I .\include ^
    /I .\cJSON ^
    /I .\avis_shader ^   ^
    /link /LIBPATH:.\lib llama.lib ggml.lib ggml-base.lib ggml-cpu.lib user32.lib gdi32.lib

:: Check result
if exist firegem.exe (
    echo.
    echo ============================================================
    echo ✅ Build successful. Launching engine application...
    echo ============================================================
    echo.
    firegem.exe
) else (
    echo.
    echo ============================================================
    echo ❌ ERROR: Build failed. Check compiler log errors above.
    echo ============================================================
)

pause
