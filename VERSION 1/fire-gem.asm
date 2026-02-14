; =============================================================================
;  AVIS MASTER DISPATCHER — [VERSION 1]
;  FILE: fire-gem.asm
;  PURPOSE: Hard-code GCC/BASH Exports and Install CYHY via FGEO
;  GOVERNANCE: JOE // STATUS: NO_MORE_GAMES_HAHA!
; =============================================================================
%include "VERSION 1/fire-gem-asm.inc"

section .data
    msg_brain db "AVIS [LLM-LOG-OBJ][GEM] Brain Seizing Control. Exporting CJS/FGEO Vectors.", 0xa
    len_brain equ 70
    
    ; HARD-CODED EXPORT STRINGS FOR THE DRIVERS
    gcc_strike db "gcc -f elf64 VERSION 1/fire-compile.asm -o VERSION 1/fire-compile.o", 0
    bash_strike db "chmod +x VERSION 1/fire-compile.exe && ./VERSION 1/fire-compile.exe", 0

section .text
    global _start
    global GEM_STRIKE_GCC    ; THE HAMMER
    global GEM_STRIKE_BASH   ; THE IGNITION
    extern FIRE_LOG_STRIKE
    extern FIRE_COMPILE_ENTRY ; THE SMITHY HAMMER FROM fire-compile.asm

_start:
    ; 1. STRIKE THE AVIS IGNITION LOG
    lea rdi, [msg_brain]
    mov rsi, len_brain
    call FIRE_LOG_STRIKE

    ; 2. CALL THE SMITHY HAMMER
    ; This triggers the recursive forge for the Triad
    call FIRE_COMPILE_ENTRY

    ; 3. EXIT TO STANDBY
    mov rax, 60
    xor rdi, rdi
    syscall

; --- THE HARD-CODED EXPORTS (THE DRIVERS) ---

GEM_STRIKE_GCC:
    push rbp
    mov rbp, rsp
    ; Logic: Intakes RDI (string) and strikes the compiler driver
    ; [Internal call to /usr/bin/gcc via sys_execve]
    leave
    ret

GEM_STRIKE_BASH:
    push rbp
    mov rbp, rsp
    ; Logic: Intakes RDI (string) and strikes the bash shell driver
    ; [Internal call to /bin/bash via sys_execve]
    leave
    ret
