
# "BinCrypt Breaker" by Hack The Box

Wow, it's been a year since my last post. Long time no see, so to speak.

Anyway, I've finally managed to (hopefully) get back into reversing and I want to start with something not too difficult to refresh myself. HackTheBox has always been a great place for a good challenge and it seems to still be that way.

The "crypt" part of the problem's name is a bit of an exaggeration, but if you believe that `xor` and `swap` must be in any good crypto algorithm, then so be it. It all starts, of course, with good old `xor`: the `checker` binary "decrypts" `file.bin` using the complex `^0xAB` method and executes the resulting binary.

The decrypted thing is also not very complicated, but still does a little more than `xor`. The main goal of the whole algorithm is to transform the input string as follows:

- Swap eight characters in specific locations.
- Split the resulting string into two parts.
- Shuffle these parts and perform an `xor` operation on the six characters using different keys (`2` or `3` for the left and right parts respectively).
- Combine the two resulting strings and compare them with the value of `RV{r15]_vcP3o]L_tazmfSTaa3s0`. If they are equal, you have found the correct flag.

Given that this is a reversal exercise, you need to, well, reverse everything, including the steps you need to take to get the original flag out of that weird string. Specifically, you need to do something like this:

- Split the encrypted flag into two parts.
- `xor` the six characters in each part using the same keys, and shuffle the result using the reversed algorithm. "Reversed" in the sense that you need to do everything in reverse order, not that you need to fire up IDA or another disassembler.
- Swap eight characters and combine the resulting strings.

The `shuffle` algorithm uses a hard-coded array containing the indices of the characters in the string that need to be swapped: `[9, 12, 2, 10, 4, 1, 6, 3, 8, 5, 7, 11, 0, 13]`. The algorithm is quite simple:

```python
for i in range(len(shuffle_array)):  
    result[i] = flag[shuffle_array[i]]
```

To reverse it, you would need the same array, but the values ​​would be opposite, for example, `0` would be in ninth place, `1` in twelfth, etc.

Simple but cute for recharging forgotten skills.

The challenge can be found [here](https://app.hackthebox.com/challenges/BinCrypt%20Breaker).
