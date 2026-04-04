#include "INCLUDE/avis_core.h"
#include "llama.h"
#include <vector>
#include <string>

#include <shlwapi.h>
#pragma comment(lib, "shlwapi.lib")

// Global Sector Handles
struct llama_model * model = nullptr;
struct llama_context * ctx = nullptr;

const wchar_t* AVIS_GetModelsPath() {
    static wchar_t modelsPath[MAX_PATH];

    wchar_t exePath[MAX_PATH];
    GetModuleFileNameW(NULL, exePath, MAX_PATH);

    // Strip EXE
    wchar_t* lastSlash = wcsrchr(exePath, L'\\');
    if (lastSlash) *lastSlash = L'\0';

    // Strip \BIN
    lastSlash = wcsrchr(exePath, L'\\');
    if (lastSlash) *lastSlash = L'\0';

    // Append \MODELS
    swprintf(modelsPath, MAX_PATH, L"%ls\\MODELS", exePath);

    return modelsPath;
}
bool Internal_LoadModel(const char* utf8Path) {
    // CLEAR OLD SECTOR
    if (ctx) { llama_free(ctx); ctx = nullptr; }
    if (model) { llama_model_free(model); model = nullptr; }

    // LOAD NEW MODEL
    auto mparams = llama_model_default_params();
    model = llama_model_load_from_file(utf8Path, mparams);

    if (!model) {
        AVIS_LogToBot("FAILURE: Neural Weights not found at location.");
        return false;
    }

    auto cparams = llama_context_default_params();
    cparams.n_ctx = 2048;
    ctx = llama_init_from_model(model, cparams);

    return (ctx != nullptr);
}


extern "C" void AVIS_InitNeuralSector() {
    llama_backend_init();

    const wchar_t* base = AVIS_GetModelsPath();

    wchar_t bootPathW[MAX_PATH];
    swprintf(bootPathW, MAX_PATH, L"%ls\\SmolLM2-135M-Instruct-f16.gguf", base);

    char bootPathUTF8[MAX_PATH];
    WideCharToMultiByte(CP_UTF8, 0, bootPathW, -1, bootPathUTF8, MAX_PATH, NULL, NULL);

    if (Internal_LoadModel(bootPathUTF8)) {
        AVIS_LogToBot("AVIS: System Boot Complete. SmolLM2 Online.");
    }
}


extern "C" void AVIS_SwitchNeuralModel(const wchar_t* modelFilename) {

    const wchar_t* base = AVIS_GetModelsPath();

    wchar_t finalPathW[MAX_PATH];
    swprintf(finalPathW, MAX_PATH, L"%ls\\%ls", base, modelFilename);

    char fullPathUTF8[MAX_PATH];
    WideCharToMultiByte(CP_UTF8, 0, finalPathW, -1, fullPathUTF8, MAX_PATH, NULL, NULL);

    AVIS_LogToBot("AVIS: ATTEMPTING NEURAL LOAD >>");
    AVIS_LogToBot(fullPathUTF8);

    if (Internal_LoadModel(fullPathUTF8)) {
        AVIS_LogToBot("AVIS: NEURAL BRAIN SWAP SUCCESSFUL.");
    } else {
        AVIS_LogToBot("AVIS: [!] SECTOR UNREACHABLE. CHECK MODELS DIR.");
    }
}

