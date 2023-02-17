#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// https://crackmes.one/crackme/5ab77f5c33c5d40ad448c678

int validate(const char* c) {
  int sum = 0;
  while(*c) {
    sum = (*c++ + (sum*64)) % 10000000;
  }

  return sum == 5546807;
}

void bruteforce() {
  const int maximum_key_size = 5;

  // All printable ASCII characters between 0x20..0x7e.
  const int alphabet_size = 0x7f - 0x20;
  char alphabet[alphabet_size];

  // Generate an alphabet starting from 0x20 symbol.
  for (int i = 0; i < alphabet_size; ++i) {
    alphabet[i] = (char) (i + 0x20);
  }

  const char last_alphabet_char = alphabet[sizeof(alphabet) - 1];

  // The idea is to allocate a buffer of size key_length, initialize it with
  // the first character of the alphabet, and then increment each character at
  // each position. When the function has checked all possible options, a new
  // buffer will be allocated with a length equal to key_size + 1, and will
  // check all combinations there.
  for (int key_length = 1; key_length <= maximum_key_size; ++key_length) {
    char *buffer = malloc(key_length + 1);
    memset(buffer, alphabet[0], key_length);
    buffer[key_length+1] = 0;

    printf("Checking options for key length = %d\n", key_length);

    while(1) {
      if (validate(buffer)) {
        printf("FOUND: '%s'\n", buffer);
      }

      int index = 0;
      for(; index < key_length; ++index) {
        if (buffer[index] != last_alphabet_char) {
          ++buffer[index];
          break;
        } else {
          buffer[index] = alphabet[0];
        }
      }

      // Stop if it was the last combination of the last character.
      if (index == key_length && buffer[key_length -1] == alphabet[0]) {
        break;
      }
    }

    free(buffer);
  }
}

int main() {
  bruteforce();
  return 0;
}
