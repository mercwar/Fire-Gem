; fire-gem-dialog.asm
; Common file dialog for selecting INI

default rel

section .data
FG_IniPath   db 260 dup(0)

section .text
global FG_ShowOpenIniDialog

FG_ShowOpenIniDialog:
    ; TODO: Implement a standard OpenFile dialog for *.ini
    ; On success:
    ;   - store full path in FG_IniPath
    ;   - return pointer in RAX
    ; On cancel:
    ;   - return 0 in RAX
    xor rax, rax
    ret
