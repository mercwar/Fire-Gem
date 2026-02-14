; =============================================================
;  AVIS-CORE // MACRO BRIDGE [VERSION 1]
;  FILE: fire-macro.asm
; =============================================================
section .data
    avis_hdr db "AVIS", 0x01, 0x00
    msg_macro db "AVIS [MACRO] Bridge Active. HAHA!", 0xa

section .text
    global _start
    extern FIRE_LOG_STRIKE

_start:
    ; 1. INTERNAL WRAP
    lea rsi, [avis_hdr]
    mov rdx, 6
    call FIRE_LOG_STRIKE

    ; 2. STRIKE MESSAGE
    lea rsi, [msg_macro]
    mov rdx, 33
    call FIRE_LOG_STRIKE

    mov rax, 60
    xor rdi, rdi
    syscall
