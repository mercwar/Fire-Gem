// wndproc.c
#include <windows.h>
#include "fire_gem.h"
#include "ini_loader.h"
#include "json_loader.h"
#include "macro_builder.h"
#include "macro_runner.h"
#include "fg_log.h"   // ← REQUIRED


static void CreateControls(HWND hwnd, HINSTANCE hInst)
{
    CreateWindowExA(0, "BUTTON", "Load INI...",
        WS_CHILD | WS_VISIBLE, 10, 10, 100, 24,
        hwnd, (HMENU)IDC_BTN_LOAD_INI, hInst, NULL);

    CreateWindowExA(0, "COMBOBOX", "",
        WS_CHILD | WS_VISIBLE | CBS_DROPDOWNLIST,
        120, 10, 250, 200,
        hwnd, (HMENU)IDC_CMB_JSON, hInst, NULL);

    CreateWindowExA(0, "BUTTON", "Load JSON",
        WS_CHILD | WS_VISIBLE, 380, 10, 100, 24,
        hwnd, (HMENU)IDC_BTN_LOAD_JSON, hInst, NULL);

    CreateWindowExA(0, "BUTTON", "Build",
        WS_CHILD | WS_VISIBLE, 10, 40, 100, 24,
        hwnd, (HMENU)IDC_BTN_BUILD, hInst, NULL);

    CreateWindowExA(0, "BUTTON", "Run Program",
        WS_CHILD | WS_VISIBLE, 120, 40, 120, 24,
        hwnd, (HMENU)IDC_BTN_RUN, hInst, NULL);

    CreateWindowExA(WS_EX_CLIENTEDGE, "EDIT", "",
        WS_CHILD | WS_VISIBLE | WS_VSCROLL |
        ES_MULTILINE | ES_AUTOVSCROLL,
        10, 80, 760, 480,
        hwnd, (HMENU)IDC_EDIT_LOG, hInst, NULL);
		// Terminal input box
CreateWindowExA(
    WS_EX_CLIENTEDGE, "EDIT", "",
    WS_CHILD | WS_VISIBLE | ES_AUTOHSCROLL,
    10, 570, 600, 24,
    hwnd, (HMENU)IDC_EDIT_TERM_INPUT, hInst, NULL
);

// Terminal Send button
CreateWindowExA(
    0, "BUTTON", "Send",
    WS_CHILD | WS_VISIBLE,
    620, 570, 80, 24,
    hwnd, (HMENU)IDC_BTN_TERM_SEND, hInst, NULL
);

}

LRESULT CALLBACK FireGem_WndProc(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam)
{
    switch (msg)
    {
    case WM_CREATE:
        CreateControls(hwnd, ((LPCREATESTRUCT)lParam)->hInstance);
        return 0;

    case WM_COMMAND:
        switch (LOWORD(wParam))
        {
			case IDC_BTN_TERM_SEND:
{
    HWND edit = GetDlgItem(hwnd, IDC_EDIT_TERM_INPUT);
    HWND log  = GetDlgItem(hwnd, IDC_EDIT_LOG);

    char cmd[512];
    GetWindowTextA(edit, cmd, sizeof(cmd));

    if (cmd[0] == '\0')
        return 0;

    // Clear input after sending
    SetWindowTextA(edit, "");

    // Run the command in the directory loaded from the INI
    FG_RunSingleCommand(log, g_ini.directory, cmd);
}
return 0;

        case IDC_BTN_LOAD_INI:
        {
            char iniPath[MAX_PATH] = {0};
            if (FG_OpenIniDialog(hwnd, iniPath)) {
                FG_ParseIni(iniPath, &g_ini);
                FG_FillJsonDropdown(GetDlgItem(hwnd, IDC_CMB_JSON), g_ini.directory);
            }
        }
        return 0;

        case IDC_BTN_LOAD_JSON:
        {
            HWND combo = GetDlgItem(hwnd, IDC_CMB_JSON);
            int idx = SendMessageA(combo, CB_GETCURSEL, 0, 0);
            if (idx == CB_ERR) return 0;

            char filename[MAX_PATH];
            SendMessageA(combo, CB_GETLBTEXT, idx, (LPARAM)filename);

            char fullPath[MAX_PATH];
            wsprintfA(fullPath, "%s\\%s", g_ini.directory, filename);

            FG_LoadJson(fullPath, &g_macro);
        }
        return 0;

        case IDC_BTN_BUILD:
        {
            HWND log = GetDlgItem(hwnd, IDC_EDIT_LOG);
            FG_BuildMacro(&g_macro, g_ini.directory, log);
        }
        return 0;
case IDC_BTN_RUN:
{
    HWND log = GetDlgItem(hwnd, IDC_EDIT_LOG);

    FG_Log(log, "[ui] Run Program button clicked.\r\n");

    FG_RunBuiltMacro(log, &g_macro, g_ini.directory);

    FG_Log(log, "[ui] Run Program finished.\r\n");
}
return 0;


        }
        break;

    case WM_DESTROY:
        PostQuitMessage(0);
        return 0;
    }

    return DefWindowProcA(hwnd, msg, wParam, lParam);
}
