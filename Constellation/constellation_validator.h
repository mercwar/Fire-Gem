/* FILE: constellation_validator.h */
/* PATH: /Constellation/constellation_validator.h */

/* ------------------------------------------------------------
   AVIS.HEADER
   ROLE: CONSTELLATION_VALIDATOR_HEADER
   PURPOSE: Header for the Constellation Validator. Defines the
            prototypes, constants, and structures used to verify
            the integrity, schema compliance, and correctness of
            the unified intelligence model produced by the
            Constellation Linker.
   AUTHOR: Demon
   NOTES: This is the FIFTH HEADER in the Constellation chain.
   ------------------------------------------------------------ */

#ifndef CONSTELLATION_VALIDATOR_H
#define CONSTELLATION_VALIDATOR_H

#define MAX_PATH 1024
#define MAX_ERRORS 256

typedef struct {
    char message[MAX_PATH];
} ValidationError;

int validate_model_exists(const char *path);
int validate_model_structure(const char *path,
                             ValidationError errors[],
                             int *errorCount);
int validate_schema(const char *path,
                    ValidationError errors[],
                    int *errorCount);
int validate_version_chain(const char *repoPath,
                           ValidationError errors[],
                           int *errorCount);
int run_full_validation(const char *repoPath);

#endif
