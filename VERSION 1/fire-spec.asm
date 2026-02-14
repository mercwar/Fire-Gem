; =============================================================
;  AVIS-SPEC // HARDWARE EXECUTOR
;  FILE: fire-spec.asm
;  PURPOSE: Perform sys_execve after Protocol Verification
; =============================================================

section .text
    global FIRE_SPEC_EXECUTE

FIRE_SPEC_EXECUTE:
    ; RDI = Command Target from Macro
    mov rax, 59         ; sys_execve
    xor rsi, rsi
    xor rdx, rdx
    syscall
    ret
