#ifndef JSON_LOADER_H
#define JSON_LOADER_H

typedef struct {
    char *filename; // Changed from key
    char *path;     // Changed from value
    char *type;
    char *size;
} JsonEntry;

typedef struct {
    int count;
    JsonEntry *entries;
} JsonFile;

JsonFile* load_json(const char *filename);
void free_json(JsonFile *jf);

#endif
