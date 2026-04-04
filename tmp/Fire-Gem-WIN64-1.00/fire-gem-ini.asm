; fire-gem-ini.asm
; Load INI via common dialog, validate, extract build dir + gcc + JSON list

default rel

extern FG_ShowOpenIniDialog
extern FG_LogString
extern FG_ScanJsonFilesInBuildDir

section .data
FG_BuildDir     db 260 dup(0)   ; build directory path
FG_GccPath      db 260 dup(0)   ; gcc.exe path

section .text
global FG_LoadIni_Click
global FG_GetBuildDir
global FG_GetGccPath

FG_LoadIni_Click:
    ; 1) Show common dialog to pick INI
    ; 2) Parse INI:
    ;    - [BUILD] directory = ...
    ;    - [BUILD] gcc = ...
    ; 3) Validate paths
    ; 4) Scan build directory for *.json and populate JSON dropdown
    ; 5) Log status

    ; TODO: implement:
    ; call FG_ShowOpenIniDialog -> returns path to INI
    ; parse INI into FG_BuildDir and FG_GccPath
    ; call FG_ScanJsonFilesInBuildDir
    ; call FG_LogString with status messages
    ret

FG_GetBuildDir:
    ; RAX = pointer to FG_BuildDir
    lea rax, [rel FG_BuildDir]
    ret

FG_GetGccPath:
    ; RAX = pointer to FG_GccPath
    lea rax, [rel FG_GccPath]
    ret
