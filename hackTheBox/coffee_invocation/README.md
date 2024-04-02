
# "Coffee Invocation" by Hack The Box

The great thing about all the challenges I've seen on Hack The Box is that almost all of them have some crazy stuff that forces you to do a lot of research and experimentation. It's amazing because that's how people like me learn new things. Thank you for that!

This task is a C program running Java code inside of it, which is something that doesn't happen very often in real life. A common use of [JNI](https://docs.oracle.com/javase/8/docs/technotes/guides/jni/spec/jniTOC.html) that I have seen is to implement an API used from Java. But this example is a little different: the program itself runs the Java interpreter and uses JNI to configure and control the flow of the program, rather than the other way around.

The author probably loves coffee too much, because it's all about the coffee. It "emulates" a coffee machine and even prints a nice ASCII image of different coffee flavors :) To run the real challenge, you need to select a number `3` from the menu called `[REDACTED]`. But before that, you need to specify the correct flag as the first argument of the program, i.e.

```bash
$ ./coffee_invocation <FLAG_HERE>
```
Digging deeper into the code, I discovered that the crackme executes two functions, passing `argv[1]` as a parameter (in addition to `JNIEnv*`), and if they both return 0, a flag is printed. The sad thing is that the "flag" in this case is whatever you specified in the command line argument without any changes, so there's no fancy "XOR encryption" here.

I called these functions `verify1` and `verify2`, so let's start with the first one. Summarizing the JNI calls, it does the following steps:

