; =============================================================================
;  AVIS-CORE // MASTER EXTENSION 1
;  FILE: fire-gem-ext-1.asm
;  PURPOSE: Real-time Execution of Parsed FGEO Macros
;  DEPENDENCY: fire-term.asm // PROTOCOL: fire-asm.asm
; =============================================================================
%include "VERSION 1/fire-gem-asm.inc"

section .data
    msg_ext  db "AVIS [LLM-LOG-OBJ][EXT-1] Terminal Handoff Verified. Executing FGEO...", 0xa
    len_ext  equ 66

section .text
    global _start
    extern FIRE_PROTOCOL_WRAP ; From fire-protocol.o
    extern FIRE_PARSE_PROTOCOL ; From fire-asm.o

_start:
    ; 1. VERIFY TERMINAL HANDOFF
    lea rdi, [msg_ext]
    mov rsi, len_ext
    call FIRE_PROTOCOL_WRAP

    ; 2. INTAKE BUFFERED FGEOs
    ; Accessing the load vector defined in fire-gem-asm.inc
    mov rsi, FGEO_LOAD_VECTOR 

    ; 3. THE EXECUTION STRIKE
    ; Extension performs the heavy lifting for the Terminal
    call EXECUTE_FGEO_STRIKE

    ; 4. RETURN TO MASTER ENGINE
    mov rax, 60
    xor rdi, rdi
    syscall

EXECUTE_FGEO_STRIKE:
    push rbp
    mov rbp, rsp

    ; --- HARDWARE EXECUTION LOOP ---
    ; Processes the assembled buffer of executable objects
    ; This is the "Post-Terminal" state of the machine.
    
    leave
    ret
