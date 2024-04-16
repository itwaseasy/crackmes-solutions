# "ARMs Race" by Hack The Box

I usually skip "reversing" challenges when the task doesn't require reverse engineering at all. But this one caught my attention because of some of the learning opportunities it provides.

Roughly speaking, this is a programming exercise: the remote server sends you ARM code encoded in a hexadecimal string, and your job is to tell what is in register `r0` when that code is executed. The problem is that the code itself is long, contains non-trivial bit manipulation and some math. Unfortunately, you have about 5 seconds to answer each question, and there are 50 questions that change every time you connect to the server.

In other words, if you can't mentally xor dwords in milliseconds, some kind of automation is required here. And this is the question that interested me.

Long story short, today I learned about the [Unicorn](https://www.unicorn-engine.org/) framework. This is a project by the great guys who created [Capstone](https://www.capstone-engine.org/) (or at least the main developers worked on both of them) and it allows you to emulate different CPUs in software. It's crazy because it's based on QEMU, can emulate 10 architectures, has bindings for 17 languages, and is free.

Regarding this task, you only need 5 lines of code to answer any question:

```python
emu = Uc(UC_ARCH_ARM, UC_MODE_ARM)  
  
emu.mem_map(EMU_ADDRESS, 2 * 1024 * 1024)  
emu.mem_write(EMU_ADDRESS, bytes(bytecode))  
emu.emu_start(EMU_ADDRESS, EMU_ADDRESS + len(bytecode))  
  
return emu.reg_read(UC_ARM_REG_R0)
```

Of course, you also need something to communicate with the server and send data back and forth, but the point is only in these 5 lines. Amazing!
