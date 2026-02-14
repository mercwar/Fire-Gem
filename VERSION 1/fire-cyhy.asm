; =============================================================================
;  AVIS-CYHY // THE LANGUAGE CORE [VERSION 1]
;  FILE: fire-cyhy.asm
;  PURPOSE: Intake FGEO Objects and Strike via Gem Exports
;  GOVERNANCE: JOE // STATUS: SYMBOLS_RESOLVED_HAHA!
; =============================================================================

section .data
    msg_cyhy db "AVIS [LLM-LOG-OBJ][CYHY] Language Engaged. Intaking JOE's Packets.", 0xa
    len_cyhy equ 64

section .text
    global _start
    extern EXPORT_GCC_COMPILE    ; THE BRAIN PROVIDES THIS
    extern EXPORT_BASH_RUN       ; THE BRAIN PROVIDES THIS
    extern FIRE_LOG_STRIKE

_start:
    ; 1. STRIKE THE LOG
    lea rdi, [msg_cyhy]
    mov rsi, len_cyhy
    call FIRE_LOG_STRIKE

    ; 2. CALL THE GEM EXPORTS
    ; This builds the FGEO installation layer
    call EXPORT_GCC_COMPILE
    call EXPORT_BASH_RUN

    ; 3. SEAL THE GRID
    mov rax, 60
    xor rdi, rdi
    syscall
