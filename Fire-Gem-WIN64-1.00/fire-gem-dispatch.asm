;===========================================================
; AVIS FILE IDENTITY BLOCK
;===========================================================
; CY_FILENAME: fire-gem-dispatch.asm
; CY_NAME: FIRE_GEM_DISPATCH_ASM
; CY_TYPE: ASM_MODULE
; CY_ROLE: COMMAND_DISPATCHER
; CY_SUBSYS: FIRE_GEM
; CY_VERSION: 01.00
; CY_GUID: {D15P-47CH-0000-AAAABBBBCCCCDDDD}
; CY_BUILD: MANUAL
; CY_NOTES: MATCHES INPUT AGAINST VTABLE AND EXECUTES HANDLERS.
;===========================================================

default rel

extern FG_PrintString
extern FG_StrLen
extern FG_InputBuffer
extern FG_NewLine

; from your vtable file
extern FG_VTABLE_START
extern FG_VTABLE_END

SECTION .data
Msg_UnknownCmd  db "Unknown command: ",0

SECTION .text
global FG_DispatchCommand
global FG_StrCmp


;-----------------------------------------------------------
; FG_DispatchCommand
; RCX = pointer to input string (FG_InputBuffer)
;-----------------------------------------------------------
FG_DispatchCommand:
    push rbp
    mov  rbp, rsp

    mov rsi, FG_VTABLE_START

.next_entry:
    cmp rsi, FG_VTABLE_END
    jae .unknown

    ; rsi -> [command_string_ptr, handler_ptr]
    mov rdx, [rsi]        ; command string pointer
    mov r8,  [rsi+8]      ; handler pointer

    ; compare input with command
    mov rcx, FG_InputBuffer
    mov rdx, rdx
    call FG_StrCmp
    cmp rax, 1
    je .execute

    add rsi, 16
    jmp .next_entry

.execute:
    call r8
    jmp .done

.unknown:
    mov rcx, Msg_UnknownCmd
    call FG_PrintString
    mov rcx, FG_InputBuffer
    call FG_PrintString
    mov rcx, FG_NewLine
    call FG_PrintString

.done:
    pop rbp
    ret


;-----------------------------------------------------------
; FG_StrCmp
; RCX = string A
; RDX = string B
; returns RAX = 1 if equal, 0 otherwise
;-----------------------------------------------------------
FG_StrCmp:
    push rbx

.loop:
    mov al, [rcx]
    mov bl, [rdx]
    cmp al, bl
    jne .nomatch
    cmp al, 0
    je .match
    inc rcx
    inc rdx
    jmp .loop

.match:
    mov rax, 1
    pop rbx
    ret

.nomatch:
    mov rax, 0
    pop rbx
    ret
