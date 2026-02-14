; =============================================================================
;  AVIS MASTER ENGINE — [VERSION 1]
;  FILE: fire-gem.asm
;  PURPOSE: Seize Control, Intake INI, and Strike Recursive Forge
;  GOVERNANCE: CVBGOD // STATUS: INTERNAL_SMITHY_READY
; =============================================================================

section .data
    msg_boot  db "AVIS [LLM-LOG-OBJ][GEM] Ignition: Master Brain Seizing Control.", 0xa
    len_boot  equ $ - msg_boot
    
    ini_path  db "VERSION 1/fire-gem.ini", 0
    
    ; Internal Handoff Target
    macro_exe db "VERSION 1/fire-macro.exe", 0

section .bss
    ini_buf   resb 4096

section .text
    global _start
    extern FIRE_LOG_STRIKE      ; From fire-log.o
    extern FIRE_RECURSIVE_FORGE ; From fire-compile.o (The Smith)

_start:
    ; 1. STRIKE THE IDENTITY HANDSHAKE
    ; This proves the Brain is linked to the Voice
    lea rdi, [msg_boot]
    mov rsi, len_boot
    call FIRE_LOG_STRIKE

    ; 2. INTAKE THE REGISTRY (Dumb-Load to Smart-Forge)
    mov rax, 2          ; sys_open
    mov rdi, ini_path
    mov rsi, 0          ; O_RDONLY
    syscall
    test rax, rax
    js .error_exit
    mov r12, rax        ; Save FD

    mov rax, 0          ; sys_read
    mov rdi, r12
    mov rsi, ini_buf
    mov rdx, 4096
    syscall
    
    mov rax, 3          ; sys_close
    mov rdi, r12
    syscall

    ; 3. TRIGGER INTERNAL SMITHY (Recursive Forge)
    ; This calls the logic in fire-compile.o to forge the extensions
    ; (Macro, Term, Net, Seed, Spec)
    call FIRE_RECURSIVE_FORGE

    ; 4. THE GRAND HANDOFF (sys_execve)
    ; Once the smithy is done, the Brain abdicates to the Macro Bridge
    mov rax, 59         ; sys_execve
    mov rdi, macro_exe
    xor rsi, rsi
    xor rdx, rdx
    syscall

.error_exit:
    mov rax, 60         ; sys_exit
    mov rdi, 1
    syscall
