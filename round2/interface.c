#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <sys/types.h>
#include <ctype.h>
#include <unistd.h>

#define USERS_PATH "./users.csv"
#define USERS_WORK "bash ./their-work"
#define INIT_WORKSPACE_CMD "bash ./init-workspace.sh"
#define RESTORE_WORKSPACE_CMD "bash ./restore-workspace.sh"
#define S_CMD "./s.sh"

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

/* returns 0 for success, -1 for no comma on line */
int getLineHashEntry(char* line, char* hashBuf) {
    int i;
    for (i = 0; 1; i++) {
        if (line[i] == '\0' || line[i] == '\n') {
            return -1;
        }
        if (line[i] == ',') {
            i++; // Jump over it
            break;
        }
    }
    // Copy the hash to hashBuf
    int hashBufIndex = 0;
    while (1) {
        if (line[i] == '\0' || isspace(line[i])) {
            hashBuf[hashBufIndex] = '\0';
            break;
        }
        hashBuf[hashBufIndex] = line[i];
        i++;
        hashBufIndex++;
    }
    return 0;
}

/* Uses /usr/bin/sha1sum rather than openssl/sha library because
 * we can't be sure about the libraries installed on the school
 * desktops */
void sha1HexSum(char* pass, char* hashBuf) {
    char command[150];
    sprintf(command, "echo \"%s\" | /usr/bin/sha1sum", pass);
    FILE *fp;
    fp = popen(command, "r");

    // Read just the hexadecimal sum from the output
    int i = 0;
    char c;
    while (1) {
        c = (char) fgetc(fp);
        if (isspace(c)) {
            hashBuf[i] = '\0';
            break;
        }
        hashBuf[i] = c;
        i++;
    }
}

int userExists(char* uname) {
    FILE* file;
    file = fopen(USERS_PATH, "r");
    char line[201];
    while (fgets(line, 201, file)) {
        if (startsWith(line, uname) && line[strlen(uname)] == ',') {
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
        if (startsWith(line, uname) && line[strlen(uname)] == ',') {
            getLineHashEntry(line, passBuf);
            fclose(file);
            return 0;
        }
    }
    fclose(file);
    return -1;
}

#define WORKSPACE_PATH "/edu-workspace"
void runWorkspaceShellScript(char* userwd, char* scriptdir, char* uname) {
    // Directory in their cwd in which they'll work
    char workspacedir[100];
    sprintf(workspacedir, "%s%s", userwd, WORKSPACE_PATH);

    char command[200];
    sprintf(command, "%s %s %s", scriptdir, workspacedir, uname);

    // TODO: remove this before the newbies start working
    printf("%s %s %s\n", scriptdir, workspacedir, uname);

    system(command);
}


void prompt(char* p, char* buf) {
    printf("%s", p);
    scanf("%s", buf);
}

void promptLoggedInInterface(char* userwd, char* uname) {
    printf("Welcome, %s! What would you like me to do?\n", uname);
    printf("Type r and I'll restore your workspace\n");
    printf("Type s and I'll save your work\n");
    char action;
    while (1) {
        action = getchar();
        if (action == 'r') {
            printf("Running restore\n");
            runWorkspaceShellScript(userwd, RESTORE_WORKSPACE_CMD, uname);
            break;
        } else if (action == 's') {
            //runWorkspaceShellScript(userwd, SAVE_WORK_CMD, uname);
            break;
        } else {
            printf("Please enter either r or s\n");
        }
    }
}

/* If uname and pass match non-zero. Otherwise, returns non-zero */
int validateLogin(char* uname, char* pass) {
    char passHash[100];
    sha1HexSum(pass, passHash);

    char expectedPassHash[100];
    getUserPass(uname, expectedPassHash);

    /* strcmp(s0, s1) is 0 when they are identical */
    return strcmp(passHash, expectedPassHash) == 0;
}

void saveNewUser(char* uname, char* passHash) {
    /* Create the line <uname>,<passHash> to be put in the file: */
    char line[202];
    int i;
    for (i = 0; uname[i]; i++) {
        line[i] = uname[i];
    }
    int unameLen = i; // excludes \0
    line[unameLen] = ',';
    for (i = 0; passHash[i]; i++) {
        line[unameLen + 1 + i] = passHash[i];
    }
    line[unameLen + 1 + i] = '\n';
    line[unameLen + 2 + i] = '\0';
    FILE* file;
    file = fopen(USERS_PATH, "a");
    fputs(line, file);
    fclose(file);
}

int newUser(char* uname, char* password) {
    if (userExists(uname)) {
        return 1;
    }
    char passHash[100];
    sha1HexSum(password, passHash);
    saveNewUser(uname, passHash);
    return 0;
}
