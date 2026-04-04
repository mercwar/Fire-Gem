// macro_builder.c
#include <windows.h>
#include <stdio.h>
#include <string.h>
#include "macro_builder.h"
#include "json_loader.h"

static void Log(HWND hEdit, const char *text)
{
    int len = GetWindowTextLengthA(hEdit);
    SendMessageA(hEdit, EM_SETSEL, len, len);
    SendMessageA(hEdit, EM_REPLACESEL, FALSE, (LPARAM)text);
}

BOOL FG_BuildMacro(FG_MACRO *macro, const char *workingDir, HWND log)
{
    Log(log, "[build] Starting macro build...\r\n");

    if (!FG_ExtractScriptFromJson(macro)) {
        Log(log, "[build] ERROR: JSON missing \"script\" field.\r\n");
        return FALSE;
    }

    Log(log, "[build] Script: ");
    Log(log, macro->scriptPath);
    Log(log, "\r\n");


char fullScript[MAX_PATH];

// If scriptPath is already absolute (starts with drive letter or slash), use it directly
if (macro->scriptPath[1] == ':' || macro->scriptPath[0] == '/' || macro->scriptPath[0] == '\\') {
    snprintf(fullScript, MAX_PATH, "%s", macro->scriptPath);
} else {
    snprintf(fullScript, MAX_PATH, "%s\\%s", workingDir, macro->scriptPath);
}

strcpy(macro->scriptPath, fullScript);
Log(log, "[build] Resolved script path: ");
Log(log, macro->scriptPath);
Log(log, "\r\n");

    FILE *f = fopen(fullScript, "r");
    if (!f) {
        Log(log, "[build] ERROR: Script file not found.\r\n");
        return FALSE;
    }
    fclose(f);

    Log(log, "[build] Script file found.\r\n");

    if (FG_ReadShebang(fullScript, macro->shebang)) {
        Log(log, "[build] Shebang: ");
        Log(log, macro->shebang);
        Log(log, "\r\n");
    } else {
        strcpy(macro->shebang, "bash");
        Log(log, "[build] No shebang found. Defaulting to bash.\r\n");
    }

    Log(log, "[build] Macro build complete.\r\n");
    return TRUE;
}
