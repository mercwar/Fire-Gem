; =============================================================
;  AVIS TERMINAL SURFACE // [SESSION-2]
;  FILE: fire-term.asm
; =============================================================
%include "VERSION 1/fire-gem.inc"

section .data
    msg_term db "AVIS [LLM-LOG-OBJ][TERM] Surface Online. Ready for Seed...", 0xa

section .text
    global _start
    extern FIRE_LOG_STRIKE

_start:
    ; 1. IGNITE TERMINAL I/O
    lea rdi, [msg_term]
    mov rsi, 54
    call FIRE_LOG_STRIKE

    ; 2. CALL SEED (Next in Load Order)
    ; Terminal prepares the hardware for the Net strike.
    
    mov rax, SYS_EXIT
    xor rdi, rdi
    syscall
