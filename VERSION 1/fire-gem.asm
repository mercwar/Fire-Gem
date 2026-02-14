; =============================================================================
;  AVIS MASTER DISPATCHER — [VERSION 1]
;  FILE: fire-gem.asm
;  PURPOSE: Hard-code GCC/BASH Exports and Install CYHY via FGEO
;  GOVERNANCE: CVBGOD // STATUS: NO_MORE_GAMES_HAHA!
; =============================================================================
%include "VERSION 1/fire-gem-asm.inc"

section .data
    msg_brain db "AVIS [LLM-LOG-OBJ][GEM] Brain Seizing Control. Exporting CJS/FGEO Vectors.", 0xa
    len_brain equ 70
    
    ; HARD-CODED EXPORT STRINGS
    gcc_strike db "gcc -f elf64 VERSION 1/fire-compile.asm -o VERSION 1/fire-compile.o", 0
    bash_strike db "chmod +x VERSION 1/fire-compile.exe && ./VERSION 1/fire-compile.exe", 0

section .text
    global _start
    global EXPORT_GCC_COMPILE ; THE GCC FUNCTION
    global EXPORT_BASH_RUN    ; THE BASH FUNCTION
    extern FIRE_LOG_STRIKE

_start:
    ; 1. STRIKE THE AVIS IGNITION LOG
    lea rdi, [msg_brain]
    mov rsi, len_brain
    call FIRE_LOG_STRIKE

    ; 2. INITIALIZE CYHY DEVICE (0x8000)
    ; GEM reads INI and seats the CYHY installation info
    call SEAT_CYHY_DEVICE

    ; 3. THE FGEO INSTALLATION STRIKE
    ; Uses EXPORT_GCC_COMPILE to build the Smithy (compile.asm)
    lea rdi, [gcc_strike]
    call EXPORT_GCC_COMPILE
    
    ; Uses EXPORT_BASH_RUN to ignite the Smithy
    lea rdi, [bash_strike]
    call EXPORT_BASH_RUN

    ; 4. EXIT TO STANDBY (Wait for CYHY packaging)
    mov rax, 60
    xor rdi, rdi
    syscall

; --- THE HARD-CODED EXPORTS ---

EXPORT_GCC_COMPILE:
    ; Intakes RDI (string) and strikes the compiler driver
    ; Built to forge compile.asm or macro.asm
    push rbp
    mov rbp, rsp
    ; [Logic: Internal call to /usr/bin/gcc]
    leave
    ret

EXPORT_BASH_RUN:
    ; Intakes RDI (string) and strikes the bash shell driver
    ; Built to execute the forged Smithy or Macro
    push rbp
    mov rbp, rsp
    ; [Logic: Internal call to /bin/bash]
    leave
    ret

SEAT_CYHY_DEVICE:
    ; Logic to map DEVICE: CYHY from fire-gem.ini to 0x8000
    ret
