from dataclasses import dataclass
from typing import Callable
from operands import Operand


class Instruction:
    def __init__(self, buffer, name, number_of_operands):
        self.buffer = buffer
        self.name = name
        self.size = 1   # at least opcode is here
        self.first_operand = None
        self.second_operand = None

        if number_of_operands > 0:
            self.first_operand = Operand(buffer[self.size:])
            self.size += self.first_operand.size()

        if number_of_operands > 1:
            self.second_operand = Operand(buffer[self.size:])
            self.size += self.second_operand.size()

    def __str__(self):
        result = f'{self.name}'

        if self.first_operand is not None:
            result += f'\t{self.first_operand}'

        if self.second_operand is not None:
            result += f', {self.second_operand}'

        return result

    def length(self):
        return self.size


class MovWithSegment(Instruction):
    def __str__(self):
        result = Instruction.__str__(self)
        return result.replace(", ", f', fs:')


class StringsInstruction(Instruction):
    def __str__(self):
        result = f'{self.name}'

        try:
            operand_size = Operand.Sizes(self.buffer[1])
        except Exception:
            raise Exception(f'Unknown operand size: {self.buffer[1]:#04x}')

        match operand_size:
            case Operand.Sizes.BYTE:
                result += 'b'
            case Operand.Sizes.WORD:
                result += 'w'
            case Operand.Sizes.DWORD:
                result += 'd'

        return result

    def length(self):
        return 2


class ESPHandlerInstruction(Instruction):
    def __str__(self):
        return f'{self.name}, {int.from_bytes(self.buffer[1:3], "little"):#04x}'

    def length(self):
        return 3

class RETInstruction(Instruction):
    def __str__(self):
        result = f'{self.name}'

        stack_adjustment = int.from_bytes(self.buffer[1:3])
        if stack_adjustment > 0:
            result += f'\t{stack_adjustment}'

        return result

    def length(self):
        return 3


class InstructionParser:
    @dataclass
    class Opcode:
        name: str
        number_of_operands: int
        constructor: Callable

    opcodes = [
        Opcode('nop',           0, Instruction),                # 0x00
        Opcode('inc',           1, Instruction),                # 0x01
        Opcode('dec',           1, Instruction),                # 0x02
        Opcode('not',           1, Instruction),                # 0x03
        Opcode('neg',           1, Instruction),                # 0x04
        Opcode('mul',           2, Instruction),                # 0x05
        Opcode('imul',          2, Instruction),                # 0x06
        Opcode('div',           2, Instruction),                # 0x07
        Opcode('idiv',          2, Instruction),                # 0x08
        Opcode('add',           2, Instruction),                # 0x09
        Opcode('sub',           2, Instruction),                # 0x0A
        Opcode('adc',           2, Instruction),                # 0x0B
        Opcode('sbb',           2, Instruction),                # 0x0C
        Opcode('or',            2, Instruction),                # 0x0D
        Opcode('xor',           2, Instruction),                # 0x0E
        Opcode('and',           2, Instruction),                # 0x0F
        Opcode('cmp',           2, Instruction),                # 0x10
        Opcode('test',          2, Instruction),                # 0x11
        Opcode('shl',           2, Instruction),                # 0x12
        Opcode('sar',           2, Instruction),                # 0x13
        Opcode('shl',           2, Instruction),                # 0x14
        Opcode('shr',           2, Instruction),                # 0x15
        Opcode('rol',           2, Instruction),                # 0x16
        Opcode('ror',           2, Instruction),                # 0x17
        Opcode('rcl',           2, Instruction),                # 0x18
        Opcode('rcr',           2, Instruction),                # 0x19
        Opcode('mov',           2, Instruction),                # 0x1A
        Opcode('mov',           2, MovWithSegment),             # 0x1B
        Opcode('mov_wtf',       2, Instruction),                # 0x1C
        Opcode('push',          1, Instruction),                # 0x1D
        Opcode('pop',           1, Instruction),                # 0x1E
        Opcode('pushf',         0, Instruction),                # 0x1F
        Opcode('popf',          0, Instruction),                # 0x20
        Opcode('jo',            1, Instruction),                # 0x21
        Opcode('jno',           1, Instruction),                # 0x22
        Opcode('jc',            1, Instruction),                # 0x23
        Opcode('jnc',           1, Instruction),                # 0x24
        Opcode('jz',            1, Instruction),                # 0x25
        Opcode('jnz',           1, Instruction),                # 0x26
        Opcode('ja',            1, Instruction),                # 0x27
        Opcode('jbe',           1, Instruction),                # 0x28
        Opcode('js',            1, Instruction),                # 0x29
        Opcode('jns',           1, Instruction),                # 0x2A
        Opcode('jp',            1, Instruction),                # 0x2B
        Opcode('jnp',           1, Instruction),                # 0x2C
        Opcode('jl',            1, Instruction),                # 0x2D
        Opcode('jge',           1, Instruction),                # 0x2E
        Opcode('jg',            1, Instruction),                # 0x2F
        Opcode('jle',           1, Instruction),                # 0x30
        Opcode('jmp',           1, Instruction),                # 0x31
        Opcode('call',          1, Instruction),                # 0x32
        Opcode('ret',           0, RETInstruction),             # 0x33
        Opcode('add\tesp',      0, ESPHandlerInstruction),      # 0x34
        Opcode('sub\tesp',      0, ESPHandlerInstruction),      # 0x35
        Opcode('movs',          0, StringsInstruction),         # 0x36
        Opcode('rep movs',      0, StringsInstruction),         # 0x37
        Opcode('cmps',          0, StringsInstruction),         # 0x38
        Opcode('repe cmps',     0, StringsInstruction),         # 0x39
        Opcode('repne cmps',    0, StringsInstruction),         # 0x3A
        Opcode('lods',          0, StringsInstruction),         # 0x3B
        Opcode('stos',          0, StringsInstruction),         # 0x3C
        Opcode('repe scas',     0, StringsInstruction),         # 0x3D
        Opcode('repne scas',    0, StringsInstruction),         # 0x3E
        Opcode('scas',          0, StringsInstruction),         # 0x3F
        Opcode('repe stos',     0, StringsInstruction),         # 0x40
    ]

    @staticmethod
    def parse(buffer):
        opcode_value = buffer[0]

        if opcode_value > len(InstructionParser.opcodes):
            raise Exception(f'undefined opcode {opcode_value}')

        opcode = InstructionParser.opcodes[opcode_value]
        return opcode.constructor(buffer, opcode.name, opcode.number_of_operands)
