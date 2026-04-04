; =============================================================
;  AVIS-MACRO // THE HAND [VERSION 1]
;  FILE: fire-macro.asm
; =============================================================
section .text
    global _start
    extern CYHY_CALL_RUN
    extern FIRE_LOG_STRIKE

_start:
    ; Macro calls the CYHY bridge to trigger a BASH strike
    mov rdi, run_cmd
    call CYHY_CALL_RUN
    
    mov rax, 60
    xor rdi, rdi
    syscall

section .data
    run_cmd db "./VERSION 1/fire-compile.exe", 0
