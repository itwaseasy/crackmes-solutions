#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>

// https://crackmes.one/crackme/61bbee6833c5d413767c9f20
//
// The main idea of the crackme is to generate 11 keys based on the length of
// the provided name and some hard-coded master key. This master key is kind
// of encrypted, so it's not visible (because it's not text) and can't be used
// if you just look in binary. The resulting keys are generated using
// xor, nothing fancy.
//
// There is a funny bug in the implementation, so you cannot use a name with
// spaces. The problem is that the author uses std::cin to read everything,
// but doesn't change the delimiter, so the part of the name after the
// space(s) becomes the key.

int main() {
  unsigned short masterKey[] = {0xFFB1, 0xFF98, 0xFFA0, 0xFF9C,
                                0xFFB8, 0xFF99, 0xFFA2, 0xFFE0,
                                0xFFE2, 0xFFB2, 0xFFFF };
  const int keySize = sizeof(masterKey) / sizeof(short);

  // "Decrypt" the master key
  for (int i = 0; i < keySize; ++i) {
    masterKey[i] = i ^ (~(masterKey[i] - i));
  }

  printf("Enter your name: ");

  char *buffer = NULL;
  size_t linecap = 0;

  size_t nameLength = getline(&buffer, &linecap, stdin);
  if (nameLength == -1) {
    printf("Can't read the name: %s\n", strerror(errno));
    goto exit;
  } else if (nameLength < 2) {
    printf("Name can't be empty\n");
    goto exit;
  } else if (strchr(buffer, ' ') != NULL) {
    printf("Name can't contain spaces\n");
    goto exit;
  }

  --nameLength; // ignore newline

  // Generate keys
  for (int i = 0; i < keySize; ++i) {
    printf("Key %d: %d\n", (i+1), masterKey[i] ^ (unsigned short) nameLength);
  }

exit:
  if (buffer != NULL)
    free (buffer);

  return 0;
}
