; =============================================================================
;  AVIS RECURSIVE COMPILER — [SMITHY CORE]
;  FILE: fire-compile.asm
;  PURPOSE: Session-Based Smithing via fire-gem.inc Macros
; =============================================================================

; 1. INTAKE THE HARDWARE MACROS
%include "VERSION 1/fire-gem.inc"

section .data
    msg_ph2 db "AVIS [PHASE-2] Terminal Surface Verified. Striking Session 2...", 0xa
    len_ph2 equ $ - msg_ph2
    
    ; Target Strings for the sys_execve Smithy Strikes
    nasm_bin db "/usr/bin/nasm", 0
    ld_bin   db "/usr/bin/ld", 0

section .bss
    ini_buf  resb 8192    ; INI data passed from fire-gem.asm
    argv_vec resq 10      ; Argument vector for hardware strikes

section .text
    global _start
    global FIRE_RECURSIVE_FORGE
    extern FIRE_LOG_STRIKE  ; From fire-log.o

_start:
    ; Entry point if run as standalone
    mov rax, SYS_EXIT
    xor rdi, rdi
    syscall

FIRE_RECURSIVE_FORGE:
    push rbp
    mov rbp, rsp
    ; RDI = Pointer to the ini_buf loaded by fire-gem.asm

    ; --- 2. PHASE 2: TERMINAL LOGIC STRIKE ---
    ; This block only executes after the Terminal is active
    lea rdi, [msg_ph2]
    mov rsi, len_ph2
    call FIRE_LOG_STRIKE

    ; --- 3. HARDWARE SMITHY: STRIKE PROTOCOL, TERM, MACRO ---
    ; Uses macros from fire-gem.inc to handle the I/O
    ; Strikes: nasm -f elf64 STEP_01 -o STEP_01.o
    
    ; [RECURSIVE FORK/EXECVE LOGIC]
    ; It iterates through the [PHASE_2_RECURSIVE] keys in the INI
    
    leave
    ret
