
# "Wayback" by Hack The Box

This is a basic exercise based on the `srand` + `rand` pair and the programming school knowledge that the return value of the latter depends on the first function. The only small problem here is that there is no logic to reveal the original flag, you need to brute-force the solution.

There are two files in the task: the one that generates a password based on 3 rules, and a Python script that decrypts a hardcoded binary blob containing a flag. Your task is to find the correct password that will decrypt this blob.

The logic behind the password generation is simple. First, it prepares a list of characters from which the password will be generated based on three questions it asks: the length of the password and whether to include numbers or "symbols". It then generates the password using the following code:

```python
libc.srand(time.time())
for _ in range(password_length):
	key += character_set[libc.rand() % len(character_set)]
```

The main question is, what was the Unix time when the password was generated? Fortunately, the author of the challenge is very kind and tells the following:

- "password is 20 characters long, and consisted of only alphanumeric characters and symbols"
- "between the 10th and the 11th of December 2013"

Basically, that's all we need to brute force it using code like this:

```python
t = time.strptime("10.12.2013 00:00:00 UTC", "%d.%m.%Y %H:%M:%S %Z")  
seconds = time.mktime(t)

for _ in range(two_days):  
    libc.srand(srand_value)
      
    key = ""  
    for _ in range(password_length):  
        key += character_set[libc.rand() % len(character_set)]  
  
    decrypted_message = decrypt_message(encrypted_message, key.encode())  
    if decrypted_message :  
        print(f"Decrypted message: {decrypted_message}")  
        break  
  
  seconds += 1  
  t = time.gmtime(seconds)
```

The logic for generating `srand_value` can be found by disassembling the binary, it is not very complicated.

There are a few points worth noting:

- The binary is compiled using one of the latest `gcc`, so it didn't work under my Debian 12, for example.
- The logic that generates `srand_value` uses int32, so pay attention to this when porting the algorithm to Python or another language.
- BSD `rand` is not the same as glibc `rand`, and both will return different values ​​given the same `srand` input value. Be aware of this if you try to brute-force it on, say, macOS.

The challenge can be found [here](https://app.hackthebox.com/challenges/Wayback).
