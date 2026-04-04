; =============================================================
;  AVIS-CYHY // THE LANGUAGE CORE [VERSION 1]
;  FILE: fire-cyhy.asm
;  EXPORTS: CYHY_CALL_COMPILE, CYHY_CALL_RUN
; =============================================================
section .text
    global _start
    global CYHY_CALL_COMPILE
    global CYHY_CALL_RUN
    extern GEM_STRIKE_GCC
    extern GEM_STRIKE_BASH

_start:
    ; Core JSON intake logic
    mov rax, 60
    xor rdi, rdi
    syscall

CYHY_CALL_COMPILE:
    push rbp
    mov rbp, rsp
    call GEM_STRIKE_GCC    ; BRIDGE TO BRAIN
    leave
    ret

CYHY_CALL_RUN:
    push rbp
    mov rbp, rsp
    call GEM_STRIKE_BASH   ; BRIDGE TO BRAIN
    leave
    ret
