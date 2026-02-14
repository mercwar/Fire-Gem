; =============================================================================
;  AVIS-CORE // PROTOCOL WRAPPER [VERSION 1]
;  FILE: fire-protocol.asm
;  PURPOSE: Seal the Void and Populate fire-protocol.avis
; =============================================================================
%include "VERSION 1/fire-gem.inc"

section .data
    avis_hdr db "AVIS", 0x01, 0x00
    msg_seal db "[LLM-LOG-OBJ][PROTOCOL] Session 1 Sealed. Identity Verified.", 0xa
    len_seal equ 61

section .text
    global _start
    extern FIRE_LOG_STRIKE

_start:
    ; 1. STRIKE THE MAGIC HEADER
    lea rdi, [avis_hdr]
    mov rsi, 6
    call FIRE_LOG_STRIKE

    ; 2. STRIKE THE IDENTITY SEAL
    ; This forces data into the .avis / .log file to break the loop
    lea rdi, [msg_seal]
    mov rsi, len_seal
    call FIRE_LOG_STRIKE

    ; 3. HANDOFF TO TERMINAL
    mov rax, 60         ; sys_exit
    xor rdi, rdi
    syscall
