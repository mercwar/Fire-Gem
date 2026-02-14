; =============================================================================
;  AVIS-CORE // HARDWARE SEED [VERSION 1]
;  FILE: fire-seed.asm
;  PURPOSE: Prepare Memory & Registers for the Net Surface Strike
; =============================================================================
%include "VERSION 1/fire-gem.inc"

section .data
    msg_seed db "AVIS [LLM-LOG-OBJ][SEED] Hardware Primed. HAHA!", 0xa
    len_seed equ 47

section .text
    global _start
    extern FIRE_PROTOCOL_WRAP ; From fire-protocol.o

_start:
    ; 1. STRIKE THE SEED LOG
    lea rdi, [msg_seed]
    mov rsi, len_seed
    call FIRE_PROTOCOL_WRAP

    ; 2. REGISTER PRIMING
    ; Sets up the buffer pointers for fire-net.exe
    
    mov rax, SYS_EXIT
    xor rdi, rdi
    syscall
