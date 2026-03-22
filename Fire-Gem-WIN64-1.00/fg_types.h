// fg_types.h
#ifndef FG_TYPES_H
#define FG_TYPES_H

#include <windows.h>

typedef struct {
    char directory[MAX_PATH];
    char working_dir[MAX_PATH];
} FG_INI;

// Existing JSON macro type:
typedef struct {
    char jsonPath[MAX_PATH];
    char scriptPath[MAX_PATH];
    char bash[1024];
} FG_JSON_MACRO;

// Backward‑compat alias:
typedef FG_JSON_MACRO FG_MACRO;

#endif
