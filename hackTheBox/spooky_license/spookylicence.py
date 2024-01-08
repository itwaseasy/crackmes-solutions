import angr
import sys
import claripy

def main(argv):
  project = angr.Project(argv[1])
  flag = claripy.BVS('flag', 8*32)

  base_addr = project.loader.main_object.mapped_base

  initial_state = project.factory.entry_state(
    addr = (base_addr + 0x11cf),
    add_options = { angr.options.SYMBOL_FILL_UNCONSTRAINED_MEMORY,
                    angr.options.SYMBOL_FILL_UNCONSTRAINED_REGISTERS}
  )

  initial_state.regs.rbp = initial_state.regs.rsp
  initial_state.regs.rsp -= 0x28 # flag + pointer to it
  initial_state.regs.rax = initial_state.regs.rsp

  initial_state.memory.store(initial_state.regs.rsp, flag)

  simulation = project.factory.simgr(initial_state)
  simulation.explore(find=(base_addr + 0x1876), avoid=(base_addr + 0x1889))

  if len (simulation.found) > 0:
    print(simulation.found[0].solver.eval(flag, cast_to=bytes))
  else:
    raise Exception('Could not find the solution')

if __name__ == '__main__':
  main(sys.argv)
