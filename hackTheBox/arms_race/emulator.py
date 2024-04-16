from unicorn import *
from unicorn.arm_const import *
from pwn import *

EMU_ADDRESS = 0x10000
REMOTE_HOST = 'HOST_HERE'
REMOTE_PORT = 0xF00DCAFE

def emulate(bytecode):
    try:
        emu = Uc(UC_ARCH_ARM, UC_MODE_ARM)

        emu.mem_map(EMU_ADDRESS, 2 * 1024 * 1024)
        emu.mem_write(EMU_ADDRESS, bytes(bytecode))
        emu.emu_start(EMU_ADDRESS, EMU_ADDRESS + len(bytecode))

        return emu.reg_read(UC_ARM_REG_R0)
    except UcError as e:
        print(f'ERROR: {e}')


io = remote(REMOTE_HOST, REMOTE_PORT)

while True:
    m = io.recvregex(br'(Level .+): (.+)\n', capture=True)
    if m is None:
        print(io.recvS())
        break

    io.recvregex(br'Register .+:')

    bytecode = bytes.fromhex(m.group(2).decode())
    r0 = emulate(bytecode)

    print(f'{m.group(1).decode()}: {r0}')

    io.sendline(f'{r0}'.encode())
