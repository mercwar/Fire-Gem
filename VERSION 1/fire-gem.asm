; VERSION 1/fire-gem.asm
section .data
    msg_boot db "[AVIS-GEM] Ignition: VERSION 1 Engine Active. HAHA!", 0xa
    len_boot equ $ - msg_boot

section .text
    global _start
    extern FIRE_LOG_STRIKE

_start:
    ; --- STRIKE THE LOG VIA MODULAR OBJECT ---
    lea rdi, [msg_boot]
    mov rsi, len_boot
    call FIRE_LOG_STRIKE

    ; --- TERMINAL LOOP HANDOFF ---
    ; Logic to parse VERSION 1/fire-term.ini follows...

    mov rax, 60
    xor rdi, rdi
    syscall
