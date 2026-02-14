; =============================================================================
;  AVIS-MACRO // THE SWITCH
;  FILE: fire-macro.asm
;  PURPOSE: Running the Compiled Hardware Objects
; =============================================================================
%include "VERSION 1/fire-gem-asm.inc"

section .text
    global _start
    extern FIRE_LOG_STRIKE

_start:
    ; 1. EVALUATE COMPILE/RUN SWITCH
    ; Macro runs the FGEOs currently seated in Extension-2
    call MACRO_STRIKE_LOGIC

    mov rax, 60
    xor rdi, rdi
    syscall

MACRO_STRIKE_LOGIC:
    ; Hardware execution of forged objects
    ret
