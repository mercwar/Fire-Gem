// AIFVS-ARTIFACT
// prompt_formatter.c — ChatML prompt formatting implementation

#include "prompt_formatter.h"
#include <stdio.h>
#include <string.h>

void format_chatml_prompt(const char *rawInput, char *formattedPrompt, size_t maxlen) {
    if (!rawInput || !formattedPrompt) return;

// Wrap raw input into a ChatML block with FireGem API capability
snprintf(formattedPrompt, maxlen,
         "<|im_start|>system\n"
         "You are FireGem, a helpful AI assistant with API capability.\n"
         "If you need to trigger a system message box, output:\n"
         "<firebox>MESSAGE_TEXT</firebox>\n"
         "<|im_end|>\n"
         "<|im_start|>user\n%s<|im_end|>\n"
         "<|im_start|>assistant\n",
         rawInput);

}
