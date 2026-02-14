; =============================================================
;  AVIS MASTER ENGINE — [VERSION 1]
;  FILE: fire-gem.asm
;  PURPOSE: Use fire-asm.ini to strike the .so Forge and Linking
; =============================================================

section .data
    asm_ini   db "VERSION 1/fire-asm.ini", 0
    log_cmd   db "CMD_LOG_OBJ", 0
    msg_ignite db "[AVIS-GEM] ASM Authority Active. Reading fire-asm.ini...", 0xa

section .text
    global _start
    ; Note: Linker will resolve this after the ASM strike
    extern FIRE_LOG_STRIKE

_start:
    ; 1. OPEN fire-asm.ini
    ; (ASM logic to parse CMD_LOG_OBJ: nasm -f elf64 VERSION 1/fire-log.asm...)
    
    ; 2. STRIKE THE FORGE (sys_execve)
    ; This is where the ASM builds the Log Object and Links the EXE/SO artifacts
    
    ; 3. LOG SUCCESS
    ; Once linked, the engine can finally call the Modular Voice
    lea rdi, [msg_ignite]
    mov rsi, 54
    call FIRE_LOG_STRIKE

    mov rax, 60
    xor rdi, rdi
    syscall
