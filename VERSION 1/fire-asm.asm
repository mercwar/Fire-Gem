; =============================================================================
;  AVIS MASTER ENGINE — [VERSION 1]
;  FILE: fire-gem.asm
;  PURPOSE: Intake fire-compile.ini and Strike the Smithy
;  GOVERNANCE: CVBGOD // STATUS: ENTRY_POINT_RESTORED
; =============================================================================
%include "VERSION 1/fire-gem.inc"

section .data
    msg_ignite db "AVIS [BLOCK-1] Ignition: Master Brain Seizing Control.", 0xa
    len_ignite equ 54
    
    smith_path db "VERSION 1/fire-compile.exe", 0

section .text
    global _start       ; <--- MANDATORY: TELLS THE LINKER WHERE TO BEGIN
    extern FIRE_LOG_STRIKE

_start:
    ; 1. STRIKE IGNITION LOG
    lea rdi, [msg_ignite]
    mov rsi, len_ignite
    call FIRE_LOG_STRIKE

    ; 2. STRIKE THE SMITHY (sys_execve)
    ; This replaces the current process with the Smithy Forge
    mov rax, 59         ; syscall: execve
    mov rdi, smith_path ; target: fire-compile.exe
    xor rsi, rsi        ; no args
    xor rdx, rdx        ; no env
    syscall

    ; 3. FAILSAFE EXIT (If execve fails)
    mov rax, 60         ; syscall: exit
    xor rdi, rdi
    syscall
