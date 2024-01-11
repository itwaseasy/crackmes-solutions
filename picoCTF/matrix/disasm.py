import sys


class Disassembler:
    def __init__(self):
        self.index = 0
        self.matrix_code = bytearray()
        self.instructions = {
            0x00: {
                'len': 1,
                'code': lambda x:
                    'nop'
            },
            0x01: {
                'len': 1,
                'code': lambda x:
                    'pop r1\n'
                    'ret'
            },
            0x10: {
                'len': 1,
                'code': lambda x:
                    f'push [sp-2]'
            },
            0x11: {
                'len': 1,
                'code': lambda x:
                    'pop r1'
            },
            0x12: {
                'len': 1,
                'code': lambda x:
                    'pop r1\n'
                    f'add [sp-2], r1'
            },
            0x13: {
                'len': 1,
                'code': lambda x:
                    'pop r1\n'
                    f'sub [sp-2], r1'
            },
            0x14: {
                'len': 1,
                'code': lambda x:
                    f'xchg [sp-4], [sp-2]'
            },
            0x20: {
                'len': 1,
                'code': lambda x:
                    'pop r1\n'
                    'push_e r1'
            },
            0x21: {
                'len': 1,
                'code': lambda x:
                    'pop_e r1\n'
                    'push r1'
            },
            0x30: {
                'len': 1,
                'code': lambda x:
                    'pop r1\n'
                    'jmp r1'
            },
            0x31: {
                'len': 1,
                'code': lambda x:
                    'pop r1\n'
                    'pop r2\n'
                    'test r2, r2\n'
                    f'jnz {self.index + 1:04X}\n'
                    'jmp r1'
            },
            0x80: {
                'len': 2,
                'code': lambda x:
                    'push {:04X}'.format(int.from_bytes(x, byteorder='little', signed=True))
            },
            0x81: {
                'len': 3,
                'code': lambda x:
                    'push {:04X}'.format(int.from_bytes(x, byteorder='little', signed=False))
            },
            0xC0: {
                'len': 1,
                'code': lambda x:
                    'call getc\n'
                    'push r1'
            },
            0xC1: {
                'len': 1,
                'code': lambda x:
                    'pop r1\n'
                    'call putc'
            }
        }

    def run(self, filename):
        with open(filename, 'rb') as f:
            f.seek(0x20f0)
            self.matrix_code = bytearray(f.read(0x5d1))

        print(f'{"Index":4}\t'
              f'{"Opcode":4}\t'
              f'{"Disasm"}')

        while self.index < len(self.matrix_code):
            opcode = self.matrix_code[self.index]
            if opcode not in self.instructions:
                sys.exit(f'unknown opcode {opcode:X}, offset {self.index:X}')

            instruction = self.instructions[opcode]
            instruction_len = instruction['len']
            instruction_operators = self.matrix_code[self.index + 1:self.index + instruction_len]

            disasm = instruction['code'](instruction_operators).replace('\n', '\n\t\t\t\t').splitlines()

            print(f'{self.index:04X}\t'
                  f'{opcode:02X}{instruction_operators.hex():4}\t'
                  f'{disasm[0]:20}\t')
            [print(d) for d in disasm[1:]]

            self.index += instruction_len


if __name__ == '__main__':
    Disassembler().run(sys.argv[1])
