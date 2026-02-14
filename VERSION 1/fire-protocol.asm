; =============================================================================
;  AVIS-CORE // PROTOCOL WRAPPER [VERSION 1]
;  FILE: fire-protocol.asm
;  PURPOSE: Central Encapsulation Logic
; =============================================================================

section .data
    avis_hdr db "AVIS", 0x01, 0x00
    hdr_len  equ 6

section .text
    global FIRE_PROTOCOL_WRAP  ; THE MISSING LINK
    extern FIRE_LOG_STRIKE     ; The Voice

FIRE_PROTOCOL_WRAP:
    push rbp
    mov rbp, rsp
    
    ; 1. Strike Header
    push rsi
    push rdi
    lea rdi, [avis_hdr]
    mov rsi, hdr_len
    call FIRE_LOG_STRIKE

    ; 2. Strike Data
    pop rdi
    pop rsi
    call FIRE_LOG_STRIKE

    leave
    ret
