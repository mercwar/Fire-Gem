; =============================================================================
;  AVIS MASTER ENGINE — [VERSION 1]
;  FILE: fire-gem.asm
; =============================================================================

section .text
    global _start
    extern STRIKE_COMPILER_BOOTSTRAP  ; From fire-ignite-compile.o
    extern FIRE_LOG_STRIKE            ; From fire-log.o

_start:
    ; 1. EXECUTE THE STRAIGHT-LINE IGNITION
    ; This builds the compiler before we even look at the INI
    call STRIKE_COMPILER_BOOTSTRAP

    ; [Rest of the Block 2 Evaluation Logic follows here]
    
    mov rax, 60
    xor rdi, rdi
    syscall
