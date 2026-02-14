; =============================================================
;  AVIS-NET // CURL:IO PROTOCOL
;  FILE: fire-net.asm
; =============================================================
%include "VERSION 1/fire-gem-asm.inc"

section .data
    curl_cmd db "/usr/bin/curl", 0
    ; Arguments are intaken from [AVIS_CGI_CONFIG]
    
section .text
    global FIRE_NET_STRIKE
    extern FIRE_PROTOCOL_WRAP

FIRE_NET_STRIKE:
    push rbp
    mov rbp, rsp

    ; --- THE CURL STRIKE ---
    ; sys_execve to strike the GitHub API Bus
    ; This is the Mail Protocol you commanded
    
    leave
    ret
