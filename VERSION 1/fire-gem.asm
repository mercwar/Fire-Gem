; =============================================================================
;  AVIS MASTER ENGINE — [VERSION 1]
;  FILE: fire-gem.asm
;  PURPOSE: Intake fire-compile.ini and Strike the Smithy
;  GOVERNANCE: CVBGOD // STATUS: FORGE_INITIATED
; =============================================================================
%include "VERSION 1/fire-gem.inc"

section .data
    msg_ignite db "AVIS [BLOCK-1] Ignition: Master Brain Seizing Control.", 0xa
    len_ignite equ 54
    msg_ini    db "AVIS [BLOCK-1] Intaking fire-compile.ini...", 0xa
    len_ini    equ 45
    
    ini_path   db "VERSION 1/fire-compile.ini", 0
    smith_path db "VERSION 1/fire-compile.exe", 0

section .text
    global _start
    extern FIRE_LOG_STRIKE

_start:
    ; 1. STRIKE IGNITION LOG
    lea rdi, [msg_ignite]
    mov rsi, len_ignite
    call FIRE_LOG_STRIKE

    ; 2. INTAKE INI LAW
    lea rdi, [msg_ini]
    mov rsi, len_ini
    call FIRE_LOG_STRIKE
    
    ; Logic to parse [PHASE_1_IGNITION] would go here
    ; For now, we perform the DIRECT STRIKE to ignite the Smithy

    ; 3. FORGE THE SMITHY (sys_execve)
    ; This triggers the forge for Protocol, Term, and Macro
    mov rax, 59         ; syscall: execve
    mov rdi, smith_path ; TARGET: fire-compile.exe
    xor rsi, rsi        ; no args
    xor rdx, rdx        ; no env
    syscall

    ; 4. FALLBACK / EXIT
    mov rax, 60
    xor rdi, rdi
    syscall
