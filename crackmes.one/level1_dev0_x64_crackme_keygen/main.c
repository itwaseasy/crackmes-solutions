#include <stdio.h>
#include <stdlib.h>
#include <libgen.h>
#include <string.h>
#include <errno.h>

// https://crackmes.one/crackme/61c8b23a33c5d413767ca0de

int main(int argc, char *argv[]) {
  if (argc != 2) {
    printf("Usage: %s proc_maps_value\n", basename(argv[0]));
    exit(0);
  }

  printf("Enter your name: ");

  char *buffer = NULL;
  size_t linecap = 0;

  size_t name_length = getline(&buffer, &linecap, stdin);
  if (name_length == -1) {
    printf("Can't read the name: %s\n", strerror(errno));
    goto exit;
  } else if (name_length < 2) {
    printf("Name can't be empty\n");
    goto exit;
  }

  --name_length; // ignore newline

  size_t maps_hash_len = strlen(argv[1]);
  if (maps_hash_len > 15)
    maps_hash_len = 15;

  unsigned maps_hash = 0;
  for (size_t i = 0; i < maps_hash_len; ++i) {
    maps_hash += argv[1][i];
  }

  unsigned xor_value = 0;
  unsigned name_hash = 0;

  for (size_t i = 0; i < name_length; ++i) {
    *(unsigned char*)(&xor_value) = buffer[i];
    xor_value ^= maps_hash;
    name_hash += xor_value;
  }

  printf("Key: %d\n", name_hash);

exit:
  if (buffer != NULL)
    free(buffer);

  return 0;
}