1. Add a shutdown hook so that calling `System.exit()` from Java will call a predefined C function.
2. Override what the `Byte.valueOf()` and `Short.valueOf()` methods return. More on this a bit later.
3. [Define a class](https://docs.oracle.com/javase/8/docs/technotes/guides/jni/spec/functions.html#DefineClass) from a byte buffer hardcoded in the binary (which is just a compiled Java class).
4. Create an array of two strings: the first is a substring of length `0x1A` from `argv[1]`, which is the first part of the flag. The second is a hard-coded set of characters: `~PL{A;PL{?;:=|PIC{HzP:A;~x`.
5. Call the `main` method of the defined class and pass this array as an argument.
6. Revert the overriding made in step 2.

The shutdown hook is trivial: it sets a global variable to the result of the `exit` function, so that this global variable can be returned later as a result of the `verify1` function.

The override logic is quite interesting because the JNI code changes the behavior of the Java code, which is an interesting trick in itself. First of all, the code calls a function that returns a table by ID. Thus, for reassignment "bytes" values the identifier is `1`, for "short" it is `2`, and for the original table it is `0`. To change the return value of the `valueOf` method, the JNI code does the following:

```java
for (int i = 0; i < 256; ++i) {
	Byte.valueOf(i).value = overriding_table[i];
}
```

The same idea works for the `Short` class. Why does this work, just in case? Simply because both classes have an internal cache of static objects, so every time you call `Byte.valueOf(i)` or `Short.valueOf(i)` where `i` is between `-128` and `127` , the cached object is returned (at least that's how it works in OpenJDK). The JNI code modifies the "private" field of these static objects that the JDK created in advance. Nice and easy!

Now, the remaining steps are defining the class and calling its static method. The binary blob that the `DefineClass` function uses is easily identified by the famous `CAFEBABE` magic bytes in the header. You can use any of the existing decompilers to get the source code back, or just read it [here](https://github.com/itwaseasy/crackmes-solutions/tree/master/hackTheBox/coffee_invocation).

The only thing the `main` method of the `Verify1` class does is compare two strings passed as parameters. But the code looks a bit strange:

```java
private static boolean compareByte(Byte var0, Short var1) {  
  return var0 == var1;  
}
public static void main(String[] var0) {
	// init code skipped
	for(int var3 = 0; var3 < var1.length(); ++var3) {  
	  if (!compareByte((byte)var1.charAt(var3), (short)((byte)var2.charAt(var3)))) {  
	    System.out.println("=> User might be an alien!!!");  
	    System.exit(3);  
	    return;  
	  }  
	}
}
```

So it calls the `compareByte` method, which triggers calls to the `Byte.valueOf` and `Short.valueOf` methods. In doing so, the code indirectly uses modified tables that the JNI code has initialized in advance. In other words, it doesn't actually compare the two original strings, but rather the modified versions of them. So I'm guessing that the line `~PL{A;PL{?;:=|PIC{HzP:A;~x` is a modified version of the string containing the flag, and the question is how to revert it.

After analyzing both mapping tables, I discovered the following pattern:

- each value in the `byte` table has moved `0x51` to the right, i.e. `(i + 0x51) & 0xFF`
- the values in the `short` table are arranged in descending order, i.e. `(~i + 1) & 0xFF`

In this case, to return the first part of the flag, we need to do the following:

- map each character back to the original encoding
- map the original character from the previous step using the `bytes` table

The second step is necessary because when the crackme reads the input string, it transforms it using a table of "bytes", so we need to sort of "reverse" this operation. The following code can be used to get the first part of the flag:

```java
for (var encodedChar : flag_firstPart) {  
  var shortRemap = (~encodedChar + 1) & 0xFF;  
  var byteRemap = (shortRemap - 0x51) & 0xFF;  
  
  System.out.print((char) byteRemap);  
}
```

This wasn't difficult, so let's move on to the second part of the flag and the `verify2` function. 

The steps there are almost the same:

1. Add a shutdown hook so that calling `System.exit()` from Java will call a predefined C function.
2. Override what the `Character.valueOf()` method returns. More on this a bit later.
3. Change the value of the `Boolean.TRUE` and `Boolean.FALSE` fields so that the first value becomes `false` and the second value becomes `true`.
4. [Define a class](https://docs.oracle.com/javase/8/docs/technotes/guides/jni/spec/functions.html#DefineClass) from a byte buffer hardcoded in the binary that will become a `Verify2` class.
5. Call the `main` method of the defined class and pass the second part of the flag to it.
6. Revert the overriding for `Boolean` class.

Now the shutdown hook looks a bit different. In addition to storing the status of the result in a global variable (which will be the result of this function), it has the following logic: if the return value is greater than `2`, the hook will again reassign `Character.valueOf`, where is the ID of the table being used - `status_code + 1`. In other words, every time Java calls `System.exit(N)` where N > 2, a new table will be applied.

If you check how the table is selected, you will see that there are 13 tables in total.

This is how the main logic of the `Verify2` class looks like:

```java
for(int var2 = 0; var2 < var1.length() / 2; ++var2) {  
  String var3 = var1.substring(var2 * 2, var2 * 2 + 2);  
  String var4 = complexSort(var3, true);  
  String var5 = complexSort("Cr1KD5mk0_uUzQYifaGVqlN2B3wvpgPtSx6Odo{8hjJLHy9IXb4RnWZ}TAFEsMce7", false);  
  if (var4.equals(var5.substring(var2 * 2, var2 * 2 + 2))) {  
    // This will trigger remapping
    System.exit(var2 + 3);  
  }  
}
```

First of all, it looks like the tables will switch every two characters encoded. Also, given that the values of `true` and `false` are changed by the JNI code, the Java code will not sort our input, it will sort the constant string. Remember that the `Characted.valueOf` method is also modified by JNI code, so this constant string will look different every time the tables are switched.

Luckily for us, sorting a list of ASCII characters (no matter what order they are in after overriding) will always produce the same result: `0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_abcdefghijklmnopqrstuvwxyz{}`. Given that the second part  of the flag has length `0x1A`, the only thing we need to do is match every two characters of this string using different tables: `0123456789ABCDEFGHIJKLMNOP`.

Unfortunately, I don't see the connection between how the characters are laid out in the tables, so I had to copy them all into my code. Here's how to decipher the second part of the flag:

```java
var s = "0123456789ABCDEFGHIJKLMNOP";

for (int i = 0; i < s.length(); ++i) {  
  var mappingTable = characterTables[i/2];  
  
  for (int j = 0; j < mapping.length; ++j) {  
    if (mapping[j] == s.charAt(i)) {  
      System.out.print((char) j);  
    }  
  }
}
```

The challenge can be found [here](https://app.hackthebox.com/challenges/Coffee%2520Invocation) and decompiled code [here](https://github.com/itwaseasy/crackmes-solutions/tree/master/hackTheBox/coffee_invocation).
