#include <windows.h>
#include "ui_main.h"

int WINAPI WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance,
                   LPSTR lpCmdLine, int nCmdShow) {
    // Fixed warning C4100: Quiet unreferenced parameters
    UNREFERENCED_PARAMETER(hPrevInstance);
    UNREFERENCED_PARAMETER(lpCmdLine);
    UNREFERENCED_PARAMETER(nCmdShow);

    WNDCLASS wc = {0};
    wc.lpfnWndProc = WndProc;
    wc.hInstance = hInstance;
    wc.lpszClassName = "FireGemWin";

    RegisterClass(&wc);

    HWND hwnd = CreateWindow("FireGemWin","FireGem Wrapper",
                             WS_OVERLAPPEDWINDOW|WS_VISIBLE,
                             100,100,600,500,
                             NULL,NULL,hInstance,NULL);

    // Fixed warning C4189: Quiet unreferenced local variable
    (void)hwnd;

    MSG msg;
    while(GetMessage(&msg,NULL,0,0)) {
        TranslateMessage(&msg);
        DispatchMessage(&msg);
    }
    return 0;
}
