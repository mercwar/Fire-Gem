// fire_gem.h
#ifndef FIRE_GEM_H
#define FIRE_GEM_H

#define MAX_CMD 512

typedef struct
{
    // CMD_STRING
    char cmdExec[MAX_CMD];   // SHELL_EXEC
    char cmdBash[MAX_CMD];   // SHELL_BASH
    char cmdInet[MAX_CMD];   // WIN_INET

    // CMD_FILE
    char fileSh[MAX_CMD];     // SHELL_SH
    char fileBash[MAX_CMD];   // SHELL_BASH_FILE
    char fileBat[MAX_CMD];    // SHELL_BAT
    char fileCmd[MAX_CMD];    // SHELL_CMD

    // Raw JSON text (optional for debugging)
    char json[4096];

} FG_JSON_MACRO;

#endif
