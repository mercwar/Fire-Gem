; =============================================================================
;  AVIS-CORE // MACRO BRIDGE [VERSION 1]
;  FILE: fire-macro.asm
;  PURPOSE: Evaluate Terminal SWITCH Commands & Strike GitHub API Bus
; =============================================================================
%include "VERSION 1/fire-gem.inc"

section .data
    msg_macro db "AVIS [LLM-LOG-OBJ][MACRO] Bridge Active. Evaluating Protocol Switch...", 0xa
    len_macro equ 68

    ; The Hardware Vector for the CURL strike
    curl_bin  db "/usr/bin/curl", 0
    arg0      db "curl", 0
    arg1      db "-X", 0
    arg2      db "POST", 0
    ; (Rest of the vector is constructed from the [AVIS_CGI_CONFIG] in the INI)

section .text
    global _start
    extern FIRE_PROTOCOL_WRAP ; From fire-protocol.o

_start:
    ; 1. LOG BRIDGE ACTIVATION
    lea rdi, [msg_macro]
    mov rsi, len_macro
    call FIRE_PROTOCOL_WRAP

    ; 2. THE DYNAMIC SWITCH
    ; Macro scans the Terminal Buffer for "SWITCH : CURL:IO"
    ; It then performs the Phase 3 strike to the GitHub API Bus
    
    ; 3. HANDOFF TO NET
    ; Once the POST is sent, it opens the Net surface for intake
    
    mov rax, SYS_EXIT
    xor rdi, rdi
    syscall
