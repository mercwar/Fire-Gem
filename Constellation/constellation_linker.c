/* FILE: constellation_linker.c */
/* PATH: /Constellation/constellation_linker.c */

/* ------------------------------------------------------------
   AVIS.HEADER
   ROLE: CONSTELLATION_LINKER
   PURPOSE: Links all compiled Constellation binaries (*.bin)
            into a unified intelligence model (intelligence.model).
            This is the final merge step before validation.
   AUTHOR: Demon
   NOTES: This is the FOURTH CONSTELLATION PROGRAM.
   ------------------------------------------------------------ */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <dirent.h>

#define MAX_PATH 1024
#define MAX_BINARIES 256

typedef struct {
    char path[MAX_PATH];
    char name[MAX_PATH];
} BinaryEntry;

/* ------------------------------------------------------------
   FUNCTION: is_binary
   PURPOSE: Detects *.bin files
   ------------------------------------------------------------ */
int is_binary(const char *name) {
    return strstr(name, ".bin") != NULL;
}

/* ------------------------------------------------------------
   FUNCTION: scan_binaries
   PURPOSE: Scans Constellation folder for compiled binaries
   ------------------------------------------------------------ */
int scan_binaries(const char *path,
                  BinaryEntry bins[],
                  int *count) {

    DIR *dir = opendir(path);
    if (!dir) {
        printf("Linker: Cannot open folder: %s\n", path);
        return 0;
    }

    struct dirent *entry;
    char fullPath[MAX_PATH];

    while ((entry = readdir(dir)) != NULL) {

        if (entry->d_type == DT_REG && is_binary(entry->d_name)) {

            snprintf(fullPath, sizeof(fullPath), "%s/%s",
                     path, entry->d_name);

            snprintf(bins[*count].path, MAX_PATH, "%s", fullPath);
            snprintf(bins[*count].name, MAX_PATH, "%s", entry->d_name);

            (*count)++;
        }
    }

    closedir(dir);
    return 1;
}

/* ------------------------------------------------------------
   FUNCTION: link_binaries
   PURPOSE: Merges all *.bin files into intelligence.model
   ------------------------------------------------------------ */
void link_binaries(BinaryEntry bins[],
                   int count,
                   const char *output) {

    FILE *out = fopen(output, "wb");
    if (!out) {
        printf("Linker: Failed to create %s\n", output);
        return;
    }

    printf("Linker: Creating unified intelligence model...\n");

    for (int i = 0; i < count; i++) {

        FILE *in = fopen(bins[i].path, "rb");
        if (!in) {
            printf("Linker: Failed to open %s\n", bins[i].path);
            continue;
        }

        printf("Linker: Merging %s\n", bins[i].name);

        char buffer[4096];
        size_t bytes;

        while ((bytes = fread(buffer, 1, sizeof(buffer), in)) > 0) {
            fwrite(buffer, 1, bytes, out);
        }

        fclose(in);
    }

    fclose(out);

    printf("Linker: intelligence.model created successfully.\n");
}

/* ------------------------------------------------------------
   MAIN PROGRAM
   PURPOSE: Entry point for the Constellation Linker
   ------------------------------------------------------------ */
int main(int argc, char *argv[]) {

    if (argc < 2) {
        printf("Usage: constellation_linker <repo-path>\n");
        return 1;
    }

    char constellationPath[MAX_PATH];
    snprintf(constellationPath, sizeof(constellationPath),
             "%s/Constellation", argv[1]);

    BinaryEntry bins[MAX_BINARIES];
    int binCount = 0;

    printf("Linker: Scanning for binaries...\n");

    if (!scan_binaries(constellationPath, bins, &binCount)) {
        printf("Linker: No binaries found.\n");
        return 0;
    }

    char outputPath[MAX_PATH];
    snprintf(outputPath, sizeof(outputPath),
             "%s/Constellation/intelligence.model", argv[1]);

    link_binaries(bins, binCount, outputPath);

    printf("Linker: Done.\n");
    return 0;
}
