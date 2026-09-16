#include "json_loader.h"
#include "cJSON.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

JsonFile* load_json(const char *filename) {
    FILE *f = fopen(filename, "rb");
    if (!f) return NULL;

    fseek(f, 0, SEEK_END);
    long len = ftell(f);
    fseek(f, 0, SEEK_SET);

    char *data = (char*)malloc(len + 1);
    fread(data, 1, len, f);
    data[len] = '\0';
    fclose(f);

    cJSON *json = cJSON_Parse(data);
    free(data);
    if (!json) return NULL;

    JsonFile *jf = (JsonFile*)malloc(sizeof(JsonFile));
    jf->count = cJSON_GetArraySize(json);
    jf->entries = (JsonEntry*)malloc(sizeof(JsonEntry) * jf->count);

    for (int i = 0; i < jf->count; i++) {
        cJSON *item = cJSON_GetArrayItem(json, i);
        cJSON *fname = cJSON_GetObjectItemCaseSensitive(item, "filename");
        cJSON *fpath = cJSON_GetObjectItemCaseSensitive(item, "path");

        // Duplicate strings into the struct layout safely
        jf->entries[i].filename = fname ? _strdup(fname->valuestring) : NULL;
        jf->entries[i].path     = fpath ? _strdup(fpath->valuestring) : NULL;
    }

    cJSON_Delete(json);
    return jf;
}



void free_json(JsonFile *jf) {
    if (!jf) return;
    if (jf->entries) free(jf->entries);
    free(jf);
}
