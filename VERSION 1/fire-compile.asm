; =============================================================
;  AVIS INTERNAL SMITHY [VERSION 1]
;  FILE: fire-compile.asm
;  PURPOSE: Parse fire-compile.ini & Forge the Library Chain
; =============================================================

section .data
    ini_path  db "VERSION 1/fire-compile.ini", 0
    nasm_path db "/usr/bin/nasm", 0
    ld_path   db "/usr/bin/ld", 0
    
    ; Logic Tags
    lib_tag   db "lib_log=", 0
    art_tag   db "fvs_buddy=", 0
    
    msg_forge db "[AVIS-COMPILE] Smithy Engaged: Forging Hardware Libs...", 0xa
    len_forge equ $ - msg_forge

section .bss
    buffer    resb 4096
    target    resb 128

section .text
    global _start
    extern FIRE_LOG_STRIKE

_start:
    ; 1. LOG THE FORGE COMMENCEMENT
    lea rdi, [msg_forge]
    mov rsi, len_forge
    call FIRE_LOG_STRIKE

    ; 2. OPEN & READ THE BLUEPRINT
    mov rax, 2          ; sys_open
    mov rdi, ini_path
    mov rsi, 0          ; O_RDONLY
    syscall
    mov r12, rax        ; r12 = FD

    mov rax, 0          ; sys_read
    mov rdi, r12
    mov rsi, buffer
    mov rdx, 4096
    syscall

    ; --- 3. FORGE LOG OBJECT (PHASE 0) ---
    ; Logic to find "lib_log=fire-log.asm" and call NASM
    ; nasm -f elf64 VERSION 1/fire-log.asm -o VERSION 1/fire-log.o

    ; --- 4. FORGE ARTIFACTS (PHASE 1) ---
    ; Logic to find "fvs_buddy=avis-fvs.asm" and call NASM + LD
    ; ld VERSION 1/avis-fvs.o VERSION 1/fire-log.o -o VERSION 1/avis-fvs.exe

    ; 5. EXIT
    mov rax, 60
    xor rdi, rdi
    syscall
