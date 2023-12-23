# "Powershelly" by picoCTF

When I first saw this crackme, I thought "WAT? Powershell?". But it turned out that this was an exciting task! So thank you, "SARA" from picoCTF, whoever you are.

In short, you are given a PowerShell script that converts some data from the missing input file, and a final output file consisting of a long list of int64 numbers. Your goal is to reverse the algorithm so that it generates an input file from what is available. After this, the resulting data must be decoded, since there is no flag in the source file. Let's start from the beginning and analyze the algorithm in parts.

Skipping the code that is responsible for reading the file, it then checks for the validity of the input data. In addition, there is a small arithmetic nearby that calculates some result from magic numbers, which serves as a check too:

```powershell
$out = Get-Content -Path $input

$total = 264
$t = ($total + 1) * 5
$numLength = ($total * 30 ) + $t
if ($out.Length -gt 5 -or $enc.count -ne $numLength)
{
  Write-Output "Wrong format 5"
  Exit
}
```
I'm not a PowerShell developer, so I need to read the API description on the Microsoft website first. It turned out that the result of the `Get-Content cmdlet`, as they call it, is an array of strings. From this part, we can conclude that the input file consists of 5 lines with a total size of 9245 bytes, which means that each line has 1849 characters if all lines are the same length. The next check is:

```powershell
  for($i=0; $i -lt $enc.count ; $i++)
  {
    if (($enc[$i] -ne 49) -and ($enc[$i] -ne 48) -and ($enc[$i] -ne 10) -and ($enc[$i] -ne 13) -and ($enc[$i] -ne 32))
    {
      Write-Output "Wrong format 1/0/"
      Exit
    }
  }
```
Okay, each line only contains the characters "0" or "1", they are somehow separated by a space and "\r\n" at the end. Next comes the logic that reads the data from the file with some additional checking. I've simplified the logic a bit here, but the general idea is this:

```powershell
$blocks = @{}

for ($i=0; $i -lt $out.Length ; $i++)
{
  $r = $out[$i].Split(" ")

  for ($j=0; $j -lt $r.Length ; $j++)
  {
    if ($r[$j].Length -ne 6)
    {
      Write-Output "Wrong Format 6" $r[$j].Length
      Exit
    }
    $blocks[$j] += $r[$j]
  }
}
```

What's going on here, in words:

- split each line of the input file by space
- each element in this split must contain exactly 6 characters
- add the elements to the hash map like this: `elements[element_index_in_line] += element` where "+" is the concatenation operator

It means that if the input file contains a "table" of elements, each "block" is a column, i.e.:

```
input file:
	a b c d
	h i j k
	o p q r

blocks:
	blocks[0] = aho
	blocks[1] = bip
	blocks[2] = cjq
	blocks[3] = dkr
```

The last question we need to answer before diving into the conversion logic is the number of blocks in the input file, as this is important to know in the next steps. Returning to our previous math exercise, the input file consists of 5 lines with a total length of 9245 bytes, meaning each line contains 1849 bytes. Now we know that each element in a line is 6 characters long, separated by a space and EOL at the end. Let's assume that there is also a space after the last element, so it should be something like this

`[1849 (total in line) - 2 ("\r\n")] / 7 (element + space) = 263,857142857142857`

which is wrong. The problem is that the author is confusing us (probably): the output file has the character "\n" as the EOL character, and not "\r\n", which is used by default in Windows:

```bash
$ xxd -l 25 -c 19 output.txt
00000000: 3837 3930 3539 3534 3732 3235 3630 3032 3231 0a  879059547225600221.
00000013: 3731 3739 3334                                   717934
```

Assuming the input file is the same format, we now have

`[1849 (total in line) - 1 ("\n")] / 7 (element + space) = 264`

Great! The answer to this question was in the sixth line of this script, but still.

Before the actual logic, two additional steps generate "seeds" and "randoms". Both of these are simply a set of constants that the algorithm uses (so there is no randomness here):

```powershell
$seeds = @()
$randoms = @()

for ($i=1; $i -lt ($blocks.count +1); $i++)
{
  $seeds += ($i * 127) % 500
  $randoms += ((($i * 327) % 681 ) + 344) % 313
}
```

Now, the fun part is that transforms the input file and generates the output. I split it into two parts because the most complex logic is in the Scramble function which I describe next. To generate the output file, the crackme iterates over the set of blocks generated on the previous steps, "scramble" it resulting in an int64 number, and XORs it:

```powershell
$output_file = @()
for ($i=0; $i -lt $blocks.count ; $i++)
{
  $fun = Scramble -block $blocks[$i] -seed $seeds[$i]
  $result = $fun -bxor $result -bxor $randoms[$i]
  $output_file += $result
}
```

So there is nothing special here and the original number can be easily reverted. To complicate this simplicity, the author uses the `Scramble` function, which performs several steps:

