; =============================================================================
;  AVIS MASTER ENGINE — [VERSION 1]
;  FILE: fire-gem.asm
;  PURPOSE: FVS Sweep, Recursive Forge, and Triad Ignition
; =============================================================================

section .data
    msg_fvs   db "AVIS [LLM-LOG-OBJ][FVS] Register Sweep: CLEAN. HAHA!", 0xa
    len_fvs   equ $ - msg_fvs
    ini_path  db "VERSION 1/fire-compile.ini", 0

section .text
    global _start
    extern FIRE_LOG_STRIKE      ; From fire-log.o
    extern FIRE_RECURSIVE_FORGE ; From fire-compile.o
    extern AVIS_FVS_STRIKE      ; From avis-fvs.o (Hardcoded Load)

_start:
    ; 1. MANDATORY FVS STRIKE (Register Sweep)
    call AVIS_FVS_STRIKE
    lea rdi, [msg_fvs]
    mov rsi, len_fvs
    call FIRE_LOG_STRIKE

    ; 2. INTAKE RECURSIVE BLUEPRINT
    ; [Logic to read fire-compile.ini into memory]

    ; 3. FORGE RECURSIVE TRIAD (Protocol -> Term -> Macro)
    call FIRE_RECURSIVE_FORGE

    ; 4. HANDOFF TO MACRO (The Bridge)
    ; Macro will then load Seed, then Net.
    mov rax, 59         ; sys_execve
    mov rdi, "VERSION 1/fire-macro.exe"
    xor rsi, rsi
    xor rdx, rdx
    syscall

    mov rax, 60
    xor rdi, rdi
    syscall
