; =============================================================
;  AVIS PROTOCOL ENGINE // EXECUTION WRAPPER
;  FILE: fire-protocol.asm
;  PURPOSE: Encapsulate and Validate Execution Strikes
; =============================================================

section .data
    msg_exec db "AVIS [LLM-LOG-OBJ][EXEC] Striking Hardware Vector: ", 0
    len_exec equ $ - msg_exec

section .text
    global AVIS_EXEC_WRAP
    extern FIRE_LOG_STRIKE

AVIS_EXEC_WRAP:
    push rbp
    mov rbp, rsp
    ; RDI = Command String Pointer | RSI = Command Length
    
    ; 1. LOG THE INTENT (Protocol Audit)
    push rsi
    push rdi
    lea rdi, [msg_exec]
    mov rsi, len_exec
    call FIRE_LOG_STRIKE
    
    ; 2. LOG THE COMMAND BODY
    pop rdi
    pop rsi
    call FIRE_LOG_STRIKE
    
    leave
    ret
