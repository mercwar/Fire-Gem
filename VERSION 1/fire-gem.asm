; =============================================================================
;  AVIS MASTER ENGINE — [VERSION 1]
;  FILE: fire-gem.asm
; =============================================================================

section .data
    msg_boot db "[AVIS-GEM] Ignition: VERSION 1 Chain Active.", 0xa
    len_boot equ $ - msg_boot
    map_cmd  db "VERSION 1/fire-map.sh", 0

section .text
    global _start
    extern FIRE_LOG_STRIKE

_start:
    ; --- 1. STRIKE IDENTITY LOG ---
    lea rdi, [msg_boot]
    mov rsi, len_boot
    call FIRE_LOG_STRIKE

    ; --- 2. EXECUTE SITEMAP BOT (sys_execve) ---
    mov rax, 59         ; sys_execve
    mov rdi, map_cmd
    xor rsi, rsi
    xor rdx, rdx
    syscall

    mov rax, 60
    xor rdi, rdi
    syscall
