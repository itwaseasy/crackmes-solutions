from dataclasses import dataclass

class Instruction:
    def __init__(self, code, operands):
        self.code = code
        self.operands = operands

    def __str__(self):
        if len(self.operands) < 1:
            return self.code
        elif len(self.operands) < 2:
            return self.code.format(self.register_convert(self.operands[0]))
        elif len(self.operands) < 3:
            return self.code.format(self.register_convert(self.operands[0]), self.register_convert(self.operands[1]))

        raise Exception("Wrong number of operands")

    @staticmethod
    def register_convert(register_name):
        match register_name:
            case "VEGETABLE":
                return "r1_vegetable"
            case "FRUIT":
                return "r2_fruit"
            case "MEAT":
                return "r3_meat"
            case "DAIRY":
                return "r4_dairy"
            case "PROTEIN":
                return "r5_protein"
            case "CARBO":
                return "r6_carbo"
            case _:
                return register_name

class InstructionParser:
    @dataclass
    class Opcode:
        code: str
        number_of_operands: int

    opcodes = {
        "BOIL" :        Opcode('mov {}, {}', 2),
        "ROAST":        Opcode('xor {}, {}', 2),
        "AES256":       Opcode('push {}', 1),
        "QUICKMAFFS":   Opcode('mov r5_protein, buffer[{}]', 1),
        "SPELL":        Opcode('spell({}, r6_carbo, r5_protein)', 1),
        "GRIND":        Opcode('cmp {}, {}', 2),
        "GOODBYE":      Opcode('mov {}, {}', 2),
        "WINDOW":       Opcode('mov buffer[r6_carbo], {}', 1),
        "LADDER":       Opcode('inc {}', 1),
        "PEPEFROG":     Opcode('strcmp(buffer[{}], buffer[{}])', 2),
        "CHAIR":        Opcode('buffer_dump_num', 0),
        "ID":           Opcode('buffer_dump_str', 0),
    }

    @staticmethod
    def parse(line):
        opcode_value = line.split(" ")[0].strip()
        opcode_operands = line[len(opcode_value)+1:].strip()
        opcode_operands = [s.strip() for s in opcode_operands.split(",")]

        try:
            opcode = InstructionParser.opcodes[opcode_value]
            return Instruction(opcode.code, opcode_operands)
        except:
            raise Exception(f'undefined opcode {opcode_value}')
