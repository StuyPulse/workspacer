#include <stdio.h>

#define SAVE_WORK_CMD "./save-work.sh"

int main(int argc, char* argv[]) {
    char* workspacedir = argv[1];

    char* uname = argv[2];
    normalize_uname(uname);

    char* pass = argv[3];
    char command[100];
    if (validateLogin(uname, pass)) {
        sprintf(command, "bash %s %s %s", SAVE_WORK_CMD, workspacedir, uname);
        system(command);
        return 0;
    }
    printf("bad-credentials");
    return 1;
}
