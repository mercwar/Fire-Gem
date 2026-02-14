; =============================================================================
;  AVIS FVS BUDDY [VERSION 1]
;  FILE: avis-fvs.asm
; =============================================================================
section .data
    msg db "[AVIS-FVS] Identity Verified: Registers Cleared. VERSION 1. HAHA!", 0xa
    len equ $ - msg

section .text
    global _start
    extern FIRE_LOG_STRIKE

_start:
    ; 1. Clear GPRs for baseline
    xor rax, rax
    xor rbx, rbx
    xor rcx, rcx
    xor rdx, rdx

    ; 2. Log Handshake via Modular Object
    lea rdi, [msg]
    mov rsi, len
    call FIRE_LOG_STRIKE

    ; 3. Exit
    mov rax, 60
    xor rdi, rdi
    syscall
