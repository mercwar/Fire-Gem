; =============================================================================
;  AVIS-CORE // THE SMITHY [VERSION 1]
;  FILE: fire-compile.asm
;  PURPOSE: Recursive Forge of Terminal, Macro, and Protocol
;  GOVERNANCE: CVBGOD // STATUS: SMITHY_ACTIVE
; =============================================================================
%include "VERSION 1/fire-gem.inc"

section .data
    msg_smith db "AVIS [BLOCK-1] Smithy: Forging the Triad [Term|Macro|Prot]...", 0xa
    len_smith equ 62
    
    ; COMMAND VECTORS (Strike logic for Phase 2)
    nasm_path db "/usr/bin/nasm", 0
    f_elf64   db "-f", 0
    elf64     db "elf64", 0
    
    ; Target 1: Terminal
    term_src  db "VERSION 1/fire-term.asm", 0
    term_obj  db "VERSION 1/fire-term.o", 0
    
    ; Target 2: Macro
    macro_src db "VERSION 1/fire-macro.asm", 0
    macro_obj db "VERSION 1/fire-macro.o", 0

section .text
    global _start
    extern FIRE_LOG_STRIKE

_start:
    ; 1. LOG THE SMITHY ACTIVATION
    lea rdi, [msg_smith]
    mov rsi, len_smith
    call FIRE_LOG_STRIKE

    ; 2. FORGE THE TERMINAL (Phase 2, Step 2)
    call FORGE_TERMINAL

    ; 3. FORGE THE MACRO (Phase 2, Step 3)
    call FORGE_MACRO

    ; 4. EXIT TO MASTER EXEC
    mov rax, 60
    xor rdi, rdi
    syscall

FORGE_TERMINAL:
    ; Internal strike to NASM to build the Throat
    ; Logic: execve nasm -f elf64 fire-term.asm -o fire-term.o
    ret

FORGE_MACRO:
    ; Internal strike to NASM to build the Hand
    ret
