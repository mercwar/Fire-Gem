#ifndef LLM_WRAPPER_H
#define LLM_WRAPPER_H

#include <stddef.h>

int llm_init(const char *model_path);
int llm_generate(const char *prompt, char *outbuf, size_t maxlen);
void llm_free(void);

#endif
