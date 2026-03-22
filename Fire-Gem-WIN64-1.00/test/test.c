/* AVIS: test.c
   AIFVS-ARTIFACT: FIRE-GEM-UNIFIED-EDITOR
*/

#include <windows.h>
#include <commdlg.h>
#include <stdio.h>

#define IDC_EDIT_MAIN   1001
#define IDC_EDIT_REF    1002

char gCurrentFile[MAX_PATH] = {0};

void LoadFileIntoEditor(HWND hEdit, const char *path)
{
    FILE *fp = fopen(path, "rb");
    if (!fp) return;

    fseek(fp, 0, SEEK_END);
    long size = ftell(fp);
    fseek(fp, 0, SEEK_SET);

    char *buf = malloc(size + 1);
    fread(buf, 1, size, fp);
    buf[size] = 0;
    fclose(fp);

    SetWindowTextA(hEdit, buf);
    free(buf);
}

void SaveEditorToFile(HWND hEdit, const char *path)
{
    int len = GetWindowTextLengthA(hEdit);
    char *buf = malloc(len + 1);
    GetWindowTextA(hEdit, buf, len + 1);

    FILE *fp = fopen(path, "wb");
    if (fp)
    {
        fwrite(buf, 1, len, fp);
        fclose(fp);
    }

    free(buf);
}

LRESULT CALLBACK WndProc(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam)
{
    static HWND hMainEdit, hRefEdit;

    switch (msg)
    {
    case WM_CREATE:
    {
        // Create menu
        HMENU hMenu = CreateMenu();
        HMENU hFile = CreatePopupMenu();

        AppendMenuA(hFile, MF_STRING, 1, "Open...");
        AppendMenuA(hFile, MF_STRING, 2, "Save");
        AppendMenuA(hFile, MF_STRING, 3, "Save As...");
        AppendMenuA(hFile, MF_SEPARATOR, 0, NULL);
        AppendMenuA(hFile, MF_STRING, 4, "Exit");

        AppendMenuA(hMenu, MF_POPUP, (UINT_PTR)hFile, "File");
        SetMenu(hwnd, hMenu);

// Main editor (left)
hMainEdit = CreateWindowExA(
    WS_EX_CLIENTEDGE, "EDIT", "",
    WS_CHILD | WS_VISIBLE | WS_VSCROLL |
    ES_MULTILINE | ES_AUTOVSCROLL,
    0, 0, 600, 600,
    hwnd, (HMENU)IDC_EDIT_MAIN, NULL, NULL);

// Reference panel (right)
hRefEdit = CreateWindowExA(
    WS_EX_CLIENTEDGE, "EDIT",
    "; JSON Command Preview\n"
    "CMD_STRING:\n"
    "  SHELL_EXEC: <cmd.exe /c test.exe>\n"
    "  SHELL_BASH: <bash commands>\n"
    "  WIN_INET:   <curl>\n\n"
    "CMD_FILE:\n"
    "  SHELL_SH:        <build.sh>\n"
    "  SHELL_BASH_FILE: <scripts/prepare.sh>\n"
    "  SHELL_BAT:       <deploy.bat>\n"
    "  SHELL_CMD:       <cleanup.cmd>\n",
    WS_CHILD | WS_VISIBLE | WS_VSCROLL |
    ES_MULTILINE | ES_AUTOVSCROLL | ES_READONLY,
    0, 0, 0, 0,
    hwnd, (HMENU)IDC_EDIT_REF, NULL, NULL);


    }
    break;

    case WM_COMMAND:
        switch (LOWORD(wParam))
        {
        case 1: // Open
        {
            OPENFILENAMEA ofn = {0};
            char file[MAX_PATH] = {0};

            ofn.lStructSize = sizeof(ofn);
            ofn.hwndOwner = hwnd;
            ofn.lpstrFilter = "All Files\0*.*\0";
            ofn.lpstrFile = file;
            ofn.nMaxFile = MAX_PATH;
            ofn.Flags = OFN_EXPLORER | OFN_FILEMUSTEXIST;

            if (GetOpenFileNameA(&ofn))
            {
                strcpy(gCurrentFile, file);
                LoadFileIntoEditor(hMainEdit, file);
            }
        }
        break;

        case 2: // Save
            if (gCurrentFile[0])
                SaveEditorToFile(hMainEdit, gCurrentFile);
            break;

        case 3: // Save As
        {
            OPENFILENAMEA ofn = {0};
            char file[MAX_PATH] = {0};

            ofn.lStructSize = sizeof(ofn);
            ofn.hwndOwner = hwnd;
            ofn.lpstrFilter = "All Files\0*.*\0";
            ofn.lpstrFile = file;
            ofn.nMaxFile = MAX_PATH;
            ofn.Flags = OFN_EXPLORER;

            if (GetSaveFileNameA(&ofn))
            {
                strcpy(gCurrentFile, file);
                SaveEditorToFile(hMainEdit, file);
            }
        }
        break;

        case 4: // Exit
            PostQuitMessage(0);
            break;
        }
        break;

    case WM_SIZE:
{
    int w = LOWORD(lParam);
    int h = HIWORD(lParam);

    int refWidth = 300;
    int mainWidth = w - refWidth;

    MoveWindow(hMainEdit, 0, 0, mainWidth, h, TRUE);
    MoveWindow(hRefEdit, mainWidth, 0, refWidth, h, TRUE);
}
break;


    case WM_DESTROY:
        PostQuitMessage(0);
        break;
    }

    return DefWindowProcA(hwnd, msg, wParam, lParam);
}

int WINAPI WinMain(HINSTANCE h, HINSTANCE p, LPSTR cmd, int show)
{
    WNDCLASSA wc = {0};
    wc.lpfnWndProc = WndProc;
    wc.hInstance = h;
    wc.lpszClassName = "FG_UNIFIED_EDITOR";

    RegisterClassA(&wc);

    HWND hwnd = CreateWindowA(
        "FG_UNIFIED_EDITOR", "Fire‑Gem Unified Editor",
        WS_OVERLAPPEDWINDOW,
        CW_USEDEFAULT, CW_USEDEFAULT, 900, 600,
        NULL, NULL, h, NULL);

    ShowWindow(hwnd, show);

    MSG msg;
    while (GetMessageA(&msg, NULL, 0, 0))
    {
        TranslateMessage(&msg);
        DispatchMessageA(&msg);
    }

    return 0;
}
