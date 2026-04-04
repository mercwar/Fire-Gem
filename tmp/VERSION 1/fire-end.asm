; =============================================================================
;  AVIS TERMINAL SEAL — [CVBGOD AUTHORITY]
;  FILE: fire-end.asm
;  PURPOSE: Final Registry Flush & Vault Migration
; =============================================================================

section .data
    vault_path db "VERSION 1/fire-log/CVBGOD-SEAL-", 0
    old_log    db "VERSION 1/fire-gem.log", 0
    ext        db ".avis", 0
    msg_seal   db "[SYNC] CVBGOD AUTHORITY: TERMINAL SEAL COMPLETE. HAHA!", 0xa

section .bss
    new_path   resb 128
    tv         resq 2

section .text
    global _start
    extern FIRE_LOG_STRIKE

_start:
    ; 1. STRIKE THE FINAL AUTHORITY MESSAGE
    lea rdi, [msg_seal]
    mov rsi, 54
    call FIRE_LOG_STRIKE

    ; 2. GET HIGH-PRECISION TIMESTAMP (sys_gettimeofday: 96)
    mov rax, 96
    lea rdi, [tv]
    xor rsi, rsi
    syscall

    ; 3. CONSTRUCT VAULT FILENAME
    lea rdi, [new_path]
    lea rsi, [vault_path]
.copy_pre:
    lodsb
    test al, al
    jz .add_hex
    stosb
    jmp .copy_pre

.add_hex:
    mov rax, [tv]       ; Load Seconds
    mov rcx, 16
.hex_loop:
    rol rax, 4
    mov rbx, rax
    and rbx, 0x0F
    add bl, 0x30
    cmp bl, 0x39
    jle .store
    add bl, 7
.store:
    mov [rdi], bl
    inc rdi
    loop .hex_loop

    lea rsi, [ext]
.copy_ext:
    lodsb
    test al, al
    jz .do_rename
    stosb
    jmp .copy_ext

.do_rename:
    mov byte [rdi], 0

    ; 4. ATOMIC MIGRATION (sys_rename: 82)
    mov rax, 82
    mov rdi, old_log
    lea rsi, [new_path]
    syscall

    ; 5. EXIT
    mov rax, 60
    xor rdi, rdi
    syscall
