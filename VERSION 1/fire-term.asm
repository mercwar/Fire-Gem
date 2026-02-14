; =============================================================================
;  AVIS-TERMINAL // THE THROAT
;  FILE: fire-term.asm
;  PURPOSE: Receive JSON Object and trigger 'compile' or 'exec'
; =============================================================================
%include "VERSION 1/fire-gem-asm.inc"

section .text
    global _start
    extern FIRE_LOG_STRIKE

_start:
    ; 1. RECEIVE JSON FROM FIRE-ASM
    ; 2. EVALUATE COMMAND (compile | exec)
    ; 3. HANDOFF TO MACRO FOR RUNTIME
    
    mov rax, 60
    xor rdi, rdi
    syscall
