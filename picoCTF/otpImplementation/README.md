# "OTP Implementation" by picoCTF

What does OTP mean here? "One Time Password"? "Over The Top"? "One True Pairing"? In any case, this won’t help solve the problem, so let’s dig around using IDA as usual.

First, the crackme requires you to enter a key 100 characters long (omg). It then checks these characters using the following function:

```c
bool valid_char(char c)
{
  if ( c >= '0' && c <= '9' )
    return true;
  return c >= 'a' && c <= 'f';
}
```

this means you need to enter a long hexadecimal string or number. In case everything is OK, it then decodes this string using the nicely named `jumble` function, with the following (simplified) logic:

```c
for ( i = 0; i < input_size; ++i )
{
  char jumbled = jumble(input[i]);
  
  if ( i )
    result[i] = (result[i-1] + jumbled) % 16;
  else
    result[0] = jumbled % 16;
}
```

The crackme then converts this number back to printable characters and verifies that the resulting string is `jbgkfmgkknbiblpmibgkcneiedgokibmekffokamknbkhgnlhnajeefpekiefmjgeogjbflijnekebeokpgngjnfbimlkdjdjhan`. In other words, this algorithm transforms the input character `[0-9a-f]` using some function and maps the result to another set of 16 characters. If you check this long string that the result is compared to, you will see that it also contains exactly 16 unique characters:

```bash
$ echo "jbgkfmgkknbiblpmibgkcneiedgokibmekffokamknbkhgnlhnajeefpekiefmjgeogjbflijnekebeokpgngjnfbimlkdjdjhan" | grep -o . | sort | uniq | tr -d '\n'
abcdefghijklmnop
```

So the `jumble` function must somehow convert the input set `[0-9a-f]` to `[a..p]`. Let's try to understand what it does:

```c
int jumble(const int c) {  
  int result = c > 96 ? c + 9 : c;
  result = 2 * (result % 16);  
  
  return result > 15 ? result + 1 : result;  
}
```

Simplifying this author-and-compiler optimized code, the logic is quite simple:

- get the character index from the set. We know the character belongs to `[0-9a-f]`, so there is no need to check this again.
- multiply this index by 2, resulting in an even number `[0..30]`
- if this number is greater than 15, add 1

As a result, the first half of the set will be mapped to even numbers from 0 to 16, and the second half to odd numbers from 17 to 31.

Returning to the main algorithm, before storing the result of the calculation, the crackme performs the operation "%16", essentially converting this number into the index of the second set we saw:

```c
result[i] = (result[i-1] + jumbled) % 16;
```

So the actual mapping between the two character sets is

```
0123456789abcdef
acegikmobdfhjlnp
```

To reverse the algorithm and get the key back, we need to do the steps in reverse order as usual:

- convert the current character from the encoded key to its index
- solve a complex math problem: `(result[i-1] + X) % 16 = current_char_index`
- store the value of `(result[i-1]+X)%16` in `result[i]` for the next step
- append the "unjumbled" original character based on X value

By running this algorithm, we get the original key: `
c4a2db52092bc52e6ca24db26f9467cd43d0c636792cefb7639cd085a3768bee7549423e82b35e956abbc9246b2ffc3537ce`, and the crackme confirms that you're right:

```bash
$ ./otp c4a2db52092bc52e6ca24db26f9467cd43d0c636792cefb7639cd085a3768bee7549423e82b35e956abbc9246b2ffc3537ce
You got the key, congrats! Now xor it with the flag!
```

XORing 50-byte numbers in your head is no easy task, so to deal with big nums I called out the big guns in the form of the [GMP](https://gmplib.org/) library. The result is also a number, at least in GMP terms, so you'll have to export it as a raw byte array, which will be the flag.
