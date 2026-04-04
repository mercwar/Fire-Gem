/* -------------------------------------------------------------------------
   AVIS MAIN ENTRY - CORRECTED DECLARATION ORDER
   FILE: main.c
   ------------------------------------------------------------------------- */
#include "INCLUDE/avis_core.h"
#include <windowsx.h>
#include <commctrl.h>
#include "fire-list.h"
#include <shellapi.h>

HWND hTreeView = NULL;

// GLOBAL HANDLES
HWND hLeftEdit_CMD, hRightEdit_BOT;
HWND hInput_CMD, hInput_BOT; 
HWND hBtn_CMD, hBtn_BOT;
HWND hModelDrop = NULL; // The Neural Selector Handle
static void TreeView_GetItemTextW(HWND hTree, HTREEITEM hItem, wchar_t* buf, int max)
{
    TVITEMW tvi;
    ZeroMemory(&tvi, sizeof(tvi));
    tvi.mask = TVIF_TEXT;
    tvi.hItem = hItem;
    tvi.pszText = buf;
    tvi.cchTextMax = max;
    TreeView_GetItem(hTree, &tvi);
}

void AVIS_LogToBot_W(const wchar_t* wmsg)
{
    char utf8[1024];
    WideCharToMultiByte(CP_UTF8, 0, wmsg, -1, utf8, 1024, NULL, NULL);
    AVIS_LogToBot(utf8);
}


LRESULT CALLBACK AVIS_TreeProc(HWND hTree, UINT msg, WPARAM wp, LPARAM lp,
                               UINT_PTR id, DWORD_PTR data)
{
	
    switch (msg)
    {
		case WM_RBUTTONDOWN:
{HMENU hMenu = CreatePopupMenu();
    AppendMenuW(hMenu, MF_STRING, 1001, L"Open in fire-con");
    AppendMenuW(hMenu, MF_STRING, 1002, L"Open in fire-term");
    AppendMenuW(hMenu, MF_SEPARATOR, 0, NULL);
    AppendMenuW(hMenu, MF_STRING, 1003, L"Run in fire-con");
    AppendMenuW(hMenu, MF_STRING, 1004, L"Run in fire-term");
    POINT pt;
    pt.x = GET_X_LPARAM(lp);
    pt.y = GET_Y_LPARAM(lp);

    TVHITTESTINFO ht = {0};
    ht.pt = pt;
    TreeView_HitTest(hTree, &ht);   // ✔ hTree is valid here

    if (ht.hItem)
    {
        TreeView_SelectItem(hTree, ht.hItem);

        ClientToScreen(hTree, &pt);

        SendMessage(
            GetParent(hTree),
            WM_USER + 100,
            (WPARAM)ht.hItem,
            MAKELPARAM(pt.x, pt.y)
        );
    }
}
break;
    case WM_LBUTTONDBLCLK:
    {
        TVHITTESTINFO ht = {0};
        ht.pt.x = GET_X_LPARAM(lp);
        ht.pt.y = GET_Y_LPARAM(lp);

        TreeView_HitTest(hTree, &ht);

        if (ht.hItem)
        {
            wchar_t name[256];
            TreeView_GetItemTextW(hTree, ht.hItem, name, 256);

            if (wcscmp(name, L"...") == 0)
                return 0;

            wchar_t path[MAX_PATH];
            Fire_BuildFullPath(hTree, ht.hItem, path, MAX_PATH);

            AVIS_LogToBot("DIR OPEN:");
            AVIS_LogToBot_W(path);
        }
    }
    break;
    }

    return DefSubclassProc(hTree, msg, wp, lp);
}




LRESULT CALLBACK AVIS_EditProc(HWND hEdit, UINT msg, WPARAM wp, LPARAM lp,
                               UINT_PTR id, DWORD_PTR data)
{
    switch (msg)
    {
        case WM_GETDLGCODE:
            return DLGC_WANTALLKEYS;

        case WM_KEYDOWN:
            if (wp == VK_RETURN)
            {
                // SHIFT+ENTER → newline
                if (GetKeyState(VK_SHIFT) & 0x8000)
                    return 0;

                HWND parent = GetParent(hEdit);

                // CMD box
                if (hEdit == hInput_CMD)
                {
                    SendMessageW(parent, WM_COMMAND, MAKEWPARAM(201, 0), 0);
                    return 0;
                }

                // BOT box
                if (hEdit == hInput_BOT)
                {
                    SendMessageW(parent, WM_COMMAND, MAKEWPARAM(202, 0), 0);
                    return 0;
                }
            }
            break;
    }

    return DefSubclassProc(hEdit, msg, wp, lp);
}

