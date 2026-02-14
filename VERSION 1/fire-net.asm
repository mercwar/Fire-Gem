; =============================================================================
;  AVIS-NET // RPC SURFACE [VERSION 1]
;  FILE: fire-net.asm
; =============================================================================

section .data
    msg_net   db "AVIS [LLM-LOG-OBJ][AVIS-NET] RPC Surface: BROADCAST_START", 0xa
    len_net   equ $ - msg_net
    html_hdr  db "<avis-event class='proc-call'>", 0
    html_ftr  db "</avis-event>", 0

section .text
    global _start
    extern FIRE_LOG_STRIKE

_start:
    ; 1. STRIKE THE INITIAL RPC HANDSHAKE
    lea rdi, [msg_net]
    mov rsi, len_net
    call FIRE_LOG_STRIKE

    ; 2. SCAN INI FOR LOG_LEVEL (Logic to check GLOBAL_LEVEL=2)
    ; If Level 2, we wrap in HTML Printouts
    
    ; 3. THE HTML PRINTOUT STRIKE
    lea rdi, [html_hdr]
    mov rsi, 29
    call FIRE_LOG_STRIKE   ; Every proc call now gets an HTML wrapper

    ; [PROCEDURE CALL LOGIC HERE]
    ; Every sub-process strike is now a mapped AVIS object

    lea rdi, [html_ftr]
    mov rsi, 13
    call FIRE_LOG_STRIKE

    mov rax, 60
    xor rdi, rdi
    syscall

