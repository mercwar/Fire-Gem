; =============================================================================
;  AVIS MASTER DISPATCHER — [VERSION 1]
;  FILE: fire-gem.asm
;  PURPOSE: Dispatch COMPILE/RUN Vectors & Trigger Smithy
;  GOVERNANCE: JOE // STATUS: SECTOR_STABLE_HAHA!
; =============================================================================
%include "VERSION 1/fire-gem-asm.inc"

section .data
    msg_brain db "AVIS [LLM-LOG-OBJ][GEM] Brain Seizing Control. Identity: JOE.", 0xa
    len_brain equ 62
    
    ; HARD-CODED EXPORT STRINGS FOR THE FGEO FORGE
    gcc_strike db "gcc -f elf64 VERSION 1/fire-compile.asm -o VERSION 1/fire-compile.o", 0
    bash_strike db "chmod +x VERSION 1/fire-compile.exe && ./VERSION 1/fire-compile.exe", 0

section .text
    global _start
    global GEM_STRIKE_GCC    ; EXPORT 1: THE HAMMER
    global GEM_STRIKE_BASH   ; EXPORT 2: THE IGNITION
    extern FIRE_LOG_STRIKE
    extern FIRE_COMPILE_ENTRY ; THE SMITHY ENTRY (from fire-compile.asm)

_start:
    ; 1. STRIKE THE AVIS IGNITION LOG
    lea rdi, [msg_brain]
    mov rsi, len_brain
    call FIRE_LOG_STRIKE

    ; 2. CALL THE SMITHY HAMMER (PHASE 2)
    ; This triggers the forge for Macro, Term, and Cyhy
    call FIRE_COMPILE_ENTRY

    ; 3. EXIT TO STANDBY
    mov rax, 60
    xor rdi, rdi
    syscall

; --- THE HARD-CODED EXPORTS (THE DRIVERS) ---

GEM_STRIKE_GCC:
    push rbp
    mov rbp, rsp
    ; RDI contains the compile string
    ; [Hardware execution via sys_execve]
    leave
    ret

GEM_STRIKE_BASH:
    push rbp
    mov rbp, rsp
    ; RDI contains the run string
    ; [Hardware execution via sys_execve]
    leave
    ret
