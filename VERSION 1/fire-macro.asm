; =============================================================
;  AVIS-CORE // MACRO BRIDGE [VERSION 1]
; =============================================================
section .data
    avis_hdr db "AVIS", 0x01, 0x00
    msg_macro db "AVIS [MACRO] Bridge Active.", 0xa

section .text
    global _start
    extern FIRE_LOG_STRIKE

_start:
    ; INTERNAL WRAPPER - Stop calling FIRE_PROTOCOL_WRAP
    lea rdi, [avis_hdr]
    mov rsi, 6
    call FIRE_LOG_STRIKE

    lea rdi, [msg_macro]
    mov rsi, 27
    call FIRE_LOG_STRIKE

    mov rax, 60
    xor rdi, rdi
    syscall
