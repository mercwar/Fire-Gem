#include "ui_main.h"
#include "json_loader.h"
#include "llm_wrapper.h" 
#include <stdio.h>
#include <string.h>

HWND hList, hConsole, hInput, hButton, hSendBtn;

void LoadAnyJson(const char *filename) {
    JsonFile *jf = load_json(filename);
    if (!jf) return;
    
    SendMessage(hList, LB_RESETCONTENT, 0, 0);
    for (int i = 0; i < jf->count; i++) {
        if (jf->entries[i].filename) {
            SendMessage(hList, LB_ADDSTRING, 0, (LPARAM)jf->entries[i].filename);
        }
    }
    free_json(jf);
}

LRESULT CALLBACK WndProc(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam) {
    switch(msg) {
        case WM_CREATE:
            hList = CreateWindow("LISTBOX", "", WS_CHILD | WS_VISIBLE | LBS_STANDARD | WS_VSCROLL,
                                 10, 10, 200, 440, hwnd, (HMENU)1, NULL, NULL);

            hConsole = CreateWindow("EDIT", "", WS_CHILD | WS_VISIBLE | WS_VSCROLL | ES_MULTILINE | ES_READONLY,
                                 220, 10, 350, 260, hwnd, (HMENU)2, NULL, NULL);

            hInput = CreateWindow("EDIT", "", WS_CHILD | WS_VISIBLE | WS_VSCROLL | ES_MULTILINE | ES_AUTOVSCROLL,
                                 220, 280, 350, 120, hwnd, (HMENU)3, NULL, NULL);

            hButton = CreateWindow("BUTTON", "Load Model", WS_CHILD | WS_VISIBLE,
                                 220, 415, 110, 35, hwnd, (HMENU)4, NULL, NULL);

            hSendBtn = CreateWindow("BUTTON", "Send Prompt", WS_CHILD | WS_VISIBLE,
                                 460, 415, 110, 35, hwnd, (HMENU)5, NULL, NULL);

            LoadAnyJson("models.json");
            break;

        case WM_COMMAND:
            if (LOWORD(wParam) == 4) {
                LRESULT sel = SendMessage(hList, LB_GETCURSEL, 0, 0);
                if (sel != LB_ERR) {
                    char modelName[256] = {0};
                    char absolutePath[512] = {0};
                    
                    SendMessage(hList, LB_GETTEXT, (WPARAM)sel, (LPARAM)modelName);
                    SetWindowText(hConsole, "Loading target model binary...\r\n");

                    JsonFile *jf = load_json("models.json");
                    if (jf) {
                        for (int i = 0; i < jf->count; i++) {
                            if (jf->entries[i].filename && strcmp(jf->entries[i].filename, modelName) == 0) {
                                snprintf(absolutePath, sizeof(absolutePath), "%s\\%s", jf->entries[i].path, jf->entries[i].filename);
                                break;
                            }
                        }
                        free_json(jf);
                    }

                    if (strlen(absolutePath) == 0) {
                        snprintf(absolutePath, sizeof(absolutePath), "%s", modelName);
                    }

                    if (llm_init(absolutePath) == 0) {
                        SetWindowText(hConsole, "Model successfully allocated to logic core!\r\n");
                    } else {
                        SetWindowText(hConsole, "❌ ERROR: Core model allocation sequence failed.\r\n");
                    }
                }
            }
            
            if (LOWORD(wParam) == 5) {
                char rawInput[1024] = {0};
                char formattedPrompt[2048] = {0};
                char outBuf[8192] = {0};

                GetWindowText(hInput, rawInput, sizeof(rawInput));

                if (strlen(rawInput) > 0) {
                    SetWindowText(hConsole, "Thinking...\r\n");

                    // ✅ FIX: Wrap raw input into a ChatML formatting block 
                    // This forces models like Qwen or Phi out of code-completion mode
                    snprintf(formattedPrompt, sizeof(formattedPrompt), 
                             "<|im_start|>system\nYou are a helpful AI assistant.<|im_end|>\n"
                             "<|im_start|>user\n%s<|im_end|>\n"
                             "<|im_start|>assistant\n", rawInput);

                    if (llm_generate(formattedPrompt, outBuf, sizeof(outBuf)) == 0) {
                        SetWindowText(hConsole, outBuf);
                        SetWindowText(hInput, ""); 
                    } else {
                        SetWindowText(hConsole, "❌ ERROR: Target inference context missing or decode failed.");
                    }
                }
            }
            break;

        case WM_DESTROY:
            llm_free(); 
            PostQuitMessage(0);
            break;
    }
    return DefWindowProc(hwnd, msg, wParam, lParam);
}
