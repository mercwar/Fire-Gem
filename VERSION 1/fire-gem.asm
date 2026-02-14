; =============================================================================
;  AVIS MASTER DISPATCHER — [VERSION 1]
;  FILE: fire-gem.asm
;  PURPOSE: Export COMPILE/RUN functions and trigger fire-cyhy.exe
; =============================================================================
%include "VERSION 1/fire-gem-asm.inc"

section .data
    msg_gem db "AVIS [GEM] Dispatcher Online. Exporting COM/CJS Vectors.", 0xa
    len_gem equ 56
    cyhy_path db "VERSION 1/fire-cyhy.exe", 0

section .text
    global _start
    global EXPORT_COMPILE
    global EXPORT_RUN
    extern FIRE_LOG_STRIKE

_start:
    lea rdi, [msg_gem]
    mov rsi, len_gem
    call FIRE_LOG_STRIKE

    ; STRIKE CYHY: The JSON Processor
    mov rax, 59         ; sys_execve
    mov rdi, cyhy_path
    xor rsi, rsi
    xor rdx, rdx
    syscall

EXPORT_COMPILE:
    push rbp
    mov rbp, rsp
    ; Logic to ship COMPILE object to Terminal
    leave
    ret

EXPORT_RUN:
    push rbp
    mov rbp, rsp
    ; Logic to ship RUN object to Terminal
    leave
    ret
