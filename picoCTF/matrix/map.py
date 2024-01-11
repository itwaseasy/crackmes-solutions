import sys


class MapPrinter:
    def __init__(self):
        self.index = 0
        self.map = bytearray()

    def run(self, filename):
        with open(filename, 'rb') as f:
            f.seek(0x20f0 + 0x174)
            self.map = bytearray(f.read(4 * 256))

        x = 0
        while x < 0x10:
            y = 0
            while y < 0x10:
                opcode = self.map[self.index]
                match opcode:
                    case 0x81:
                        match self.map[self.index + 1]:
                            case 0xFB:
                                print('X|', end='')
                            case 0x7F:
                                print('+|', end='')
                            case 0x74:
                                print('-|', end='')
                            case 0x85:
                                print('!|', end='')
                    case 0x30:
                        print(' |', end='')

                self.index += 4
                y += 1
            x += 1
            print()


if __name__ == '__main__':
    MapPrinter().run(sys.argv[1])
