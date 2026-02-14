; =============================================================================
;  AVIS-CORE // FGEO BUFFER & CJS SHORTCUTS
;  FILE: fire-gem-asm.inc
; =============================================================================

; CJS Shortcut: Execute a parse strike from JSON source
%macro CJS_PARSE_STRIKE 1
    mov rdi, %1          ; Pointer to JSON file (local/shipped/custom)
    call FIRE_PARSE_PROTOCOL
%endmacro

; Memory mappings for the FGEO buffer
%define FGEO_LOAD_VECTOR 0x8000
%define JSON_SPEC_PATH "VERSION 1/protocol_spec.json"
