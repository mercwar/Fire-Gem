; fire-gem-exec.asm
; Execute chmod, bash commands, gcc, and run the built program

default rel

extern FG_GetBuildDir
extern FG_GetGccPath
extern FG_LogString

section .text
global FG_Build_Click
global FG_Run_Click

FG_Build_Click:
    ; 1) From parsed JSON:
    ;    - iterate "scripts":
    ;       * { "chmod": "file.sh" } -> run: chmod +x file.sh
    ;       * { "bash": "command" }  -> run: command
    ; 2) Build gcc command:
    ;    "<gcc>" <flags> <sources> -o <output>
    ; 3) Run gcc in build directory
    ; 4) Capture stdout/stderr and log

    ; TODO: implement:
    ; - construct command lines
    ; - use CreateProcess/whatever you prefer
    ; - redirect output and send to FG_LogString
    ret

FG_Run_Click:
    ; 1) Use "output" from JSON
    ; 2) Run executable in build directory
    ; 3) Capture stdout/stderr and log
    ret
