; =============================================================================
;  AVIS MASTER ENGINE — [VERSION 1]
;  FILE: fire-gem.asm
;  PURPOSE: Orchestrate Text and AVIS Object Logging
; =============================================================================

section .data
    ; --- TEXT IDENTITY ---
    msg_id   db "[AVIS-GEM] Identity: VERSION 1 Verified.", 0xa
    len_id   equ $ - msg_id

    ; --- AVIS OBJECT (Binary/ART) ---
    ; This represents a raw hardware vector or .art signature
    avis_obj db 0xDE, 0xAD, 0xBE, 0xEF, 0x4D, 0x5A, 0x00, 0x00
    len_obj  equ $ - avis_obj

section .text
    global _start
    extern FIRE_LOG_STRIKE  ; The Modular Voice from fire-log.asm

_start:
    ; --- 1. STRIKE TEXT IDENTITY ---
    lea rdi, [msg_id]       ; Pointer to Text
    mov rsi, len_id         ; Length
    call FIRE_LOG_STRIKE

    ; --- 2. STRIKE BINARY AVIS OBJECT ---
    ; No change in code, only the pointer and size change
    lea rdi, [avis_obj]     ; Pointer to Raw Object Bytes
    mov rsi, len_obj        ; Size of Object
    call FIRE_LOG_STRIKE

    ; --- 3. TERMINAL SEAL ---
    mov rax, 60             ; sys_exit
    xor rdi, rdi
    syscall
