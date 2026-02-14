; =============================================================================
;  AVIS MASTER ENGINE — [PHASED RECURSIVE LOAD]
;  FILE: fire-gem.asm
; =============================================================================

section .data
    ini_path  db "VERSION 1/fire-compile.ini", 0
    msg_ph1   db "AVIS [PHASE-1] Striking Compiler with .inc... HAHA!", 0xa

section .bss
    ini_buf   resb 8192

section .text
    global _start
    extern FIRE_LOG_STRIKE

_start:
    ; 1. INTAKE INI
    ; [Logic to read fire-compile.ini into ini_buf]

    ; 2. [SESSION 1]: COMPILE THE COMPILER
    ; Gem executes the STRIKE_COMPILER string from INI
    ; This uses the fire-gem.inc file during assembly
    lea rdi, [msg_ph1]
    mov rsi, 52
    call FIRE_LOG_STRIKE
    
    ; 3. [SESSION 2]: RECURSIVE LOAD
    ; Only runs after the Terminal has power.
    ; Gem calls fire-compile.exe to forge Protocol -> Term -> Macro.

    mov rax, 60
    xor rdi, rdi
    syscall
