import sys

class Translator:
    from instruction import InstructionParser

    def run(self, filename):
        with open(filename) as f:
            while line := f.readline():
                print(f'\t{Translator.InstructionParser.parse(line)}')

if __name__ == '__main__':
    if len(sys.argv) != 2:
        print('Usage: translate.py <filename>')
        sys.exit(1)

    Translator().run(sys.argv[1])
