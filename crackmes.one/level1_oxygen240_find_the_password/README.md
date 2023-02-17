### find_the_password by oxygen240

Simply put, the algorithm calculates a hash value using a manually created hash function and checks it against a hard-coded value. It is impossible to recover the original key (if the author had one), so I chose the simplest solution - brute force, given that the algorithm is trivial and will cause many collisions.

These are the all (printable) options for key_length = 4:

```
FOUND: ':S&7'
FOUND: '`\@7'
FOUND: ':Rf7'
FOUND: ':S%w'
FOUND: '`\?w'
FOUND: ':Rew'
```

And some examples for key_length = 5:

```
FOUND: 'CQ: 7'
FOUND: '|_A 7'
FOUND: '0LM 7'
FOUND: 'iZT 7'
FOUND: 'VUg 7'
FOUND: 'CPz 7'
FOUND: 'FP)"7'
FOUND: '3K<"7'
FOUND: 'lYC"7'
FOUND: ' FO"7'
FOUND: 'YTV"7'
```