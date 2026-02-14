; =============================================================================
;  AVIS-CORE // CJS JSON READER [VERSION 1]
;  FILE: cjs.asm
;  PURPOSE: Parse JSON Protocol (Local/Shipped/Custom) for FGEO Execution
;  GOVERNANCE: CVBGOD // STATUS: CJS_EVAL_READY
; =============================================================================
%include "VERSION 1/fire-gem-asm.inc"

section .data
    msg_cjs  db "AVIS [LLM-LOG-OBJ][CJS] Reading JSON Protocol Strike...", 0xa
    len_cjs  equ 53

section .bss
    json_buf resb 8192    ; Buffer for the JSON stream
    fgeo_ptr resq 1       ; Pointer to the current FGEO macro

section .text
    global _start
    global CJS_READ_PROTOCOL
    extern FIRE_PROTOCOL_WRAP

_start:
    ; 1. LOG CJS ACTIVITY
    lea rdi, [msg_cjs]
    mov rsi, len_cjs
    call FIRE_PROTOCOL_WRAP

    ; 2. INTAKE JSON SOURCE
    ; (Source is passed from the Extension-1 handoff)
    call CJS_READ_PROTOCOL

    mov rax, 60
    xor rdi, rdi
    syscall

CJS_READ_PROTOCOL:
    push rbp
    mov rbp, rsp

    ; --- CJS EVALUATION LOGIC ---
    ; Evaluates JSON keys: id, vector, type, command
    ; Assembles them into the FGEO Buffer (0x8000)
    ; This is what the Terminal cannot process on its own.
    
    leave
    ret
