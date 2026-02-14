; =============================================================================
;  AVIS-CYHY // THE LANGUAGE ENGINE [VERSION 1]
;  FILE: fire-cyhy.asm
;  PURPOSE: Intake FGEO JSON Nests and Execute GEM Exports
; =============================================================================
%include "VERSION 1/fire-gem-asm.inc"

section .data
    msg_cyhy db "AVIS [CYHY] Language Engaged. Intaking FGEO Nest...", 0xa
    len_cyhy equ 52

section .text
    global _start
    extern EXPORT_GCC_COMPILE    ; The Hardcoded GCC Function from GEM
    extern EXPORT_BASH_RUN       ; The Hardcoded BASH Function from GEM
    extern FIRE_LOG_STRIKE

_start:
    ; 1. STRIKE THE AVIS VOICE
    lea rdi, [msg_cyhy]
    mov rsi, len_cyhy
    call FIRE_LOG_STRIKE

    ; 2. INTAKE THE JSON NEST (0x8000)
    ; Logic here parses the "fgeo_wrapper" from cyhy_init.json
    
    ; 3. STRIKE THE GEM EXPORTS
    ; Building the string for GCC and BASH based on the Nest
    call EXPORT_GCC_COMPILE
    call EXPORT_BASH_RUN

    ; 4. INITIALIZE PACKAGE INSTALL
    ; Once Cyhy is installed, it begins to package the Triad
    mov rax, 60
    xor rdi, rdi
    syscall
