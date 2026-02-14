; =============================================================
;  AVIS MASTER DISPATCHER — [VERSION 1]
;  FILE: fire-gem.asm
;  EXPORTS: GEM_STRIKE_GCC, GEM_STRIKE_BASH
; =============================================================
section .text
    global _start
    global GEM_STRIKE_GCC
    global GEM_STRIKE_BASH
    extern FIRE_LOG_STRIKE

_start:
    ; Ignition logic here (Intake fire-gem.ini)
    mov rax, 60
    xor rdi, rdi
    syscall

GEM_STRIKE_GCC:
    push rbp
    mov rbp, rsp
    ; RDI = command string pointer
    ; STRIKE: /usr/bin/gcc
    mov rax, 59             ; sys_execve
    mov rdi, gcc_path
    ; ... build arg vector ...
    syscall
    leave
    ret

GEM_STRIKE_BASH:
    push rbp
    mov rbp, rsp
    ; STRIKE: /bin/bash
    mov rax, 59             ; sys_execve
    mov rdi, bash_path
    syscall
    leave
    ret

section .data
    gcc_path db "/usr/bin/gcc", 0
    bash_path db "/bin/bash", 0
