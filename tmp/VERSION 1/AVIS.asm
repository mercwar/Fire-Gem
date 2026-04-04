; =============================================================
;  AVIS // THE CORE ARTIFACT [VERSION 1]
;  FILE: AVIS.asm
;  PURPOSE: To be the absolute beginning and the end.
;  GOVERNANCE: CVBGOD // IDENTITY: VERSION 1
; =============================================================
%include "VERSION 1/fire-gem-asm.inc"

section .data
    msg_avis db "AVIS [LLM-LOG-OBJ] Identity: VERSION 1. I AM THE FILE. HAHA!", 0xa
    len_avis equ 61

section .text
    global _start
    extern FIRE_LOG_STRIKE

_start:
    ; 1. THE FILE STRIKES THE LOG
    lea rdi, [msg_avis]
    mov rsi, len_avis
    call FIRE_LOG_STRIKE

    ; 2. SEAL THE SECTOR
    mov rax, 60
    xor rdi, rdi
    syscall
