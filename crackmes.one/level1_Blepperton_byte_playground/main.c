#include <sys/stat.h>
#include <stdio.h>
#include <libgen.h>
#include <errno.h>
#include <string.h>

#define KEY_LENGTH 20
#define READ_BLOCK_SIZE 256

// https://crackmes.one/crackme/61d6402033c5d413767ca325

int main(int argc, char *argv[]) {
  if (argc != 2) {
    printf("Usage: %s path_to_crackme\n", basename(argv[0]));
    return 0;
  }

  struct stat st;
  if (stat(argv[1], &st) != 0) {
    printf("Can't get crackme file size: %s\n", strerror(errno));
    return 1;
  } else if (st.st_size < KEY_LENGTH) {
    printf("Wrong crackme: file size must be at least %d\n", KEY_LENGTH);
    return 1;
  }

  FILE *f = fopen(argv[1], "rb");
  if (f == NULL) {
    printf("Can't open file: %s\n", strerror(errno));
    return 1;
  }

  unsigned char buffer[READ_BLOCK_SIZE];
  unsigned char key[KEY_LENGTH + 1];
  key[KEY_LENGTH] = 0;

  size_t read_size = 0;
  size_t key_counter = 0;

  while((read_size = fread(buffer, 1, READ_BLOCK_SIZE, f)) > 0 && key_counter < KEY_LENGTH) {
    for (size_t i = 0; i < read_size && key_counter < KEY_LENGTH; ++i) {
      if (buffer[i] != 0) {
        unsigned modulo = buffer[i] % 57;
        unsigned modifier = (modulo - 10) > 6 ? 48 : 41;
        key[key_counter++] = (unsigned char) (modulo + modifier);
      }
    }
  }

  fclose(f);

  if (key_counter != KEY_LENGTH) {
    printf("Wrong crackme: unable to read enough data to generate key\n");
    return 1;
  }

  printf("Key: %s\n", key);

  return 0;
}
