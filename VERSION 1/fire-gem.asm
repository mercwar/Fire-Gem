; =============================================================
;  AVIS MASTER ENGINE — [THE SUPREME SMITHY]
;  FILE: fire-gem.asm
;  PURPOSE: Forge the Triad (Compile, Macro, Term) & Handoff
; =============================================================

section .data
    msg_ignite db "AVIS [LLM-LOG-OBJ][SMITHY] Triad Forge Engaged. HAHA!", 0xa
    len_ignite equ $ - msg_ignite

    ; --- THE INTERNAL FORGE MANIFEST ---
    ; Fire-Gem builds the world's tools, then the Macro runs them.
    cmd_comp  db "/usr/bin/nasm -f elf64 VERSION 1/fire-compile.asm -o VERSION 1/fire-compile.o", 0
    cmd_macr  db "/usr/bin/nasm -f elf64 VERSION 1/fire-macro.asm -o VERSION 1/fire-macro.o", 0
    cmd_term  db "/usr/bin/nasm -f elf64 VERSION 1/fire-term.asm -o VERSION 1/fire-term.o", 0
    
    ; Linker Strike: Linking Macro with the Protocol and Log
    cmd_link  db "/usr/bin/ld VERSION 1/fire-macro.o VERSION 1/fire-protocol.o VERSION 1/fire-log.o -o VERSION 1/fire-macro.exe", 0

    ; The Handoff Target
    macro_exe  db "VERSION 1/fire-macro.exe", 0

section .text
    global _start
    extern FIRE_LOG_STRIKE

_start:
    ; 1. LOG THE SUPREME IGNITION
    lea rdi, [msg_ignite]
    mov rsi, len_ignite
    call FIRE_LOG_STRIKE

    ; 2. THE INTERNAL SMITHY STRIKE (sys_execve)
    ; Fire-Gem forges the Compiler, the Macro, and the Terminal Surface.
    ; [Hardware Logic to execute cmd_comp, cmd_macr, cmd_term, and cmd_link]

    ; 3. THE GRAND HANDOFF
    ; Fire-Gem is done. It loads the Macro. 
    ; The Macro will then load the Compiler to strike the rest of the chain.
    mov rax, 59         ; sys_execve
    mov rdi, macro_exe
    xor rsi, rsi
    xor rdx, rdx
    syscall

    ; --- FAILSAFE ---
    mov rax, 60
    xor rdi, rdi
    syscall
