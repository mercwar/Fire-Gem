; =============================================================
;  AVIS-SMITHY // THE HAMMER [VERSION 1]
;  FILE: fire-compile.asm
;  PURPOSE: Recursive Forge (NOW A CALLABLE FUNCTION)
; =============================================================
section .text
    global FIRE_COMPILE_ENTRY ; <--- NO MORE _start COLLISION
    extern FIRE_LOG_STRIKE

FIRE_COMPILE_ENTRY:
    push rbp
    mov rbp, rsp
    
    ; LOG THE SMITHY IGNITION
    lea rdi, [msg_smith]
    mov rsi, 35
    call FIRE_LOG_STRIKE

    ; [FORGE LOGIC HERE]

    leave
    ret

section .data
    msg_smith db "AVIS [SMITH] Smithy Hammer Active.", 0xa
