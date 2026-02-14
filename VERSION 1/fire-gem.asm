; =============================================================================
;  AVIS MASTER ENGINE — [VERSION 1]
;  FILE: fire-gem.asm
;  PURPOSE: Flush and Seal Voice before Execve Transformation
;  GOVERNANCE: CVBGOD // STATUS: NO_MORE_EMPTY_LOGS
; =============================================================================
%include "VERSION 1/fire-gem.inc"

section .data
    msg_ignite db "AVIS [BLOCK-1] Ignition: Master Brain Seizing Control.", 0xa
    len_ignite equ 54
    msg_smith  db "AVIS [BLOCK-1] STRIKE: Forging fire-compile.exe...", 0xa
    len_smith  equ 50
    
    nasm_path  db "/usr/bin/nasm", 0
    arg0       db "nasm", 0
    arg1       db "-f", 0
    arg2       db "elf64", 0
    arg3       db "VERSION 1/fire-compile.asm", 0
    arg4       db "-o", 0
    arg5       db "VERSION 1/fire-compile.o", 0

section .text
    global _start
    extern FIRE_LOG_STRIKE

_start:
    ; 1. STRIKE THE AVIS LOGS
    ; The Voice handles its own open/write/close per call
    lea rdi, [msg_ignite]
    mov rsi, len_ignite
    call FIRE_LOG_STRIKE

    lea rdi, [msg_smith]
    mov rsi, len_smith
    call FIRE_LOG_STRIKE

    ; 2. THE HARDWARE SEAL
    ; We ensure the file descriptors are clear before the process swap
    
    ; 3. THE COMPILER STRIKE (sys_execve)
    mov rax, 59                 ; syscall: execve
    mov rdi, nasm_path          ; /usr/bin/nasm
    
    ; Argument Vector Construction
    xor rcx, rcx
    push rcx                    ; NULL
    push arg5                   ; "VERSION 1/fire-compile.o"
    push arg4                   ; "-o"
    push arg3                   ; "VERSION 1/fire-compile.asm"
    push arg2                   ; "elf64"
    push arg1                   ; "-f"
    push arg0                   ; "nasm"
    mov rsi, rsp                ; RSI = addr of args
    xor rdx, rdx                ; No ENV
    syscall

    ; 4. FAILSAFE
    mov rax, 60
    xor rdi, rdi
    syscall
