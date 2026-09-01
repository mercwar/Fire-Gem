#include "llm_wrapper.h"
#include "llama.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static struct llama_model *model = NULL;
static struct llama_context *ctx = NULL;
static char saved_model_path[512] = {0};

int llm_init(const char *model_path) {
    if (model_path && model_path != saved_model_path) {
        snprintf(saved_model_path, sizeof(saved_model_path), "%s", model_path);
    }

    if (ctx) {
        llama_free(ctx);
        ctx = NULL;
    }
    if (model) {
        llama_model_free(model);
        model = NULL;
    }

    struct llama_model_params mparams = llama_model_default_params();
    model = llama_model_load_from_file(saved_model_path, mparams);
    if (!model) return -1;

    struct llama_context_params cparams = llama_context_default_params();
    ctx = llama_init_from_model(model, cparams); 
    
    if (!ctx) {
        llama_model_free(model);
        model = NULL;
        return -1;
    }
    return 0;
}

int llm_generate(const char *prompt, char *outbuf, size_t maxlen) {
    if (!model) return -1;

    // ✅ FIX: Safely recreate context space per message to clear memory natively.
    // This avoids using missing, deprecated, or unstable KV cache linker symbols.
    struct llama_context_params cparams = llama_context_default_params();
    if (ctx) {
        llama_free(ctx);
    }
    ctx = llama_init_from_model(model, cparams);
    if (!ctx) return -1;

    const struct llama_vocab *vocab = llama_model_get_vocab(model);

    int n_tokens_max = (int)strlen(prompt) + 4;
    llama_token *tokens = (llama_token*)malloc(sizeof(llama_token) * n_tokens_max);
    if (!tokens) return -1;
    
    int n_tokens = llama_tokenize(vocab, prompt, (int)strlen(prompt), tokens, n_tokens_max, true, true);
    if (n_tokens < 0) {
        free(tokens);
        return -1;
    }

    struct llama_batch batch = llama_batch_init(n_tokens, 0, 1);
    for (int i = 0; i < n_tokens; i++) {
        batch.token[i]    = tokens[i];
        batch.pos[i]      = i;
        batch.n_seq_id[i] = 1;
        batch.seq_id[i][0]   = 0;  
        batch.logits[i]   = (i == n_tokens - 1); 
    }
    batch.n_tokens = n_tokens;

    if (llama_decode(ctx, batch) != 0) {
        llama_batch_free(batch);
        free(tokens);
        return -1;
    }

    free(tokens);

    struct llama_sampler_chain_params sparams = llama_sampler_chain_default_params();
    struct llama_sampler *smpl = llama_sampler_chain_init(sparams);
    
    int n_vocab = llama_n_vocab(model);
    llama_sampler_chain_add(smpl, llama_sampler_init_penalties(n_vocab, 64, 1.15f, 0.10f, 0.10f));
    llama_sampler_chain_add(smpl, llama_sampler_init_top_k(40));
    llama_sampler_chain_add(smpl, llama_sampler_init_top_p(0.90f, 1));
    llama_sampler_chain_add(smpl, llama_sampler_init_temp(0.80f));
    llama_sampler_chain_add(smpl, llama_sampler_init_dist(1234)); 

    size_t out_pos = 0;
    outbuf[0] = '\0'; 

    int max_gen_tokens = 256; 
    int n_cur = batch.n_tokens;

    for (int i = 0; i < max_gen_tokens; i++) {
        llama_token id = llama_sampler_sample(smpl, ctx, -1);

        if (llama_vocab_is_eog(vocab, id)) {
            break;
        }

        char piece[32] = {0}; 
        int n_chars = llama_token_to_piece(vocab, id, piece, sizeof(piece), 0, false);
        if (n_chars > 0) {
            if (out_pos + (size_t)n_chars < maxlen - 1) {
                memcpy(outbuf + out_pos, piece, (size_t)n_chars);
                out_pos += (size_t)n_chars;
                outbuf[out_pos] = '\0';
            } else {
                break;
            }
        }

        // ✅ CRASH FIX: Properly index into array elements using element [0] offsets.
        // This preserves the allocated batch pointer arrays and stops memory corruption.
        batch.token[0]    = id;
        batch.pos[0]      = n_cur;
        batch.n_seq_id[0] = 1;
        batch.seq_id[0][0]   = 0;
        batch.logits[0]   = true;
        batch.n_tokens    = 1;
        
        n_cur++;

        if (llama_decode(ctx, batch) != 0) {
            break;
        }
    }

    llama_sampler_free(smpl);
    llama_batch_free(batch);
    return 0;
}

void llm_free(void) {
    if (ctx) {
        llama_free(ctx);
        ctx = NULL;
    }
    if (model) {
        llama_model_free(model);
        model = NULL;
    }
    memset(saved_model_path, 0, sizeof(saved_model_path));
}
