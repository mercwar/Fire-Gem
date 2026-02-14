; =============================================================
;  AVIS MASTER DISPATCHER — [VERSION 1]
;  FILE: fire-gem.asm
;  PURPOSE: Intake Root Exports from fire-gem.ini
;  GOVERNANCE: JOE // STATUS: ROOT_EXPORT_SYNC
; =============================================================
%include "VERSION 1/fire-gem-asm.inc"

section .data
    msg_ini   db "AVIS [GEM] Seizing Root Exports from fire-gem.ini...", 0xa
    len_ini   equ 58
    ini_path  db "VERSION 1/fire-gem.ini", 0

section .text
    global _start
    extern FIRE_LOG_STRIKE  ; Exported from DEVICE:LOG

_start:
    ; 1. STRIKE THE INI INTAKE LOG
    lea rdi, [msg_ini]
    mov rsi, len_ini
    call FIRE_LOG_STRIKE

    ; 2. HARDWARE INI SCAN
    ; Logic to parse STRIKE_VOICE and STRIKE_GCC names
    call SCAN_ROOT_EXPORTS

    ; 3. STANDBY FOR FGEO FORGE
    mov rax, 60
    xor rdi, rdi
    syscall

SCAN_ROOT_EXPORTS:
    push rbp
    mov rbp, rsp
    ; sys_open ini_path -> sys_read -> Map to 0x8000
    leave
    ret
