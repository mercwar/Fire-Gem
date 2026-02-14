; =============================================================
;  AVIS-CORE // MACRO I/O STUB
;  FILE: fire-macro.asm
;  PURPOSE: Manage Net I/O and handoff to fire-spec
; =============================================================

section .text
    global _start
    extern AVIS_EXEC_WRAP  ; Imported from fire-protocol
    extern FIRE_NET_INTAKE ; Imported from fire-net

_start:
    ; 1. INTAKE FROM NET
    ; fire-net parses the ini-objects and returns the command vector
    call FIRE_NET_INTAKE 
    
    ; 2. VALIDATE VIA PROTOCOL
    ; RDI already contains the command pointer from fire-net
    call AVIS_EXEC_WRAP

    ; 3. HANDOFF TO SPEC (sys_execve or Jump to fire-spec)
    ; The macro doesn't execute; it just moves to the next sector
    jmp FIRE_SPEC_EXECUTE 

    mov rax, 60
    xor rdi, rdi
    syscall
