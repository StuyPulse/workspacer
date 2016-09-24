#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>
#include <openssl/sha.h>

#define USERS_PATH "/home/wilson/694/workspacing/users.csv"

int startsWith(char* big, char* little) {
    int i;
    for (i = 0; little[i]; i++) {
        if (!big[i]) {
            /* We've reached the end of big, but little goes on */
            return 0;
        }
        if (big[i] != little[i]) {
            return 0;
        }
    }
    return 1;
}

int cutAfter(char* big, char* little, int offset, char* restBuf) {
    int i;
    for (i = 0; little[i]; i++) {
        if (!big[i]) {
            /* We've reached the end of big, but little goes on */
            return 0;
        }
        if (big[i] != little[i]) {
            return 0;
        }
    }
    i += offset; // in practice, we use this to jump past comma
    int j;
    for (j = 0; big[j + i] != '\0' && big[j + i] != '\n'; j++) {
        restBuf[j] = big[j + i];
    }
    restBuf[j + i] = big[j + i]; // copy \0
    return 1;
}

int userExists(char* uname) {
    FILE* file;
    file = fopen(USERS_PATH, "r");
    char line[201];
    while (fgets(line, 201, file)) {
        if (startsWith(line, uname)) {
            fclose(file);
            return 1;
        }
    }
    fclose(file);
    return 0;
}

/* returns 0 for success; -1 for uname not found */
int getUserPass(char* uname, char* passBuf) {
    FILE *file;
    unsigned long i;
    int j;
    file = fopen(USERS_PATH, "r");
    char line[201];
    while (fgets(line, 201, file)) {
        if (cutAfter(line, uname, 1, passBuf)) {
            printf("passBuf: %s\n", passBuf);
            fclose(file);
            return 0;
        }
    }
    fclose(file);
    return -1;
}

void prompt(char* p, char* buf) {
    printf("%s", p);
    scanf("%s", buf);
    printf("\n");
}

void promptLoggedInInterface(char* uname) {
    printf("Welcome, %s! What would you like me to do?\n", uname);
    printf("Type w and I'll set up/restore your workspace\n");
    printf("Type s and I'll save your work\n");
    char action;
    while (1) {
        action = getchar();
        if (action == 'w') {
            break;
        } else if (action == 's') {
            break;
        } else {
            printf("Please enter either w or s\n");
        }
    }
}

void promptLogin() {
    char uname[100];
    prompt("Username: ", uname);
    char pass[100];
    prompt("Password: ", pass); // TODO: HIDE PASSWORD INPUT
    char expectedPass[100];
    getUserPass(uname, expectedPass);

    /* strcmp(s0, s1) is 0 when they are identical */
    if (strcmp(pass, expectedPass) == 0) {
        promptLoggedInInterface(uname);
    } else {
        printf("Username and password did not match :/. Try again.");
        promptLogin();
    }
}

void saveNewUser(char* uname, char* pass) {
    /* Create the line <uname>,<pass> to be put in the file: */
    char line[202];
    int i;
    for (i = 0; uname[i]; i++) {
        line[i] = uname[i];
    }
    int unameLen = i; // excludes \0
    line[unameLen] = ',';
    // TODO: HASH
    for (i = 0; pass[i]; i++) {
        line[unameLen + 1 + i] = pass[i];
    }
    line[unameLen + 1 + i] = '\n';
    line[unameLen + 2 + i] = '\0';
    FILE* file;
    file = fopen(USERS_PATH, "a");
    fputs(line, file);
    fclose(file);
}

void promptNewUser() {
    char uname[100];
    prompt("Username for new user: ", uname);
    if (userExists(uname)) {
        printf("Username taken\n");
        promptNewUser();
        return;
    }
    char pass1[100];
    prompt("Password: ", pass1);
    char pass2[100];
    prompt("Retype same password: ", pass2);
    int i;
    for (i = 0; pass1[i] || pass2[i]; i++) {
        if (pass1[i] != pass2[i]) {
            printf("Passwords did not match. Try again.\n");
            return;
        }
    }
    // Passwords matched
    saveNewUser(uname, pass1);
}

void promptInterface() {
    printf("Welcome! I can set up your workspace and save your work when you're done.\n");
    printf("Hitting Ctrl-C at any point will exit the program.\n");
    printf("\n");
    printf("Type n to make a new user, or l to login to an existing one: ");
    char c = (char) getchar();
    printf("\n");
    while (1) {
        if (c == 'n') {
            promptNewUser();
            break;
        } else if (c == 'l') {
            promptLogin();
            break;
        } else {
            printf("Please enter either n or l. Hit Ctrl-C to exit");
        }
    }
}

int main() {
    printf("euid: %d; uid: %d\n", geteuid(), getuid());
    promptInterface();
    return 0;
}