extern "C" void AVIS_GenerateRobotResponse(const wchar_t* input) {
    if (!ctx || !model) return;

    const struct llama_vocab * vocab = llama_model_get_vocab(model);

    // 1. CONVERT WIDE-INPUT TO UTF-8
    int utf8_len = WideCharToMultiByte(CP_UTF8, 0, input, -1, NULL, 0, NULL, NULL);
    std::vector<char> prompt_utf8(utf8_len);
    WideCharToMultiByte(CP_UTF8, 0, input, -1, prompt_utf8.data(), utf8_len, NULL, NULL);
// Inside AVIS_GenerateRobotResponse, before tokenizing:
std::string formatted_prompt = 
    "<|im_start|>system\nYou are FIREGEM, a professional coding assistant. Speak briefly about source code only.<|im_end|>\n"
    "<|im_start|>user\n" + std::string(prompt_utf8.data()) + "<|im_end|>\n"
    "<|im_start|>assistant\n";

// Now tokenize 'formatted_prompt' instead of 'prompt_utf8'
    // 2. TOKENIZE
    std::vector<llama_token> tokens(2048);
    int n_tokens = llama_tokenize(
    vocab,
    formatted_prompt.c_str(),
    (int)formatted_prompt.size(),
    tokens.data(),
    (int)tokens.size(),
    true,
    true
);

if (n_tokens < 0) return;
    tokens.resize(n_tokens);

    // 3. PREPARE BATCH
    llama_batch batch = llama_batch_get_one(tokens.data(), tokens.size());
    
    // 4. THE LOOP-BREAKER (Penalty Sampler Chain)
    struct llama_sampler * smpl = llama_sampler_chain_init(llama_sampler_chain_default_params());
    
    // Add Repetition Penalty to stop the "1. 1. 1." loops
    llama_sampler_chain_add(smpl, llama_sampler_init_penalties(
        llama_vocab_n_tokens(vocab), // Consider all tokens in vocab
        1.15f,  // Penalty strength (1.15 is great for small models)
        0.10f,  // Frequency penalty
        0.10f   // Presence penalty
    ));
    
    // Final greedy selection
    llama_sampler_chain_add(smpl, llama_sampler_init_greedy());
// Print robot name
SendMessageW(hRightEdit_BOT, EM_SETSEL, (WPARAM)-1, (LPARAM)-1);
SendMessageW(hRightEdit_BOT, EM_REPLACESEL, 0, (LPARAM)L"FIREGEM > ");

int n_decode = 0;
while (n_decode < 512) {



        if (llama_decode(ctx, batch)) break;

        llama_token id = llama_sampler_sample(smpl, ctx, -1);
        if (llama_vocab_is_eog(vocab, id)) break;

        char piece[128];
        int n_piece = llama_token_to_piece(vocab, id, piece, sizeof(piece), 0, true);
        
if (n_piece > 0) {
    // Ensure UTF-8 is null-terminated
    char utf8buf[129];
    memcpy(utf8buf, piece, n_piece);
    utf8buf[n_piece] = '\0';

    // Convert to wide
    int wlen = MultiByteToWideChar(CP_UTF8, 0, utf8buf, -1, NULL, 0);
    wchar_t* wpiece = (wchar_t*)malloc(wlen * sizeof(wchar_t));
    MultiByteToWideChar(CP_UTF8, 0, utf8buf, -1, wpiece, wlen);

    // Append to bot window
    SendMessageW(hRightEdit_BOT, EM_SETSEL, (WPARAM)-1, (LPARAM)-1);
    SendMessageW(hRightEdit_BOT, EM_REPLACESEL, 0, (LPARAM)wpiece);

    free(wpiece);
}



        batch = llama_batch_get_one(&id, 1);
        n_decode++;
    }

    llama_sampler_free(smpl);
    SendMessageW(hRightEdit_BOT, EM_REPLACESEL, 0, (LPARAM)L"\r\n[SYSTEM: IDLE]\r\n");
}

extern "C" void AVIS_RefreshModelList(HWND hList) {
    SendMessageW(hList, LB_RESETCONTENT, 0, 0);

    const wchar_t* base = AVIS_GetModelsPath();

    wchar_t searchPath[MAX_PATH];
    swprintf(searchPath, MAX_PATH, L"%ls\\*.gguf", base);

    WIN32_FIND_DATAW fd;
    HANDLE hFind = FindFirstFileW(searchPath, &fd);

    if (hFind != INVALID_HANDLE_VALUE) {
        do {
            SendMessageW(hList, LB_ADDSTRING, 0, (LPARAM)fd.cFileName);
        } while (FindNextFileW(hFind, &fd));
        FindClose(hFind);
    }

    // Select first item
    SendMessageW(hList, LB_SETCURSEL, 0, 0);
}
