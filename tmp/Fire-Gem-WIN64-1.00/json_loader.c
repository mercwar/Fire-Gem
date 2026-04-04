// json_loader.c
#include <windows.h>
#include <stdio.h>
#include <string.h>
#include "json_loader.h"
#include "fire_gem.h"

// Simple helper to extract a JSON string value by key
static BOOL ExtractJsonValue(const char *json, const char *key, char *out, int outSize)
{
    char search[128];
    snprintf(search, sizeof(search), "\"%s\"", key);

    char *p = strstr(json, search);
    if (!p) return FALSE;

    p = strchr(p, ':');
    if (!p) return FALSE;

    p++;
    while (*p == ' ' || *p == '\"') p++;

    char *end = p;
    while (*end && *end != '\"' && *end != '\n' && *end != '\r')
        end++;

    int len = (int)(end - p);
    if (len >= outSize) len = outSize - 1;

    memcpy(out, p, len);
    out[len] = 0;

    return TRUE;
}

BOOL FG_LoadJson(const char *fullPath, FG_JSON_MACRO *macro)
{
    FILE *f = fopen(fullPath, "rb");
    if (!f) return FALSE;

    fseek(f, 0, SEEK_END);
    long size = ftell(f);
    fseek(f, 0, SEEK_SET);

    char *json = malloc(size + 1);
    fread(json, 1, size, f);
    json[size] = 0;
    fclose(f);

    // Clear macro
    memset(macro, 0, sizeof(*macro));

    // CMD_STRING
    ExtractJsonValue(json, "SHELL_EXEC", macro->cmdExec, sizeof(macro->cmdExec));
    ExtractJsonValue(json, "SHELL_BASH", macro->cmdBash, sizeof(macro->cmdBash));
    ExtractJsonValue(json, "WIN_INET",  macro->cmdInet, sizeof(macro->cmdInet));

    // CMD_FILE
    ExtractJsonValue(json, "SHELL_SH",        macro->fileSh,   sizeof(macro->fileSh));
    ExtractJsonValue(json, "SHELL_BASH_FILE", macro->fileBash, sizeof(macro->fileBash));
    ExtractJsonValue(json, "SHELL_BAT",       macro->fileBat,  sizeof(macro->fileBat));
    ExtractJsonValue(json, "SHELL_CMD",       macro->fileCmd,  sizeof(macro->fileCmd));

    free(json);
    return TRUE;
}
