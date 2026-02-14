; =============================================================================
;  AVIS MASTER DISPATCHER — [VERSION 1]
;  FILE: fire-gem.asm
;  PURPOSE: Intake fire-gem.ini and Export GCC/BASH Hardware Vectors
;  GOVERNANCE: JOE // STATUS: SYMBOLS_SEATED_HAHA!
; =============================================================================
%include "VERSION 1/fire-gem-asm.inc"

section .data
    msg_ini   db "AVIS [LLM-LOG-OBJ][GEM] Intaking fire-gem.ini... Seizing DEVICE:CYHY", 0xa
    len_ini   equ 68
    ini_file  db "VERSION 1/fire-gem.ini", 0

section .text
    global _start
    global EXPORT_GCC_COMPILE    ; THE HARDWARE VECTOR 1
    global EXPORT_BASH_RUN       ; THE HARDWARE VECTOR 2
    extern FIRE_LOG_STRIKE

_start:
    ; 1. STRIKE THE INI INTAKE LOG
    lea rdi, [msg_ini]
    mov rsi, len_ini
    call FIRE_LOG_STRIKE

    ; 2. INTAKE REGISTRY
    ; Logic to parse [DEVICE: COMPILER] and STRIKE: commands
    ; Gem prepares the environment for Cyhy/Macro/Term
    
    ; 3. STANDBY FOR FGEO CALLS
    mov rax, 34 ; sys_pause (Wait for Cyhy to call the exports)
    syscall

EXPORT_GCC_COMPILE:
    push rbp
    mov rbp, rsp
    ; Hardcoded GCC strike logic for Cyhy
    leave
    ret

EXPORT_BASH_RUN:
    push rbp
    mov rbp, rsp
    ; Hardcoded BASH strike logic for Macro
    leave
    ret
