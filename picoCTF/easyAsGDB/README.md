# "Easy as GDB" by picoCTF

I still don’t understand why the author compares it to GDB, since it won’t solve this out of the box, but whatever. This is one of the crackmes from picoCTF where you actually have to understand the algorithm and somehow reverse it, rather than just doing a string search exercise or running it under a debugger to see the answer. And this is wonderful, despite the fact that this is an ordinary xor with permutations.

The crackme asks you to enter the flag (wat?), then the buffer goes through several stages of permutations with xor and at the end the result is compared with encrypted flag. So, your goal is to enter the correct string, which after all the transformations will be equal to what the author expects. The steps of the algorithm is as follows:

1. The buffer is "decrypted" using xor with constants that are generated as follows:

```go
for i := 0x0ABCF00D; i < 0xDEADBEEF; i += 2075469 {  
  decryptBuffer(flag, i)  
}
```

where 2075469 is `((0xDEADBEEF % 0xABCF00D) >>6 ) ^ 0xBA`.

2. For each generated constant, the “decrypt” function is called. The interesting thing is that the constant is used byte-by-byte with each character from the buffer, i.e. for the constant `0xDEADBEEF` the top `0xDE` will be used with the first character, then `0xAD` with the second and so on. :

```go
func decryptBuffer(buffer []byte, xorConst int) {  
  xorBytes := []byte{  
    byte((xorConst >> 24) & 0xff),  
    byte((xorConst >> 16) & 0xff),  
    byte((xorConst >> 8) & 0xff),  
    byte(xorConst & 0xff),  
  }  
  
  for i := 0; i < len(buffer); i++ {  
    buffer[i] ^= xorBytes[i&3]  
  }
}
```

3. Then, after a round of transformations, the characters in the resulting buffer are swapped using this loop:

```go
func swapBytes(buffer []byte) {  
  for i := 1; ; i++ {  
    if i > len(buffer) {  
      break  
    }  
  
    for j := 0; ; j += i {  
      if j >= len(buffer)-i+1 {  
        break  
      }  
  
      buffer[j], buffer[j+i-1] = buffer[j+i-1], buffer[j]  
    }
  }
}
```

To compare the result with the encrypted flag, it is then converted back to the same buffer as in step 2. I don't know why, maybe to confuse the careless researcher, who knows.

Therefore, in order not to brute-force the solution, we need to reverse the algorithm:
1. Since the input buffer is restored back to the "stage 2" buffer, this means that the encrypted flag must be also restored first.
2. The flag then has to go through all the same xor transformations as our input buffer.

Well, and that's all you need.
