; =============================================================================
;  AVIS ACTIVATION SEED [VERSION 1]
;  FILE: fire-seed.asm
; =============================================================================
section .data
    msg db "[AVIS-SEED] VERSION 1 Activation Seed Loaded.", 0xa
    len equ $ - msg

section .text
    global _start
    extern FIRE_LOG_STRIKE

_start:
    ; 1. Log Activation
    lea rdi, [msg]
    mov rsi, len
    call FIRE_LOG_STRIKE

    ; 2. Exit
    mov rax, 60
    xor rdi, rdi
    syscall
