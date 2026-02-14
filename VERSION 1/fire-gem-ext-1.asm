; =============================================================================
;  AVIS-CORE // MASTER EXTENSION 1
;  FILE: fire-gem-ext-1.asm
;  DEPENDENCY: fire-term.asm // READER: cjs.asm
; =============================================================================
%include "VERSION 1/fire-gem-asm.inc"

section .text
    global _start
    extern FIRE_PROTOCOL_WRAP
    extern CJS_READ_PROTOCOL   ; From cjs.o

_start:
    ; 1. TERMINAL HANDOFF VERIFICATION
    ; 2. CALL CJS TO READ JSON SPEC
    call CJS_READ_PROTOCOL

    ; 3. EXECUTE ASSEMBLED FGEOs
    ; The terminal is now clear to fire.
    
    mov rax, 60
    xor rdi, rdi
    syscall
