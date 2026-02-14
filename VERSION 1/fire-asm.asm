; =============================================================================
;  AVIS-CORE // TERMINAL EVALUATION PIN [VERSION 1]
;  FILE: fire-asm.asm
;  PURPOSE: Firing the Terminal Evaluation Logic (FGEO Wrapper)
;  GOVERNANCE: CVBGOD // STATUS: NO_EXTERNAL_WRAPPER_REQUIRED
; =============================================================================

section .data
    msg_eval db "AVIS [LLM-LOG-OBJ][EVAL] Terminal Firing Pin Active. HAHA!", 0xa
    len_eval equ 55
    avis_hdr db "AVIS", 0x01, 0x00
    hdr_len  equ 6

section .text
    global _start
    extern FIRE_LOG_STRIKE ; The ONLY external reference allowed by the SH

_start:
    ; 1. INTERNAL PROTOCOL ENCAPSULATION
    ; Strike the AVIS Header first
    lea rdi, [avis_hdr]
    mov rsi, hdr_len
    call FIRE_LOG_STRIKE

    ; 2. STRIKE THE EVALUATION STATUS
    lea rdi, [msg_eval]
    mov rsi, len_eval
    call FIRE_LOG_STRIKE

    ; 3. EVALUATION STRIKE
    ; This evaluates the [TERM][AVIS] block from the INI
    call TERMINAL_EVAL_LOGIC

    mov rax, 60
    xor rdi, rdi
    syscall

TERMINAL_EVAL_LOGIC:
    push rbp
    mov rbp, rsp
    ; Logic for parsing FGEO objects and shipping to Extension-1
    leave
    ret
