// target.c
#include <stdio.h>
#include <unistd.h>

int main() {
    printf("Target PID: %d\n", getpid());
    fflush(stdout);

    while (1) {
        sleep(1); // keep running so you can attach
    }

    return 0;
}

