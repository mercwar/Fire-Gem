; =============================================================================
;  AVIS-CORE // NET SURFACE [VERSION 1]
;  FILE: fire-net.asm
; =============================================================================

section .data
    msg_net  db "AVIS [LLM-LOG-OBJ][NET] Surface Open. Monitoring Bus...", 0xa
    len_net  equ 54
    avis_hdr db "AVIS", 0x01, 0x00
    hdr_len  equ 6

section .text
    global _start
    extern FIRE_LOG_STRIKE

_start:
    ; 1. INTERNAL PROTOCOL WRAP
    lea rdi, [avis_hdr]
    mov rsi, hdr_len
    call FIRE_LOG_STRIKE

    ; 2. STRIKE STATUS
    lea rdi, [msg_net]
    mov rsi, len_net
    call FIRE_LOG_STRIKE

    ; 3. OPEN THE EAR
    ; [Logic for CURL:IO intake]

    mov rax, 60
    xor rdi, rdi
    syscall
