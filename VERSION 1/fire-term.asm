; =============================================================
;  AVIS TERMINAL SURFACE — [VERSION 1]
;  FILE: fire-term.asm
;  PURPOSE: Terminal I/O Fusion with Fire-Net
; =============================================================
%include "VERSION 1/fire-gem-asm.inc"

section .data
    msg_term db "AVIS [TERM] Surface Online. Striking Network Bus...", 0xa
    len_term equ 51

section .text
    global _start
    extern FIRE_PROTOCOL_WRAP ; From fire-protocol.o
    extern FIRE_NET_STRIKE    ; From fire-net.o
    extern FIRE_PARSE_PROTOCOL ; From fire-asm.o

_start:
    ; 1. IDENTITY WRAP
    lea rdi, [msg_term]
    mov rsi, len_term
    call FIRE_PROTOCOL_WRAP

    ; 2. INTAKE INI COMMANDS
    ; The "Little Bot" logic follows the [TERM][AVIS] sector
    ; Triggering the SWITCH : CURL:IO:POST:MAIL:PROTOCOL
    call FIRE_NET_STRIKE

    ; 3. EVALUATION
    ; Firing fire-asm.asm logic to evaluate the results
    call FIRE_PARSE_PROTOCOL

    mov rax, 60
    xor rdi, rdi
    syscall
