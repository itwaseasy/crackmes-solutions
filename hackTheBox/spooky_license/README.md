
# "Spooky License" by Hack The Box

My world will never be the same. This crackme introduced me to [angr](https://angr.io/), which is a Swiss army knife for binary analysis problems, so I spent the entire weekend reading about it and solving [various](https://github.com/jakespringer/angr_ctf) [examples](https://github.com/angr/angr-examples) that it offers. Thank you!

The crackme is a great example of how SMT solvers can shine: it consists of one big "if" block that compares the input based on some conditions and then gives you "correct" or "incorrect". The input must have a valid 32-character flag, so brute force will take, let's say, a little longer than you'd like to wait, so another solution is needed.

I won't write another introductory text on angr and how it works, because [angr itself](https://docs.angr.io/en/latest/quickstart.html) did a good job on it, plus there are a ton of good [video tutorials](https://www.youtube.com/watch?v=QkVzjn3z0iw), so just google it if you need it.

The easiest way to solve this problem is to use argv directly because the crackme expects to find a flag there:

```python
  flag = claripy.BVS('flag', 8*32)

  initial_state = project.factory.entry_state(
    args = [argv[1], flag],
    add_options = { angr.options.SYMBOL_FILL_UNCONSTRAINED_MEMORY,
                    angr.options.SYMBOL_FILL_UNCONSTRAINED_REGISTERS}
  )

  base_addr = project.loader.main_object.mapped_base

  simulation = project.factory.simgr(initial_state)
  simulation.explore(find=(base_addr + 0x1876), avoid=(base_addr + 0x1889))
```

and that's all. Two seconds on my machine and it's done. Awesome!

To play with this a bit more, we can skip using argv and start the simulation directly from the address where the check logic starts. This will require setting up the stack frame correctly, given that the flag is copied there first:

```assembly
.text:00000000000011C7 correct_length:                         ; CODE XREF: main+46↑j
.text:00000000000011C7                 mov     rax, [rbp+argv]
.text:00000000000011CB                 mov     rax, [rax+8]
.text:00000000000011CF                 mov     [rbp+flag], rax
```

In this case, the simulation can start from the address `0x11CF`, but before that, we need to create space on the stack for the `flag` variable, place the flag there, and save this address in the `rax` registry:

```python
  initial_state = project.factory.entry_state(
    addr = (base_addr + 0x11cf),
    add_options = { angr.options.SYMBOL_FILL_UNCONSTRAINED_MEMORY,
                    angr.options.SYMBOL_FILL_UNCONSTRAINED_REGISTERS}
  )

  initial_state.regs.rbp = initial_state.regs.rsp
  initial_state.regs.rsp -= 0x28 # flag + pointer to it
  initial_state.regs.rax = initial_state.regs.rsp

  initial_state.memory.store(initial_state.regs.rsp, flag)
```

Other than that, everything else remains the same.
