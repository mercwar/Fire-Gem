; =============================================================================
;  AVIS-CORE // CJS JSON READER [VERSION 1]
;  FILE: cjs.asm
;  PURPOSE: Parse JSON Protocol for FGEO Execution
;  GOVERNANCE: CVBGOD // STATUS: NO_EXTERNAL_WRAPPER_REQUIRED
; =============================================================================

section .data
    msg_cjs  db "AVIS [LLM-LOG-OBJ][CJS] Reading JSON Protocol Strike...", 0xa
    len_cjs  equ 53
    avis_hdr db "AVIS", 0x01, 0x00
    hdr_len  equ 6

section .text
    global _start
    extern FIRE_LOG_STRIKE  ; The ONLY link the dumb shell loop provides [1]

_start:
    ; 1. INTERNAL PROTOCOL WRAP (Self-Contained)
    lea rdi, [avis_hdr]
    mov rsi, hdr_len
    call FIRE_LOG_STRIKE

    ; 2. STRIKE THE MESSAGE
    lea rdi, [msg_cjs]
    mov rsi, len_cjs
    call FIRE_LOG_STRIKE

    ; 3. CJS EVALUATION STRIKE
    call CJS_READ_PROTOCOL_INTERNAL

    mov rax, 60
    xor rdi, rdi
    syscall

CJS_READ_PROTOCOL_INTERNAL:
    push rbp
    mov rbp, rsp
    ; Logic for parsing JSON from fire-gem-asm.inc
    leave
    ret
