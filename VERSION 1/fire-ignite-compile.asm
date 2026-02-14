; =============================================================================
;  AVIS-CORE // PHASE 1 IGNITION
;  FILE: fire-ignite-compile.asm
;  PURPOSE: Hardcoded Hardware Strike to Forge fire-compile.o
; =============================================================================

section .data
    nasm_path db "/usr/bin/nasm", 0
    arg0      db "nasm", 0
    arg1      db "-f", 0
    arg2      db "elf64", 0
    arg3      db "VERSION 1/fire-compile.asm", 0
    arg4      db "-o", 0
    arg5      db "VERSION 1/fire-compile.o", 0

    ; Argument Vector for sys_execve
    argv      dq arg0, arg1, arg2, arg3, arg4, arg5, 0

section .text
    global STRIKE_COMPILER_BOOTSTRAP

STRIKE_COMPILER_BOOTSTRAP:
    push rbp
    mov rbp, rsp

    ; --- THE STRAIGHT LINE STRIKE (sys_execve: 59) ---
    mov rax, 59         ; syscall number for execve
    mov rdi, nasm_path  ; program to run
    lea rsi, [argv]     ; arguments
    xor rdx, rdx        ; no environment variables
    syscall

    ; If syscall returns, it failed.
    leave
    ret
