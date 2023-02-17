#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>

// https://crackmes.one/crackme/61bbee6833c5d413767c9f20

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
