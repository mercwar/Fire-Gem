; =============================================================================
;  AVIS MASTER ENGINE — [VERSION 1]
;  FILE: fire-gem.asm
;  PURPOSE: Flush Logs and Strike Compiler via EXECVE
;  GOVERNANCE: CVBGOD // STATUS: NO_MORE_EMPTY_LOGS
; =============================================================================
%include "VERSION 1/fire-gem.inc"

section .data
    msg_ignite db "AVIS [BLOCK-1] Ignition: Master Brain Seizing Control.", 0xa
    len_ignite equ 54
    msg_smith  db "AVIS [BLOCK-1] STRIKE: Forging fire-compile.exe...", 0xa
    len_smith  equ 50
    
    nasm_path  db "/usr/bin/nasm", 0
    arg0       db "nasm", 0
    arg1       db "-f", 0
    arg2       db "elf64", 0
    arg3       db "VERSION 1/fire-compile.asm", 0
    arg4       db "-o", 0
    arg5       db "VERSION 1/fire-compile.o", 0

section .text
    global _start
    extern FIRE_LOG_STRIKE

_start:
    ; 1. STRIKE THE AVIS IGNITION LOG (Hits the file immediately)
    lea rdi, [msg_ignite]
    mov rsi, len_ignite
    call FIRE_LOG_STRIKE

    ; 2. STRIKE THE COMPILER FORGE LOG
    lea rdi, [msg_smith]
    mov rsi, len_smith
    call FIRE_LOG_STRIKE

    ; 3. THE HARDWARE FLUSH
    ; We must ensure the Voice (fire-log.asm) has finished the sys_close 
    ; before we replace the process image.
    
    ; 4. THE COMPILER STRIKE (sys_execve)
    mov rax, 59                 ; syscall: execve
    mov rdi, nasm_path          ; /usr/bin/nasm
    
    ; Construct Argument Vector on Stack
    xor rax, rax
    push rax                    ; NULL terminator
    push arg5
    push arg4
    push arg3
    push arg2
    push arg1
    push arg0
    mov rsi, rsp                ; RSI points to stack args
    xor rdx, rdx                ; No environment
    syscall

    ; 5. EXIT (Only if execve fails)
    mov rax, 60
    xor rdi, rdi
    syscall
