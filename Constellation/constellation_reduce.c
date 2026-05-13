/* FILE: constellation_reduce.c */
/* PATH: /Constellation/constellation_reduce.c */

/* ------------------------------------------------------------
   AVIS.HEADER
   ROLE: CONSTELLATION_REDUCER
   PURPOSE: Reduces Constellation folder bulk by removing
            temporary files, logs, caches, and non‑intelligence
            artifacts. Ensures the folder remains clean and
            future‑absorbable.
   AUTHOR: Demon
   NOTES: This is the SECOND CONSTELLATION PROGRAM.
   ------------------------------------------------------------ */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <dirent.h>
#include <unistd.h>

#define MAX_PATH 1024

/* ------------------------------------------------------------
   FUNCTION: is_garbage
   PURPOSE: Detects files that should be removed
   ------------------------------------------------------------ */
int is_garbage(const char *name) {
    if (strstr(name, ".tmp")) return 1;
    if (strstr(name, ".cache")) return 1;
    if (strstr(name, ".log")) return 1;
    if (strstr(name, ".bak")) return 1;
    if (strstr(name, "~")) return 1;
    return 0;
}

/* ------------------------------------------------------------
   FUNCTION: reduce_folder
   PURPOSE: Removes garbage files from a folder
   ------------------------------------------------------------ */
int reduce_folder(const char *path) {
    DIR *dir = opendir(path);
    if (!dir) {
        printf("Reducer: Cannot open folder: %s\n", path);
        return 0;
    }

    struct dirent *entry;
    char fullPath[MAX_PATH];

    while ((entry = readdir(dir)) != NULL) {

        if (strcmp(entry->d_name, ".") == 0 ||
            strcmp(entry->d_name, "..") == 0)
            continue;

        snprintf(fullPath, sizeof(fullPath), "%s/%s", path, entry->d_name);

        if (entry->d_type == DT_REG && is_garbage(entry->d_name)) {
            printf("Reducer: Removing %s\n", fullPath);
            unlink(fullPath);
        }
    }

    closedir(dir);
    return 1;
}

/* ------------------------------------------------------------
   MAIN PROGRAM
   PURPOSE: Entry point for the Constellation Reducer
   ------------------------------------------------------------ */
int main(int argc, char *argv[]) {

    if (argc < 2) {
        printf("Usage: constellation_reduce <repo-path>\n");
        return 1;
    }

    char constellationPath[MAX_PATH];
    snprintf(constellationPath, sizeof(constellationPath),
             "%s/Constellation", argv[1]);

    printf("Reducer: Cleaning Constellation folder: %s\n", constellationPath);

    if (!reduce_folder(constellationPath)) {
        printf("Reducer: No cleanup performed.\n");
        return 0;
    }

    printf("Reducer: Cleanup complete.\n");
    return 0;
}
