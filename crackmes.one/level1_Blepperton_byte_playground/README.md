### Cookie's Byte Playground by Blepperton

A rather fun way to generate a key is to use data from your own binary. Anyway, nothing special in this case, just some math to get a printable character. The whole algorithm can be described as follows:

```c
if (file_buffer[i] != 0) {
    unsigned modulo = file_buffer[i] % 57;
    unsigned modifier = (modulo - 10) > 6 ? 48 : 41;
    key[key_counter++] = (unsigned char) (modulo + modifier);
}
```

And yes, the key will be the same for everyone, because the crackme uses data from its own DOS header.