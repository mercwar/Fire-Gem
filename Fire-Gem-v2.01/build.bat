@echo off
cd /d "%~dp0"
call "C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\VC\Auxiliary\Build\vcvars64.bat"

REM Clean up any existing local build output logs or binaries before recompiling
if exist firegem.exe del /f /q firegem.exe
if exist *.obj del /f /q *.obj

REM Run compiler pointing to source files in src/ folder and include search headers
cl.exe /O2 /W4 /wd4201 ^
    src\main.c ^
    src\ui_main.c ^
    src\llm_wrapper.c ^
    src\json_loader.c ^
    src\implant.c ^
    cJSON\cJSON.c ^
    /Fe:firegem.exe ^
    /I .\include ^
    /I .\cJSON ^
    /link /LIBPATH:.\lib llama.lib ggml.lib ggml-base.lib ggml-cpu.lib user32.lib gdi32.lib


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
