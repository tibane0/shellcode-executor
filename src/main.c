#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/wait.h>
#include <spawn.h>

extern void Memory(pid_t pid);

extern char **environ;

pid_t parse_args(int argc, char **argv) {
	int opt;
	pid_t pid;
	while ((opt = getopt(argc, argv, "p:")) != -1) {
		switch (opt) {
			case 'p':
				return (pid_t)atoi(optarg);
			default:
				return 0;
		}
	}
	if (optind < argc) {
		if (posix_spawn(&pid, argv[optind], NULL, NULL, argv + optind, environ) != 0) {
			perror("posix spawn failed");
			exit(0);

		} else {
			return pid;
		}
	}

}

void PrintHex(unsigned char *data, void *address) {
	printf("%p ", address);
	for (int i = 0; i < 16; i++) {
        	printf("%02x", data[i]); // print one byte
	       	if (i == 7) {
            		printf(" -- ");        // space after first 8
        	} else {
            		printf(" ");
        	}
    }
    	printf("\n");
}


int main(int argc, char **argv) {
	if (argc < 2) {
		printf("[-] Usage\n%s <program\n%s -p <pid>\n", argv[0], argv[0]);
		return 1;
	}
	pid_t pid = parse_args(argc, argv);
	if (pid == -1 || pid == 0) {
		puts("INVALID PID");
		return EXIT_FAILURE;
	}
	printf("PID : %d\n", (int)pid);
	Memory(pid);
	puts("[-] Memory Visualizer Is Finished");
	return 0;
}


