
# "Rega's Town" by Hack The Box

Rust is a special language in many ways. As a software developer for quite some time, I would say that the idea is good, but the implementation is, well, unique, so to speak. And I don't like it.

Trying to solve various problems written in Rust just confirms my opinion: the structure of the internals, the generated code, and other low-level things are, well, special. The usual complexity of such problems is in Rust itself, not in the logic that needs to be understood and reversed. So, no, I definitely don't like it.

This challenge from HTB is exactly what I expected. It primarily tests your knowledge of regular expressions and requires you to write a small script to brute-force the desired outcome. But to understand what it needs to do, you need to understand all the weird code that the Rust compiler generates. Luckily, the latest versions of IDA are very helpful.

In short, the task consists of two stages: first, it “filters” the input data based on 9 regular expressions, which are executed one after the other:

```bash
1: ^.{33}$
2: (?:^[\x48][\x54][\x42]).*
3: ^.{3}(\x7b).*(\x7d)$
4: ^[[:upper:]]{3}.[[:upper:]].{3}[[:upper:]].{3}[[:upper:]].{3}[[:upper:]].{4}[[:upper:]].{2}[[:upper:]].{3}[[:upper:]].{4}$
5: (?:.*\x5f.*)
6: (?:.[^0-9]*\d.*){5}
7: .{24}\x54.\x65.\x54.*
8: ^.{4}[X-Z]\d._[A]\D\d.................[[:upper:]][n-x]{2}[n|c].$
9: .{11}_T[h|7]\d_[[:upper:]]\dn[a-h]_[O]\d_[[:alpha:]]{3}_.{5}
```
As you can see, they already contain many answers to the question of what the flag should look like, as well as some of the characters it should contain.

The second step is to "check" the input. If you've reached the end of the generated code, consisting of various iterators, ranges, and iterator products, the basic idea is pretty simple: the unknown flag part (which is inside `HTB{}`) is split into 7 parts by the `_` character. To check that each part is correct, the characters in each part are multiplied, and the results are compared to a hard-coded constant. In other words, if one of the parts is `abc`, the method will do something like this to check it:

```python
ord('a') * ord('b') * ord('c') == some_hardcoded_const
```

Given that the previous 9 regular expressions only contain part of the answer, you will have to brute force the final result for each part. Which is not that hard since the set of regular expression rules significantly narrows the range of possible answers.

Have fun!

The challenge can be found [here](https://app.hackthebox.com/challenges/Rega's%2520Town).
