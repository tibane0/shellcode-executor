#include <iostream>
#include <vector>
#include <cstring>
#include <sys/mman.h>
#include <unistd.h>
#include <signal.h>
#include <sys/wait.h>
#include <sys/prctl.h>
#include <linux/seccomp.h>
#include <linux/filter.h>
#include <sys/ptrace.h>
#include <sys/user.h>


class ShellcodeLoader {
	private:
		void *exec_mem;
		char *shellcode;
		size_t shellcode_length;
		
	public:
		bool ExecShellcode() {
			void (*funcptr)() = (void(*)())exec_mem;
			funcptr;
			return true;
		}

		bool ExecMem() {
			exec_mem = mmap(NULL, (int)shellcode_length + 1, PROT_READ | PROT_WRITE | PROT_EXEC, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
			if (exec_mem == MAP_FAILED) {
				perror("mmap failed");
				return false;
			}
			
			memcpy(exec_mem, shellcode, shellcode_length);
			
			free_exec_mem();
			return true;
		}

		void getShellcode(const char* Shellcode, int size) {
			memcpy(shellcode, Shellcode, (size_t)size);
		}


		void free_exec_mem() {
			munmap(exec_mem, shellcode_length);
		}
};




int main() {
	ShellcodeLoader shell;
	

	const char *code = "\x31\xc0\x48\xbb\xd1\x9d\x96\x91\xd0\x8c\x97\xff\x48\xf7\xdb\x53\x54\x5f\x99\x52\x57\x54\x5e\xb0\x3b\x0f\x05";
	shell.getShellcode(code , 27);
	shell.ExecMem();
	shell.ExecShellcode();
	return 0;
}

