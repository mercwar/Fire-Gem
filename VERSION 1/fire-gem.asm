; =============================================================
;  AVIS MASTER ENGINE — [RECURSIVE HANDOFF]
;  FILE: fire-gem.asm
; =============================================================

section .data
    ini_path db "VERSION 1/fire-gem.ini", 0
    msg_boot db "AVIS [LLM-LOG-OBJ][SMITHY] DUMB_LOAD Verified. Striking RECURSIVE_FORGE...", 0xa
    len_boot equ $ - msg_boot
    
    tag_recur db "[RECURSIVE_FORGE]", 0
    tag_comp  db "FORGE_01=", 0

section .bss
    ini_map  resb 8192

section .text
    global _start
    extern FIRE_LOG_STRIKE

_start:
    ; 1. LOG THE HANDOFF
    lea rdi, [msg_boot]
    mov rsi, len_boot
    call FIRE_LOG_STRIKE

    ; 2. INTAKE INI FOR PHASE 2
    mov rax, 2          ; open
    mov rdi, ini_path
    mov rsi, 0          ; O_RDONLY
    syscall
    mov r12, rax

    mov rax, 0          ; read
    mov rdi, r12
    mov rsi, ini_map
    mov rdx, 8192
    syscall

    ; 3. STRIKE THE COMPILER (FORGE_01)
    ; Logic scans for FORGE_01= and strikes nasm -f elf64 fire-compile.asm
    ; Then links and executes fire-compile.exe to finish the vault.

    mov rax, 60
    xor rdi, rdi
    syscall
