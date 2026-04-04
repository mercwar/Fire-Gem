; =============================================================
;  AVIS-CORE // MASTER INCLUDE
;  FILE: fire-gem.inc
; =============================================================
%define SYS_WRITE 1
%define SYS_OPEN  2
%define SYS_CLOSE 3
%define SYS_EXECVE 59
%define SYS_EXIT  60

%macro AVIS_HEADER 0
    db "AVIS", 0x01, 0x00
%endmacro
