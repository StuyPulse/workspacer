#include <stdio.h>

int main(int argc, char* argv[]) {
    char* uname = argv[1];
    normalize_uname(uname);

    char* pass = argv[2];
    int failure = newUser(uname, pass);
    if (failure) {
        printf("failure\n");
    }
    return 0;
}
