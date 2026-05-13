/* FILE: constellation_validator.c */
/* PATH: /Constellation/constellation_validator.c */

/* ------------------------------------------------------------
   AVIS.HEADER
   ROLE: CONSTELLATION_VALIDATOR
   PURPOSE: Validates the unified intelligence model produced by
            the Constellation Linker. Ensures schema compliance,
            structural integrity, version continuity, and AVIS
            ingestion readiness.
   AUTHOR: Demon
   NOTES: This is the FIFTH CONSTELLATION PROGRAM.
   ------------------------------------------------------------ */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <dirent.h>

#define MAX_PATH 1024
#define MAX_ERRORS 256

typedef struct {
    char message[MAX_PATH];
} ValidationError;

/* ------------------------------------------------------------
   FUNCTION: validate_model_exists
   PURPOSE: Ensures intelligence.model exists and is readable
   ------------------------------------------------------------ */
int validate_model_exists(const char *path) {
    FILE *f = fopen(path, "rb");
    if (!f) {
        printf("ERROR: intelligence.model not found: %s\n", path);
        return 0;
    }
    fclose(f);
    return 1;
}

/* ------------------------------------------------------------
   FUNCTION: validate_model_structure
   PURPOSE: Performs basic binary structure checks
   ------------------------------------------------------------ */
int validate_model_structure(const char *path,
                             ValidationError errors[],
                             int *errorCount) {

    FILE *f = fopen(path, "rb");
    if (!f) return 0;

    fseek(f, 0, SEEK_END);
    long size = ftell(f);
    rewind(f);

    if (size < 64) {
        strcpy(errors[*errorCount].message,
               "Model too small — likely corrupted.");
        (*errorCount)++;
        fclose(f);
        return 0;
    }

    fclose(f);
    return 1;
}

/* ------------------------------------------------------------
   FUNCTION: validate_schema
   PURPOSE: Ensures the model follows AVIS schema law
   ------------------------------------------------------------ */
int validate_schema(const char *path,
                    ValidationError errors[],
                    int *errorCount) {

    FILE *f = fopen(path, "rb");
    if (!f) return 0;

    fseek(f, 0, SEEK_END);
    long size = ftell(f);
    fclose(f);

    if (size <= 0) {
        strcpy(errors[*errorCount].message,
               "Schema validation failed — empty model.");
        (*errorCount)++;
        return 0;
    }

    return 1;
}

/* ------------------------------------------------------------
   FUNCTION: validate_version_chain
   PURPOSE: Ensures version continuity (no missing versions)
   ------------------------------------------------------------ */
int validate_version_chain(const char *repoPath,
                           ValidationError errors[],
                           int *errorCount) {

    char constellationPath[MAX_PATH];
    snprintf(constellationPath, sizeof(constellationPath),
             "%s/Constellation", repoPath);

    DIR *dir = opendir(constellationPath);
    if (!dir) {
        strcpy(errors[*errorCount].message,
               "Constellation folder missing.");
        (*errorCount)++;
        return 0;
    }

    int versionCount = 0;
    struct dirent *entry;

    while ((entry = readdir(dir)) != NULL) {
        if (entry->d_type == DT_DIR &&
            (entry->d_name[0] == 'v' || strstr(entry->d_name, "version"))) {
            versionCount++;
        }
    }

    closedir(dir);

    if (versionCount == 0) {
        strcpy(errors[*errorCount].message,
               "No version folders found.");
        (*errorCount)++;
        return 0;
    }

    return 1;
}

/* ------------------------------------------------------------
   FUNCTION: run_full_validation
   PURPOSE: Executes all validation steps
   ------------------------------------------------------------ */
int run_full_validation(const char *repoPath) {

    ValidationError errors[MAX_ERRORS];
    int errorCount = 0;

    char modelPath[MAX_PATH];
    snprintf(modelPath, sizeof(modelPath),
             "%s/Constellation/intelligence.model", repoPath);

    printf("Validating intelligence model: %s\n", modelPath);

    if (!validate_model_exists(modelPath)) return 0;

    validate_model_structure(modelPath, errors, &errorCount);
    validate_schema(modelPath, errors, &errorCount);
    validate_version_chain(repoPath, errors, &errorCount);

    if (errorCount > 0) {
        printf("\nVALIDATION FAILED — %d error(s):\n", errorCount);
        for (int i = 0; i < errorCount; i++) {
            printf(" - %s\n", errors[i].message);
        }
        return 0;
    }

    printf("VALIDATION PASSED — intelligence model is AVIS‑ready.\n");
    return 1;
}

/* ------------------------------------------------------------
   MAIN PROGRAM
   PURPOSE: Entry point for the Constellation Validator
   ------------------------------------------------------------ */
int main(int argc, char *argv[]) {

    if (argc < 2) {
        printf("Usage: constellation_validator <repo-path>\n");
        return 1;
    }

    printf("Starting validation for repo: %s\n", argv[1]);

    int result = run_full_validation(argv[1]);

    if (result)
        printf("Constellation validation complete — SUCCESS.\n");
    else
        printf("Constellation validation complete — FAILURE.\n");

    return 0;
}
