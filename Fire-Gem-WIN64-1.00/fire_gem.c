// fire_gem.c
#include <windows.h>
#include "fire_gem.h"
#include "wndproc.h"

FG_INI   g_ini;
FG_MACRO g_macro;

int APIENTRY WinMain(HINSTANCE hInst, HINSTANCE prev, LPSTR cmd, int show)
{
    WNDCLASSEXA wc = {0};
    wc.cbSize        = sizeof(wc);
    wc.style         = CS_HREDRAW | CS_VREDRAW;
    wc.lpfnWndProc   = FireGem_WndProc;
    wc.hInstance     = hInst;
    wc.hIcon         = LoadIconA(NULL, IDI_APPLICATION);
    wc.hCursor       = LoadCursorA(NULL, IDC_ARROW);
    wc.hbrBackground = (HBRUSH)(COLOR_WINDOW + 1);
    wc.lpszClassName = "FireGemClass";

    RegisterClassExA(&wc);

    HWND hwnd = CreateWindowExA(
        0, "FireGemClass", "Fire-Gem Build Tool",
        WS_OVERLAPPEDWINDOW,
        CW_USEDEFAULT, CW_USEDEFAULT,
        800, 650,
        NULL, NULL, hInst, NULL
    );

    ShowWindow(hwnd, show);
    UpdateWindow(hwnd);

    MSG msg;
    while (GetMessageA(&msg, NULL, 0, 0) > 0) {
        TranslateMessage(&msg);
        DispatchMessageA(&msg);
    }

    return 0;
}
