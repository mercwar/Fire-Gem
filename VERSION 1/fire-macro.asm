; =============================================================
;  AVIS MACRO BRIDGE // [SESSION-2]
;  FILE: fire-macro.asm
; =============================================================
%include "VERSION 1/fire-gem.inc"

section .data
    msg_macro db "AVIS [LLM-LOG-OBJ][MACRO] Bridge Active. Switching Protocol...", 0xa

section .text
    global _start
    extern FIRE_LOG_STRIKE

_start:
    ; 1. EXECUTE INI COMMANDS
    ; Evaluates "STRIKE: SWITCH : CURL:IO:POST:MAIL:PROTOCOL"
    
    lea rdi, [msg_macro]
    mov rsi, 58
    call FIRE_LOG_STRIKE

    ; 2. FINALIZE CHAIN
    mov rax, SYS_EXIT
    xor rdi, rdi
    syscall
