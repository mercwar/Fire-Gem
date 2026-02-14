; =============================================================================
;  AVIS MASTER ENGINE — [VERSION 1]
;  FILE: fire-gem.asm
; =============================================================================

section .data
    msg_ignite db "AVIS [BLOCK-1] Ignition: Master Brain Seizing Control.", 0xa
    len_ignite equ 54

section .text
    global _start
    extern FIRE_LOG_STRIKE  ; MANDATORY EXTERN

_start:
    lea rdi, [msg_ignite]
    mov rsi, len_ignite
    call FIRE_LOG_STRIKE

    ; [BLOCK-1 Logic to forge the Smithy starts here]

    mov rax, 60
    xor rdi, rdi
    syscall

