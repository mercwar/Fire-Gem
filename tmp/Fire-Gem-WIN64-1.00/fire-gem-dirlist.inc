;===========================================================
; AVIS FILE IDENTITY BLOCK
;===========================================================
; CY_FILENAME: fire-gem-dirlist.inc
; CY_NAME: FIRE_GEM_DIRLIST_INC
; CY_TYPE: ASM_INCLUDE
; CY_ROLE: DIRECTORY_BROWSER_MACROS
; CY_SUBSYS: FIRE_GEM
; CY_VERSION: 01.00
; CY_GUID: {D1R3-CT0R-YL15-M4CR-0000CCCCDDDD}
; CY_BUILD: MANUAL
; CY_NOTES: MACROS FOR DIRECTORY + FILE SELECTION.
;===========================================================

%macro FG_DIRLIST 0
    call FG_ListDirectory
%endmacro
