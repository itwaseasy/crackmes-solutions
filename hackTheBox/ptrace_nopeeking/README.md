
# "PTRACE_NOPEEKING" by Hack The Box

Debugging a debugger is probably as much fun as disassembling a disassembler or decompiling a compiler. But disassembling two debuggers debugging each other at the same time and preventing you from decompiling them is priceless.

To start it simple, there is one binary that forks and checks two parts of the flag at the same time. To complicate things a little, these two processes behave as both a debugger and a debuggee, controlling the execution of their neighbor.

Each process manages its own state: the flag-checking algorithm is not executed sequentially but is divided into several stages. For example, the first step (state `0`) of the parent process is to initialize the global variables responsible for the verification algorithm and read the input data from standard input. It then moves to the next state, returning execution to the child process. When a child process is started, its first state is also initialization. When the parent process is executed, it runs the validation logic. Then the child. And it all goes back and forth so that both processes can perform actions in parallel.

To complicate things and prevent you from easily reading the C code decompiled for you by IDA, the crackme uses a trick with `ud2` [instructions](https://www.felixcloutier.com/x86/ud) and this is where the "debug-each-other" logic comes into play. When the debuggee executes this instruction, the OS wakes up the debugger because the child process was stopped by the delivery of the signal. Then, if this signal is `SIGILL`, the magic happens: the current debugger will check the two bytes following the `ud2` instruction and run additional logic based on them using `ptrace`. For example, if `SIGILL` was delivered and the next two bytes are `0x5253`, the debugger will run logic that reads user input. If the bytes are `0x4543`, the debugger will execute logic that decrypts the current character, and so on. There are 5 such cases that either simply transfer data from a register to memory, or run more complex logic, such as reading from standard input.

To split the check between two processes, a global array is used:

```assembly
.data:0000000000202020 whose_turn_to_check dd 0, 0, 1, 0, 1, 1, 1, 0, 0, 1, 0, 1, 0, 1, 1, 0, 0, 1
.data:0000000000202068                     dd 1, 1, 1, 0, 1, 0, 0, 0, 1
```

There are 27 integers (according to the length of the flag), each of which indicates which process should check the current symbol. If it is `0` then the parent should do it, otherwise the child is responsible for it. The interesting thing is that if the currently active process does not need to check the character, it still switches its current state to "im-going-to-check-this-character". But instead of checking the actual char, it gets the value from the `rand` function and marks it, so in the following states, it can understand that the character is "fake" and skip it correctly.

In any case, once you figure it all out and start to understand what's going on, the logic behind the check won't seem very complicated. Each process does the same thing, which can be summarized in the following code:

```c
int encrypted_char = (current_char - char_index + 26) ^ (44 * (char_index - 1));
int flag_char = whose_turn_to_check[char_index] == 0 ? part_0[char_index] : part_1[char_index];

if (encrypted_char != flag_char)
	failed = 1;
```

In other words, the process performs some math on the current character entered by the user, and if it is not equal to the hard-coded value, it means the input is invalid. `part_0` and `part_1` are arrays of valid values that the parent and child processes check during their "rotation".

To recover the flag, you can use the following code:

```c
int part0_index = 0, part1_index = 0;

for (int i = 0; i <= 0x1A; ++i) {  
  int encrypted = whose_turn_to_check[i] == 0 ? part_0[part0_index++] : part_1[part1_index++];  
  
  int result = (encrypted ^ (i*0x2C)) - 0x1A + (i+1);  
  printf("%c", result & 0xFF);
}
```

The challenge can be found [here](https://app.hackthebox.com/challenges/PTRACE_NOPEEKING).
