from enum import Enum


class Operand:
    class Types(Enum):
        REGISTER = 0x01
        MEMORY = 0x02
        IMMEDIATE = 0x03

    class Sizes(Enum):
        BYTE = 0x01
        WORD = 0x02
        DWORD = 0x03

    class Registers(Enum):
        EAX = 0x04
        ECX = 0x08
        EDX = 0x0C
        EBX = 0x10
        ESP = 0x14
        EBP = 0x18
        ESI = 0x1C
        EDI = 0x20

    sizes_names = {
        Sizes.BYTE:     "byte ptr",
        Sizes.WORD:     "word ptr",
        Sizes.DWORD:    "dword ptr",
    }

    register_names = {
        Registers.EAX: {Sizes.DWORD: "eax", Sizes.WORD: "ax", Sizes.BYTE: "al"},
        Registers.ECX: {Sizes.DWORD: "ecx", Sizes.WORD: "cx", Sizes.BYTE: "cl"},
        Registers.EDX: {Sizes.DWORD: "edx", Sizes.WORD: "dx", Sizes.BYTE: "dl"},
        Registers.EBX: {Sizes.DWORD: "ebx", Sizes.WORD: "bx", Sizes.BYTE: "bl"},
        Registers.ESP: {Sizes.DWORD: "esp", Sizes.WORD: "sp"},
        Registers.EBP: {Sizes.DWORD: "ebp", Sizes.WORD: "bp"},
        Registers.ESI: {Sizes.DWORD: "esi", Sizes.WORD: "si"},
        Registers.EDI: {Sizes.DWORD: "edi", Sizes.WORD: "di"},
    }

    def __init__(self, buffer):
        self.operand_type = None
        self.operand_size = None
        self.register = None
        self.index_register = None
        self.scale = None
        self.displacement = None
        self.immediate = None

        try:
            self.operand_type = Operand.Types(buffer[0])
        except Exception:
            raise Exception(f'Unknown operand type: {buffer[0]:#04x}')

        if self.operand_type == Operand.Types.IMMEDIATE:
            self.immediate = int.from_bytes(buffer[1:5], byteorder='little')
            return

        try:
            self.operand_size = Operand.Sizes(buffer[1])
        except Exception:
            raise Exception(f'Unknown operand size: {buffer[1]:#04x}')

        try:
            self.register = Operand.Registers(buffer[2])
        except Exception:
            raise Exception(f'Unknown register: {buffer[2]:#04x}')

        if self.operand_type != Operand.Types.MEMORY:
            return

        try:
            if buffer[3] != 0:
                self.index_register = Operand.Registers(buffer[3])
        except Exception:
            raise Exception(f'Unknown index register: {buffer[3]:#04x}')

        self.scale = buffer[4]
        self.displacement = int.from_bytes(buffer[5:9], 'little')

        if self.scale != 0:
            is_power_of_2 = (self.scale & (self.scale - 1) == 0) and self.scale != 0
            if not is_power_of_2 or self.scale > 8:
                raise Exception(f'Wrong scale: {self.scale:#04x}')

    def __str__(self):
        match self.operand_type:
            case Operand.Types.REGISTER:
                return f'{Operand.register_names[self.register][self.operand_size]}'

            case Operand.Types.MEMORY:
                result = f'{Operand.sizes_names[self.operand_size]} ['
                result += f'{Operand.register_names[self.register][Operand.Sizes.DWORD]}'
                if self.index_register is not None:
                    result += f'+{Operand.register_names[self.index_register][Operand.Sizes.DWORD]}'
                    if self.scale > 1:
                        result += f'*{self.scale:#04x}'
                if self.displacement != 0:
                    result += f'+{self.displacement:#04x}'
                result += ']'

                return result

            case Operand.Types.IMMEDIATE:
                return f'{self.immediate:#04x}'

    def size(self):
        match self.operand_type:
            case Operand.Types.REGISTER:
                return 3  # operand_type, operand_size, register
            case Operand.Types.MEMORY:
                return 9  # operand_type, operand_size, register, index_register, scale, displacement (4 bytes)
            case Operand.Types.IMMEDIATE:
                return 5  # operand_type, immediate (4 bytes)
