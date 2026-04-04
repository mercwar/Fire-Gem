// ini_loader.c
#include <windows.h>
#include <commdlg.h>
#include <stdio.h>
#include <string.h>
#include "ini_loader.h"

BOOL FG_OpenIniDialog(HWND hwnd, char *outPath)
{
    OPENFILENAMEA ofn = {0};
    ofn.lStructSize = sizeof(ofn);
    ofn.hwndOwner = hwnd;
    ofn.lpstrFilter = "INI Files\0*.ini\0All Files\0*.*\0";
    ofn.lpstrFile = outPath;
    ofn.nMaxFile = MAX_PATH;
    ofn.Flags = OFN_FILEMUSTEXIST | OFN_PATHMUSTEXIST;

    return GetOpenFileNameA(&ofn);
}

BOOL FG_ParseIni(const char *iniPath, FG_INI *out)
{
    FILE *f = fopen(iniPath, "r");
    if (!f) return FALSE;

    char line[512];
    memset(out, 0, sizeof(FG_INI));

    while (fgets(line, sizeof(line), f))
    {
        if (strncmp(line, "directory", 9) == 0)
        {
            char *eq = strchr(line, '=');
            if (!eq) continue;

            strcpy(out->directory, eq + 1);

            // **FIXED TRIMMER — removes ALL whitespace + hidden chars**
            size_t len = strlen(out->directory);
            while (len && (unsigned char)out->directory[len-1] <= 32)
                out->directory[--len] = 0;
        }
    }

    fclose(f);
    return TRUE;
}

void FG_FillJsonDropdown(HWND hwndCombo, const char *dir)
{
    SendMessageA(hwndCombo, CB_RESETCONTENT, 0, 0);

    char searchPath[MAX_PATH];
    snprintf(searchPath, MAX_PATH, "%s\\*.json", dir);

    WIN32_FIND_DATAA fd;
    HANDLE hFind = FindFirstFileA(searchPath, &fd);

    if (hFind == INVALID_HANDLE_VALUE)
        return;

    do {
        if (!(fd.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY))
            SendMessageA(hwndCombo, CB_ADDSTRING, 0, (LPARAM)fd.cFileName);

    } while (FindNextFileA(hFind, &fd));

    FindClose(hFind);
}
