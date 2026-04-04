; fire-gem-json.asm
; Load selected JSON from build directory, validate, extract build spec

default rel

extern FG_GetBuildDir
extern FG_LogString

section .data
FG_JsonOutput    db 260 dup(0)   ; output exe name
; You can store sources/flags/scripts in your own structures or buffers.

section .text
global FG_LoadJson_Click

FG_LoadJson_Click:
    ; 1) Read selected JSON filename from dropdown
    ; 2) Build full path: build_dir + json_name
    ; 3) Load JSON file
    ; 4) Parse:
    ;    - "output"
    ;    - "sources"[]
    ;    - "flags"[]
    ;    - "scripts"[] (chmod/bash steps)
    ; 5) Store parsed data in global buffers/structures
    ; 6) Log summary (output, sources, flags, scripts)
    ret
