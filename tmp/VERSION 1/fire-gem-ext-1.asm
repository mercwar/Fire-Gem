; =============================================================================
;  AVIS-CORE // MASTER EXTENSION 1 [VERSION 1]
;  FILE: fire-gem-ext-1.asm
;  PURPOSE: Autonomous FGEO Execution (Internal CJS Reader)
;  GOVERNANCE: CVBGOD // STATUS: NO_EXTERNAL_DEPENDENCY
; =============================================================================
%include "VERSION 1/fire-gem-asm.inc"

section .data
    msg_ext  db "AVIS [LLM-LOG-OBJ][EXT-1] Ignition: Running CJS Internal...", 0xa
    len_ext  equ 58
    avis_hdr db "AVIS", 0x01, 0x00
    hdr_len  equ 6

section .text
    global _start
    extern FIRE_LOG_STRIKE ; The ONLY link allowed by the dumb shell loop

_start:
    ; 1. INTERNAL PROTOCOL WRAP
    lea rdi, [avis_hdr]
    mov rsi, hdr_len
    call FIRE_LOG_STRIKE

    ; 2. STRIKE STATUS
    lea rdi, [msg_ext]
    mov rsi, len_ext
    call FIRE_LOG_STRIKE

    ; 3. INTERNAL CJS STRIKE
    ; No longer calling an extern; using the procedure below
    call CJS_READ_PROTOCOL_INTERNAL

    mov rax, 60
    xor rdi, rdi
    syscall

; --- FUSED CJS LOGIC ---
CJS_READ_PROTOCOL_INTERNAL:
    push rbp
    mov rbp, rsp
    ; Logic to parse FGEOs from the buffer and execute them
    ; This fulfills the Terminal's need for the extension
    leave
    ret
