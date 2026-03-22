// fg_log.c
#include <windows.h>
#include <string.h>
#include "fg_log.h"

void FG_Log(HWND hEdit, const char *text)
{
    int len = GetWindowTextLengthA(hEdit);
    SendMessageA(hEdit, EM_SETSEL, len, len);
    SendMessageA(hEdit, EM_REPLACESEL, FALSE, (LPARAM)text);
}
