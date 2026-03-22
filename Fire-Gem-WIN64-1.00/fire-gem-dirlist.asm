;===========================================================
; AVIS FILE IDENTITY BLOCK
;===========================================================
; CY_FILENAME: fire-gem-dirlist.asm
; CY_NAME: FIRE_GEM_DIRLIST_ASM
; CY_TYPE: ASM_MODULE
; CY_ROLE: DIRECTORY_BROWSER
; CY_SUBSYS: FIRE_GEM
; CY_VERSION: 01.00
; CY_GUID: {D1R3-CT0R-YL15-0000-AAAABBBBCCCC}
; CY_BUILD: MANUAL
; CY_NOTES: LISTS /INI /JSON /ASM.
;===========================================================

default rel

extern FG_PrintString
extern FG_ReadLine
extern FindFirstFileA
extern FindNextFileA
extern FindClose

SECTION .data
Dir_Entry       times 512 db 0
Dir_Input       times 256 db 0

Msg_SelectDir   db "Select directory [ini/json/asm]: ",0
Msg_ListHeader  db "--- Directory Listing ---",13,10,0

Dir_Ini         db "ini\\*",0
Dir_Json        db "json\\*",0
Dir_Asm         db "asm\\*",0

SECTION .text
global FG_ListDirectory

FG_ListDirectory:
    mov rcx, Msg_SelectDir
    call FG_PrintString

    mov rcx, Dir_Input
    call FG_ReadLine

    ; crude compare
    mov rcx, Dir_Input
    mov rdx, Dir_Ini
    call FG_StrCmp
    jz .ini

    mov rcx, Dir_Input
    mov rdx, Dir_Json
    call FG_StrCmp
    jz .json

    mov rcx, Dir_Input
    mov rdx, Dir_Asm
    call FG_StrCmp
    jz .asm

    ret

.ini:
    mov rcx, Dir_Ini
    jmp FG_ListPattern

.json:
    mov rcx, Dir_Json
    jmp FG_ListPattern

.asm:
    mov rcx, Dir_Asm
    jmp FG_ListPattern

; RCX = pattern
FG_ListPattern:
    mov rdx, Dir_Entry
    call FindFirstFileA
    cmp rax, -1
    je .done

.loop:
    mov rcx, Dir_Entry
    call FG_PrintString
    mov rcx, FG_NewLine
    call FG_PrintString

    mov rcx, rax
    mov rdx, Dir_Entry
    call FindNextFileA
    test rax, rax
    jnz .loop

.done:
    call FindClose
    ret
