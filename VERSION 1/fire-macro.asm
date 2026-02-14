; =============================================================================
;  AVIS-CORE // MACRO BRIDGE [VERSION 1]
;  FILE: fire-macro.asm
;  PURPOSE: Lead Action Hand - First in the Post-Smithy Chain
;  GOVERNANCE: CVBGOD // STATUS: SH_LINK_COMPLIANT
; =============================================================================
%include "VERSION 1/fire-gem-asm.inc"

section .data
    msg_macro db "AVIS [LLM-LOG-OBJ][MACRO] Ignition: Lead Action Seated. HAHA!", 0xa
    len_macro equ 62
    avis_hdr  db "AVIS", 0x01, 0x00
    hdr_len   equ 6

section .text
    global _start
    extern FIRE_LOG_STRIKE ; Provided by the vocal shell loop

_start:
    ; 1. INTERNAL PROTOCOL WRAP
    lea rdi, [avis_hdr]
    mov rsi, hdr_len
    call FIRE_LOG_STRIKE

    ; 2. STRIKE MACRO STATUS
    lea rdi, [msg_macro]
    mov rsi, len_macro
    call FIRE_LOG_STRIKE

    ; 3. MACRO SWITCH LOGIC
    ; Because it loads first, it initializes the CJS execution environment
    call MACRO_INIT_PROTOCOL

    ; 4. EXIT
    mov rax, 60
    xor rdi, rdi
    syscall

MACRO_INIT_PROTOCOL:
    push rbp
    mov rbp, rsp
    ; Logic to prepare Extension-2 for Terminal Command intake
    leave
    ret
