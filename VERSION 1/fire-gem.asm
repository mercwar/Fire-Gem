; =============================================================================
;  AVIS MASTER ENGINE — [RECURSIVE EXECUTIVE]
;  FILE: fire-gem.asm
;  PURPOSE: Intake INI, Verify Triad, and Handoff to Internal Smithy
; =============================================================================

section .data
    ini_path  db "VERSION 1/fire-compile.ini", 0
    msg_ignite db "AVIS [LLM-LOG-OBJ][GEM] Triad Fusion Verified. Seizing Authority.", 0xa
    len_ignite equ $ - msg_ignite

section .bss
    ini_buf   resb 8192

section .text
    global _start
    extern FIRE_LOG_STRIKE      ; From fire-log.o
    extern FIRE_RECURSIVE_FORGE ; From fire-compile.o (The Smith)

_start:
    ; 1. STRIKE THE IDENTITY HANDSHAKE
    lea rdi, [msg_ignite]
    mov rsi, len_ignite
    call FIRE_LOG_STRIKE

    ; 2. INTAKE THE RECURSIVE BLUEPRINT
    mov rax, 2          ; sys_open
    mov rdi, ini_path
    mov rsi, 0          ; O_RDONLY
    syscall
    mov r12, rax        ; Save FD

    mov rax, 0          ; sys_read
    mov rdi, r12
    mov rsi, ini_buf
    mov rdx, 8192
    syscall

    ; 3. INTERNAL SMITHY STRIKE
    ; Calls the code from fire-compile.o which is now inside this binary.
    ; It evaluates the [EXTENSIONS] sector and builds the paths.
    call FIRE_RECURSIVE_FORGE

    ; 4. TERMINAL HANDOFF
    ; Once the smithy verifies the loop, we transition to the Terminal Surface
    mov rax, 60
    xor rdi, rdi
    syscall
