# Chapter 1

```
Run it: ./adventure hello
Step 1: './adventure', i.e. just argv[0]
Step 2: enter 'To the left'
```

# Chapter 2

There are two ways to arrive at "step 2 of chapter 2", but the first one seems to contain a bug that leads to a crash. Or it is one of the "wrong ways" that the crackme has. Anyway, here is the correct way:

```
Run it: ./adventure2 3222
Step 1: press Enter
Step 2: enter any digit, e.g. '0'
Step 3: press Enter
Step 4: enter '66', which is the first char of argv[1] + 0xF
Step 5: press Enter
Step 6: press Enter
```

Just in case, the wrong path is:

```
Run it: ./adventure2
Step 1: press Enter
Step 2: enter 'H'
Step 3: enter 'e'
Step 4: enter 'l'
Step 5: enter 'l'
Step 6: enter 'o'
Step 7: press Enter
Step 8: press Enter
```

You're now at the 'step 2 of chapter 2'.

```
Step 9: press Enter
Step 10: enter any digit, e.g. '0'
Step 11: press Enter
```

At this step, the crackme tries to compute the answer, but given that argv[1] doesn't exist, it will crash.

# Chapter 3

There are two "endings" of the story: with and without a "bonus prologue". The version without the bonus is more interesting from my point of view, because it allows you to play with the arguments.

So here's the version without the prologue:

```
Choose one of the characters from this string and count its position: 'what ?? you failed already ? Are you even trying ?'. Let's say it will be the first '?', position number 5 (counting from zero).

The program argument should be "N - 1" random characters, followed by the character you choose, ie: "1234?"

Run it: ./adventure3 1234?
Step 1: enter the first N-1 characters of argv[1]: '1234'
Step 2-8: press Enter
```

To get the prologue, just use N=3 for the previous algo:

```
Run it: ./advernture 12t
Step 1: enter '12'
Step 2-9: press Enter
```
