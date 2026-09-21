// AIFVS-ARTIFACT
// prompt_formatter.h — ChatML prompt formatting interface

#ifndef PROMPT_FORMATTER_H
#define PROMPT_FORMATTER_H

#ifdef __cplusplus
extern "C" {
#endif

// Format a raw user input into a ChatML block for Qwen/Phi style models
void format_chatml_prompt(const char *rawInput, char *formattedPrompt, size_t maxlen);

#ifdef __cplusplus
}
#endif

#endif // PROMPT_FORMATTER_H
