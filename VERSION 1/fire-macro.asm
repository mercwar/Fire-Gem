; =============================================================
;  AVIS-MACRO // LOGIC BRIDGE
;  FILE: fire-macro.asm
; =============================================================

section .text
    global _start
    extern FIRE_NET_INTAKE      ; From fire-net.o
    extern FIRE_PROTOCOL_STRIKE  ; From fire-protocol.o
    extern FIRE_SPEC_EXECUTE    ; From fire-spec.o

_start:
    ; 1. INTAKE FROM NET (CURL DATA)
    call FIRE_NET_INTAKE
    
    ; 2. VERIFY & LOG VIA PROTOCOL (The file you gave me)
    ; This ensures every command gets the "AVIS" header strike
    call FIRE_PROTOCOL_STRIKE

    ; 3. EXECUTE VIA SPEC
    call FIRE_SPEC_EXECUTE

    mov rax, 60
    xor rdi, rdi
    syscall
