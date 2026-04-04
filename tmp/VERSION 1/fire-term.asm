; =============================================================================
;  AVIS-CORE // TERMINAL SURFACE [VERSION 1]
;  FILE: fire-term.asm
;  PURPOSE: Intake JSON FGEOs and trigger 'compile' or 'exec'
;  GOVERNANCE: CVBGOD // STATUS: NO_EXTERNAL_WRAPPER_REQUIRED
; =============================================================================
%include "VERSION 1/fire-gem-asm.inc"

section .data
    msg_term db "AVIS [TERM] Surface Online. Evaluating FGEO Command...", 0xa
    len_term equ 55
    avis_hdr db "AVIS", 0x01, 0x00
    hdr_len  equ 6

section .text
    global _start
    extern FIRE_LOG_STRIKE ; Linked by the dumb shell loop

_start:
    ; 1. INTERNAL PROTOCOL WRAP
    lea rdi, [avis_hdr]
    mov rsi, hdr_len
    call FIRE_LOG_STRIKE

    ; 2. STRIKE STATUS
    lea rdi, [msg_term]
    mov rsi, len_term
    call FIRE_LOG_STRIKE

    ; 3. EVALUATE 'compile' OR 'exec'
    ; Terminal intakes the JSON from the fire-asm wrapper
    call TERMINAL_THROAT_LOGIC

    mov rax, 60
    xor rdi, rdi
    syscall

TERMINAL_THROAT_LOGIC:
    ; Logic to parse "STRIKE: SWITCH : CURL:IO:POST:MAIL:PROTOCOL"
    ; and hand off to fire-macro.exe for execution.
    ret
