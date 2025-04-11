from dataclasses import dataclass

class Instruction:
    OPCODE_SIZE = 4
    OPERAND_SIZE = 4

    def __init__(self, buffer, name, number_of_operands):
        self.name = name
        self.size = Instruction.OPCODE_SIZE   # at least opcode is here
        self.operands = []

        for i in range(number_of_operands):
            self.operands.append(int.from_bytes(buffer[self.size:self.size + Instruction.OPCODE_SIZE], byteorder='little'))
            self.size += Instruction.OPERAND_SIZE

    def __str__(self):
        if len(self.operands) == 0:
            return self.name
        elif len(self.operands) == 1:
            return self.name.format(self.operands[0])
        elif len(self.operands) == 2:
            return self.name.format(self.operands[0], self.operands[1])

    def length(self):
        return self.size

class InstructionParser:
    @dataclass
    class Opcode:
        name: str
        number_of_operands: int

    opcodes = [
        Opcode('pop r1\n'                           # 0x00
               'r1 = strlen(r1)\n'
               'push r1',
               0),

        Opcode('pop r2\n'                           # 0x01
               'pop r1\n'
               'shl r1, r2\n'
               'push r1',
               0),

        Opcode('pop r2\n'                           # 0x02
               'pop r1\n'
               'mod r1, r2\n'
               'push r1',
               0),

        Opcode('mov r2, {:#04x}\n'                  # 0x03
               'r1 = malloc(r2)\n'
               'getline(r1, r2, stdin)\n'
               'push r1',
               1),

        Opcode('pop r2\n'                           # 0x04
               'pop r1\n'
               'div r1, r2\n'
               'push r1',
               0),

        Opcode('pop r2\n'                           # 0x05
               'pop r1\n'
               'add r1, r2\n'
               'push r1',
               0),

        Opcode('pop r2\n'                           # 0x06
               'pop r1\n'
               'mul r1, r2\n'
               'push r1',
               0),

        Opcode('ptrace_traceme_check()',            # 0x07
               0),

        Opcode('pop r2\n'                           # 0x08
               'pop r1\n'
               'or r1, r2\n'
               'push r1',
               0),

        Opcode('pop r1\n'                           # 0x09
               'add r1, 17\n'
               'mod r1, 3\n'
               'push r1',
               0),

        Opcode('pop r1\n'                           # 0x0A
               'print(r1)\n'
               'free(r1)',
               0),

        Opcode('jmp [{:#04x}*4]',                   # 0x0B
               1),

        Opcode('pop r1\n'                           # 0x0C
               'mul r1, 3\n'
               'sub r1, 6\n'
               'add r1, r1\n'
               'push r1',
               0),

        Opcode('remove_linefeed_from_buffer()',     # 0x0D
               0),

        Opcode('add sp, 4',                         # 0x0E
               0),

        Opcode('mov r2, {:#04x}\n'                  # 0x0F
               'r1 = malloc(r2)\n'
               'memcpy(r1, [sp-4-r2])\n'
               'add sp, r2\n'
               'push r1',
               1),

        Opcode('mov r1, [sp-4-{:#04x}*4]\n'         # 0x10
               'push r1',
               1),

        Opcode('call [{:#04x}*4]\n'                 # 0x11
               'pop r1\n'
               'sub sp, {:#04x}*4\n'
               'push r1',
               2),

        Opcode('pop r1\n'                           # 0x12
               'mov r1, [r1+{:#04x}]\n'
               'push r1',
               1),

        Opcode('pop r2\n'                           # 0x13
               'pop r1\n'
               'cmp r1, r2\n'
               'setz r1\n'
               'push r1',
               0),

        # unused
        Opcode('pop r2\n'                           # 0x14
               'pop r1\n'
               'cmp r1, r2\n'
               'sentz r1\n'
               'push r1',
               0),

        Opcode('pop r1\n'                           # 0x15
               'mul r1, 8\n'
               'add r1, 24\n'
               'push r1',
               0),

        Opcode('pop r1\n'
               'cmp r1, 0\n'                        # 0x16
               'jz [{:#04x}*4]',
               1),

        Opcode('push [sp-4]',                       # 0x17
               0),

        Opcode('pop r2\n'                           # 0x18
               'pop r1\n'
               'sub r1, r2\n'
               'push r1',
               0),

        Opcode('push {:#04x}',                      # 0x19
               1),

        Opcode('pop r2\n'                           # 0x1A
               'pop r1\n'
               'shr r1, r2\n'
               'push r1',
               0),

        # unused
        Opcode('jmp -{:#04x}*4',                    # 0x1B
               1),

        Opcode('ret',                               # 0x1C
               0),
    ]

    @staticmethod
    def parse(buffer):
        opcode_value = int.from_bytes(buffer[:Instruction.OPCODE_SIZE], byteorder='little')

        if opcode_value > len(InstructionParser.opcodes):
            raise Exception(f'undefined opcode {opcode_value}')

        opcode = InstructionParser.opcodes[opcode_value]
        return Instruction(buffer, opcode.name, opcode.number_of_operands)