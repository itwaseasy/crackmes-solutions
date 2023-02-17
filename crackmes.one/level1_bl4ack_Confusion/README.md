### Confusion by bl4ack

The main idea of the crackme is to generate 11 keys based on the length of the provided name and some hard-coded master key. This master key is kind of encrypted, so it's not visible (well, because it's not text) and can't be used if you just look in binary. The resulting keys are generated using xor, nothing fancy.

There is a funny bug in the implementation, so you cannot use a name with spaces. The problem is that the author uses `std::cin` to read everything, but doesn't change the delimiter, so the part of the name after the space(s) becomes the key.