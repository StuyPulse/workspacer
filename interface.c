#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <sys/types.h>
#include <ctype.h>
#include <unistd.h>

#define USERS_PATH "./users.csv"
#define USERS_WORK "./their-work"
#define INIT_WORKSPACE_CMD "./init-workspace.sh"
#define RESTORE_WORKSPACE_CMD "./restore-workspace.sh"
#define SAVE_WORK_CMD "./save-work.sh"

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
    printf("%s %s %s", scriptdir, workspacedir, uname);
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
            runWorkspaceShellScript(userwd, SAVE_WORK_CMD, uname);
            break;
        } else {
            printf("Please enter either r or s\n");
        }
    }
}

void promptLogin(char* userwd) {
    char uname[100];
    prompt("Username: ", uname);
    char pass[100];
    prompt("Password: ", pass); // TODO: HIDE PASSWORD INPUT
    char passHash[100];
    sha1HexSum(pass, passHash);

    char expectedPassHash[100];
    getUserPass(uname, expectedPassHash);

    /* strcmp(s0, s1) is 0 when they are identical */
    if (strcmp(passHash, expectedPassHash) == 0) {
        promptLoggedInInterface(userwd, uname);
    } else {
        printf("Username and password did not match :/. Try again.\n");
        promptLogin(userwd);
    }
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

void promptNewUser(char* userwd) {
    char uname[100];
    prompt("Username for new user: ", uname);
    if (userExists(uname)) {
        printf("Username taken\n");
        promptNewUser(userwd);
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
    char passHash[100];
    sha1HexSum(pass1, passHash);
    saveNewUser(uname, passHash);

    runWorkspaceShellScript(userwd, INIT_WORKSPACE_CMD, uname);
}

void promptInterface(char* userwd) {
    printf("Welcome! I can set up your workspace and save your work when you're done.\n");
    printf("Hitting Ctrl-C at any point will exit the program.\n");
    printf("\n");
    printf("Type n to make a new user, or l to login to an existing one: ");
    printf("\n");
    char c;
    while (1) {
        c = (char) getchar();
        if (c == 'n') {
            promptNewUser(userwd);
            break;
        } else if (c == 'l') {
            promptLogin(userwd);
            break;
        } else {
            printf("Please enter either n or l. Hit Ctrl-C to exit");
        }
    }
}

int main(int argc, char *argv[]) {
    printf("euid: %d; uid: %d\n", geteuid(), getuid());
    if (argc != 2) {
        printf("Bad arguments.\nUsage: %s <user-working-dir>\n", argv[0]);
        return 1;
    }
    char cwd[200];
    getcwd(cwd, 200);
    if (strcmp(cwd, "/home/wilson/workspacing") != 0) {
        printf("Run this only in /home/wilson/workspacing");
        return 2;
    }
    /* TODO: use precise length for buffers holding a sha1 digest, rather
     * than length 100 arbitrarily */
    promptInterface(argv[1]); // argv[1] should be user's working directory
    return 0;
}
