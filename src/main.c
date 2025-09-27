#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

extern bool exec_shellcode(char *shellcode, int shellcode_len);

int main(int argc, char **argv) {
	if (argc != 2) {
		printf("[-] Usage : %s <shellcode>\n", argv[0]);
		exit(0);
	}

	printf("[+] Executing Shellcode\n");
	if (!exec_shellcode(argv[1], strlen(argv[1]))) {
		printf("[-] Failed to execute shellcode\n");
		return 0;
	};
	printf("[-] Done\n");
	return 0;
}