LRESULT CALLBACK AVIS_WindowProc(HWND hwnd, UINT msg, WPARAM wp, LPARAM lp) {
    switch(msg) {
        case WM_CREATE: 
        { // <--- OPEN SCOPE BLOCK
            INITCOMMONCONTROLSEX icex = { sizeof(icex), ICC_TREEVIEW_CLASSES };
            InitCommonControlsEx(&icex);

            hTreeView = CreateWindowExW(0, WC_TREEVIEWW, L"",
    WS_VISIBLE | WS_CHILD | WS_BORDER | TVS_HASLINES | TVS_HASBUTTONS | TVS_LINESATROOT,
    10, 10, 180, 450, hwnd, (HMENU)301, NULL, NULL);

SetWindowSubclass(hTreeView, AVIS_TreeProc, 0, 0);

// Populate drives
Fire_PopulateDrives(hTreeView);



            // Left/Right Edits
            hLeftEdit_CMD = CreateWindowExW(0, L"EDIT", L"", 
                WS_CHILD | WS_VISIBLE | WS_VSCROLL | ES_MULTILINE | ES_READONLY,
                200, 10, 300, 450, hwnd, NULL, NULL, NULL);

            hRightEdit_BOT = CreateWindowExW(0, L"EDIT", L"--- FIREGEM ONLINE ---\r\n", 
                WS_CHILD | WS_VISIBLE | WS_VSCROLL | ES_MULTILINE | ES_READONLY,
                510, 10, 300, 450, hwnd, NULL, NULL, NULL);

            // Inputs and Buttons (Adjusted offsets)
// --- CMD SECTOR INPUT (MULTILINE) ---
hInput_CMD = CreateWindowExW(0, L"EDIT", L"", 
    WS_CHILD | WS_VISIBLE | WS_BORDER | WS_VSCROLL | 
    ES_MULTILINE | ES_AUTOVSCROLL | ES_WANTRETURN, 
    200, 470, 200, 80, hwnd, NULL, NULL, NULL);

hBtn_CMD = CreateWindowExW(0, L"BUTTON", L"SEND CMD", 
    WS_CHILD | WS_VISIBLE, 
    410, 470, 90, 80, hwnd, (HMENU)201, NULL, NULL);

// --- ROBOT SECTOR INPUT (MULTILINE) ---
hInput_BOT = CreateWindowExW(0, L"EDIT", L"", 
    WS_CHILD | WS_VISIBLE | WS_BORDER | WS_VSCROLL | 
    ES_MULTILINE | ES_AUTOVSCROLL | ES_WANTRETURN, 
    510, 470, 200, 80, hwnd, NULL, NULL, NULL);

hBtn_BOT = CreateWindowExW(0, L"BUTTON", L"ASK ROBOT", 
    WS_CHILD | WS_VISIBLE, 
    720, 470, 90, 80, hwnd, (HMENU)202, NULL, NULL);

hModelDrop = CreateWindowExW(
    0,
    L"LISTBOX",
    NULL,
    WS_CHILD | WS_VISIBLE | WS_BORDER | WS_VSCROLL | LBS_NOTIFY,
    10, 470, 180, 90,
    hwnd,
    (HMENU)301,
    NULL,
    NULL
);

SetWindowSubclass(hInput_CMD, AVIS_EditProc, 0, 0);
SetWindowSubclass(hInput_BOT, AVIS_EditProc, 0, 0);


// Populate the list immediately
AVIS_RefreshModelList(hModelDrop);
	
	
            AVIS_InitCmdPipe(); 
            AVIS_InitNeuralSector();
			
			
			
        } // <--- CLOSE SCOPE BLOCK
		
		
      
break;








        case WM_NOTIFY:
        {
            LPNMHDR hdr = (LPNMHDR)lp;

            if (hdr->hwndFrom == hTreeView && hdr->code == TVN_ITEMEXPANDINGW)
            {
                // PROVE EXECUTION
               
                LPNMTREEVIEWW ntv = (LPNMTREEVIEWW)lp;

                if (ntv->action == TVE_EXPAND)
                {
                    // Remove dummy
                    HTREEITEM hChild = TreeView_GetChild(hTreeView, ntv->itemNew.hItem);
                    if (hChild)
                    {
                        wchar_t buf[16];
                        TreeView_GetItemTextW(hTreeView, hChild, buf, 16);

                        if (wcscmp(buf, L"...") == 0)
                            TreeView_DeleteItem(hTreeView, hChild);
                    }

                    // Build full path
                    wchar_t full[MAX_PATH];
                    Fire_BuildFullPath(hTreeView, ntv->itemNew.hItem, full, MAX_PATH);

                    // Log + prove
                    AVIS_LogToBot("EXPANDING:");
                    AVIS_LogToBot_W(full);
                    
                    // Populate folder
                    Fire_PopulateFolder(hTreeView, ntv->itemNew.hItem, full);
                }
            }
        }
        break;

        case WM_COMMAND:
        {
            WORD controlId = LOWORD(wp); // Using 'wp'
            WORD notification = HIWORD(wp); // Using 'wp'
            
            // --- CMD SECTOR SEND (ID: 201) ---
            if (controlId == 201) { 
                wchar_t cmdBuf[1024];
                GetWindowTextW(hInput_CMD, cmdBuf, 1024);
                if (wcslen(cmdBuf) > 0) {
                    AVIS_SendToCmdW(cmdBuf); 
                    SetWindowTextW(hInput_CMD, L"");
                }
            }
            
            // --- ROBOT SECTOR SEND (ID: 202) ---
            if (controlId == 202) { 
                wchar_t botBuf[1024];
                GetWindowTextW(hInput_BOT, botBuf, 1024);
                if (wcslen(botBuf) > 0) {
                    AVIS_ProcessNeuralIntentW(botBuf);
                    SetWindowTextW(hInput_BOT, L"");
                }
            }

if (controlId == 301 && notification == LBN_SELCHANGE) {

    int index = (int)SendMessageW(hModelDrop, LB_GETCURSEL, 0, 0);

    if (index != LB_ERR) {

        wchar_t selectedModel[MAX_PATH] = {0};

        SendMessageW(
            hModelDrop,
            LB_GETTEXT,
            (WPARAM)index,
            (LPARAM)selectedModel
        );


        AVIS_SwitchNeuralModel(selectedModel);
    }
}


        }
		
        break;


case WM_USER + 100:
{
    HTREEITEM hItem = (HTREEITEM)wp;
    int x = LOWORD(lp);
    int y = HIWORD(lp);

    HMENU hMenu = CreatePopupMenu();
    AppendMenuW(hMenu, MF_STRING, 1001, L"Open in fire-con");
    AppendMenuW(hMenu, MF_STRING, 1002, L"Open in fire-term");
    AppendMenuW(hMenu, MF_SEPARATOR, 0, NULL);
    AppendMenuW(hMenu, MF_STRING, 1003, L"Run in fire-con");
    AppendMenuW(hMenu, MF_STRING, 1004, L"Run in fire-term");

    int cmd = TrackPopupMenu(
        hMenu,
        TPM_RETURNCMD | TPM_LEFTALIGN | TPM_TOPALIGN,
        x, y,
        0,
        hwnd,
        NULL
    );

    DestroyMenu(hMenu);

    if (cmd == 0)
        break;

    wchar_t path[MAX_PATH];
    Fire_BuildFullPath(hTreeView, hItem, path, MAX_PATH);

    switch (cmd)
    {
        case 1001: // Open in fire-con
            AVIS_LogToBot("OPEN IN FIRE-CON:");
            AVIS_LogToBot_W(path);
            AVIS_SendToCmdW(path);
            break;

        case 1002: // Open in fire-term
            AVIS_LogToBot("OPEN IN FIRE-TERM:");
            AVIS_LogToBot_W(path);
            ShellExecuteW(NULL, L"open", L"cmd.exe", path, NULL, SW_SHOW);
            break;

        case 1003: // Run in fire-con
            AVIS_LogToBot("RUN IN FIRE-CON:");
            AVIS_LogToBot_W(path);
            AVIS_SendToCmdW(path); // or AVIS_RunFile(path)
            break;

        case 1004: // Run in fire-term
            AVIS_LogToBot("RUN IN FIRE-TERM:");
            AVIS_LogToBot_W(path);
            ShellExecuteW(NULL, L"open", path, NULL, NULL, SW_SHOW);
            break;
    }
}
break;

break;



        case WM_DESTROY:
            PostQuitMessage(0);
            break;
    }
    return DefWindowProcW(hwnd, msg, wp, lp);
}
// --- SECTOR 2: THE ENTRY POINT ---
int WINAPI wWinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPWSTR lpCmdLine, int nShowCmd) {
    WNDCLASSW wc = {0}; 
    wc.lpfnWndProc   = AVIS_WindowProc; // NOW DECLARED ABOVE
    wc.hInstance     = hInstance;
    wc.lpszClassName = L"AVIS_CLASS";
    wc.hbrBackground = (HBRUSH)(COLOR_WINDOW+1);
    wc.hCursor       = LoadCursor(NULL, IDC_ARROW);

    if (!RegisterClassW(&wc)) return 0;

    HWND hwnd = CreateWindowExW(0, L"AVIS_CLASS", L"FIREGEM CYBORG AI", 
        WS_OVERLAPPEDWINDOW | WS_VISIBLE, 100, 100, 825, 600, NULL, NULL, hInstance, NULL);

    if (!hwnd) return 0;

    MSG msg;
    while(GetMessageW(&msg, NULL, 0, 0)) {
        TranslateMessage(&msg);
        DispatchMessageW(&msg);
    }
    return (int)msg.wParam;
}