import sys


class Disassembler:
    from instructions import InstructionParser

    def __init__(self):
        self.code = bytearray()

    def run(self, filename, offset, size):
        with open(filename, 'rb') as f:
            f.seek(int(offset, 16))
            self.code = bytearray(f.read(int(size, 16)))

        index = 0
        while index < len(self.code):
            try:
                instruction = Disassembler.InstructionParser.parse(self.code[index:])
                print(f'{self.code[index:index + instruction.length()].hex(" "):50}'
                      f'{instruction}')

                index += instruction.length()
            except Exception as e:
                raise Exception(f'Error handling instruction at offset {index:x}: {e}')


if __name__ == '__main__':
    if len(sys.argv) < 3:
        print('Usage: disasm.py <filename> <offset> <size>')
        sys.exit(1)

    Disassembler().run(sys.argv[1], sys.argv[2], sys.argv[3])