- concatenates all the elements of a block into one line (remember that a block is an array of elements, each 6 characters long) and calls it `raw`.
- creates an array of "markers" which I'll describe shortly.
- for each character in the resulting string, it generates an index like this: `index = (i*seed) % raw.length`
- checks the "markers" array: if the generated index value has already been processed, it tries to find the next unprocessed character, wrapping around the index if necessary.
- if current `raw` character is '1', substitute a marker at the generated index with "11", otherwise with "00".
- when all characters have been processed, the values from the "markers" array are concatenated and an int64 is generated from that bitstring.

In other words, it "randomly" selects an index in the "markers" array and writes "11" there if the current character in the `raw` string is '1', otherwise it writes "00". I've renamed the variables from the original script to make it clearer:

```powershell
function Scramble {
    param (
        $block,
        $seed
    )
    
    $raw = [system.String]::Join("", $block)
    $markers = "? " * $raw.Length
    $markers = $markers.Split(" ")
    
    for ($i=0; $i -lt $raw.Length ; $i++)
    {
      # generate an index
      $index = ($i * $seed) % $raw.Length
      $character = $markers[$index]
      
      # find unprocessed field
      while ($character -ne "?")
      {
        $index = ($index + 1) % $raw.Length
        $character = $markers[$index]
      }
      
      # convert a character
      if ($raw[$i] -eq "1" )
      {
        $convertedCharacter = "11"
      }
      else
      {
        $convertedCharacter = "00"
      }
      
      # write converted value back to the markers array
      $markers[$index] = $convertedCharacter
    }
    
    $result = [system.String]::Join("", $markers)
    $result_int64 = [convert]::ToInt64($result, 2)
    return $result_int64
}
```

Now, to reverse this algorithm and restore the original file, we need to start from the end:

-   generate "seeds" and "randoms": they're the same in both cases
-   for each number in the output file, we need to restore the int64 that the original `Scramble` function returned and also restored the `result` variable since it is also used in xor
-   decrypt this recovered number and get the block back
-   split this block into 5 parts (6 characters each) and add each part to the corresponding line

In some golang-like pseudocode, it would look like this:

```go
result := 0

for numberFromFile := range eachNumberFromFile() {  
  revertedNumber := numberFromFile ^ result ^ randoms[i]  
  result = revertedNumber ^ result ^ randoms[i]  
  
  block := unscramble(revertedNumber, seeds[i])  

  // split block and append to lines
  parts := splitInFiveParts(block)
  for i := 0; i < 5; i++ {
	  line[i] += part[i]
  }
}
```

The "unscramble" function is again a bit tricky but follows the same idea by doing the steps in reverse order:

- create an array of "markers"
- convert `revertedNumber` to an array of bits.
- generate an index using the same rules with already processed fields.
- if two characters starting at this index are "11", append "1" to the result, otherwise append "0". Again, we need to *append* the result because the original `raw` string is processed sequentially.

```go
bits := convertNumberToBitstring(number)
markers := make([]byte, len(bits)/2)  
result := make([]byte, len(bits)/2)  
  
for i := range markers {  
    markers[i] = '?'  
}  
  
for i := 0; i <= len(result); i++ {
    index := (i * seed) % len(result)

	// find unprocessed field index
    for markers[index] != '?' {  
        index++  
    }  
  
    char := '?'
    // check two chars starting from this index
    if getTwoChars(bits, index) == "11" {
        char = '1'
    } else {
        char = '0'
    }
    
    // mark field as processed
    markers[index] = char  

    // append converted char to the result
    result[i] = char
}  
  
return string(result)  
```

So far so good: if we put it all together and run it, we get the original input file. The only thing is that there is no flag inside. For instance, the part of the first line looks like this:

```
100001 110011 110011 110011 100001 100001 100001 100001 100001 110011 110011
```

which correlates with what we originally assumed. Each line consists of elements separated by space, zeros, and ones, and so on. How then to restore the flag?

If you look closely at each line, you will notice that there are only two repeating elements in each of them. For example, in the first line, these are "100001", "110011", in the second “001100”, “100011” and so on. Which is somehow similar to binary encoding, that is, each element means either 0 or 1. For example, if in the first line "100001" is 0, and "110011" is 1, then it will turn out

```
01110000011
```
Assuming that the flag must be in ASCII format, this means that this bit string can be converted to ASCII text if you split it into bytes. This guess is also confirmed by arithmetic: if there are 264 elements in a line, each of which represents a bit, then the resulting text should be 264/8 = 33 characters long. So if we do this conversion and try to print it, we will get the answer:

```
line 1: picoCTF{2018highw@y_2_pow3r$hel!}
line 2: picoCTF{2018highw@y_2_pow3r"hel!}
line 3: picoCTF{2018highw@y_2_pow3r$hel!}
line 4: picoCTF{2018highw@y_2_pow3r$hel!}
line 5: picoCTF{2018highw@y_2_pow3r$hel!}
```

The funny thing is that there is a typo in the second line. Or is this a bug in my algorithm?