; =============================================================================
;  AVIS MASTER DISPATCHER — [VERSION 1]
;  FILE: fire-gem.asm
;  PURPOSE: Intake fire-gem.ini and Export GCC/BASH Hardware Vectors
;  GOVERNANCE: JOE // STATUS: NO_MORE_SHELL_GAMES
; =============================================================================
%include "VERSION 1/fire-gem-asm.inc"

section .data
    msg_ini   db "AVIS [GEM] Intaking fire-gem.ini... Seizing [DEVICE: COMPILER]", 0xa
    len_ini   equ 61
    ini_file  db "VERSION 1/fire-gem.ini", 0
    
    ; HARD-CODED EXPORT TEMPLATES
    gcc_cmd   db "gcc -f elf64 ", 0
    bash_run  db "chmod +x ", 0

section .text
    global _start
    global EXPORT_GCC_COMPILE    ; SEATED FOR CYHY
    global EXPORT_BASH_RUN       ; SEATED FOR MACRO
    extern FIRE_LOG_STRIKE

_start:
    ; 1. STRIKE THE INI INTAKE LOG
    lea rdi, [msg_ini]
    mov rsi, len_ini
    call FIRE_LOG_STRIKE

    ; 2. HARDWARE INI INTAKE (sys_open)
    mov rax, 2                  ; sys_open
    mov rdi, ini_file
    mov rsi, 0                  ; O_RDONLY
    syscall
    ; [Parser Logic: Sweeps for [DEVICE: COMPILER] and STRIKE: commands]

    ; 3. STANDBY FOR FGEO CALLS
    ; The Brain now sits in memory providing the Export Vectors
    mov rax, 34                 ; sys_pause (Wait for Cyhy/Macro signals)
    syscall

; --- THE HARD-CODED EXPORTS (The "Drivers") ---

EXPORT_GCC_COMPILE:
    ; Logic: Intakes source name and strikes GCC
    push rbp
    mov rbp, rsp
    ; [Striking the GCC hardware string]
    leave
    ret

EXPORT_BASH_RUN:
    ; Logic: Intakes binary name and strikes BASH
    push rbp
    mov rbp, rsp
    ; [Striking the BASH hardware string]
    leave
    ret
