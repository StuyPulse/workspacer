#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>

/* 
 * This can be compiled to a public location like /tmp/launch
 * and given `chmod +xs` permissions. Another user can then
 * run it as a proxy to interface.o
 */

int main() {
    char path[200];
    getcwd(path, 200);
    int status = chdir("/home/wilson/workspacing");
    if (status != 0) {
        printf("chdir failed. status: %d\n", status);
        printf("original cwd: %s\n", path);
        printf("Are you a newbie? Ask an older member for help!\n");
        return 1;
    }

    execl("./interface.o", "./interface.o", path, (char *) NULL);
    return 0;
}
