; =============================================================
;  AVIS-NET // RPC INTAKE
;  FILE: fire-net.asm
;  PURPOSE: Parse INI Command Objects & Feed Macro
; =============================================================

section .data
    ini_path db "VERSION 1/fire-gem.ini", 0

section .bss
    net_buf  resb 1024

section .text
    global FIRE_NET_INTAKE
    global _start

_start:
    ; (Terminal Entry Point for Net Surface)
    call FIRE_NET_INTAKE
    mov rax, 60
    xor rdi, rdi
    syscall

FIRE_NET_INTAKE:
    ; 1. OPEN INI & EXTRACT STRIKE_01 (CURL DATA)
    ; 2. RETURN BUFFER POINTER IN RDI
    lea rdi, [net_buf]
    ret
