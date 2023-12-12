package com.github.itwaseasy;

import java.security.DigestException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Arrays;
import java.util.BitSet;
import java.util.stream.IntStream;
import org.paukov.combinatorics3.Generator;

public class Main {

  public static void main(String[] args) throws NoSuchAlgorithmException {
    /*
      mov rsi, rdi
      mov rdi, 0x7B3DC26F1
      call rsi
      ret
    */
    var toFind =
        new byte[] {
          0x48,
          (byte) 0x89,
          (byte) 0xfe,
          (byte) 0x48,
          (byte) 0xbf,
          (byte) 0xf1,
          0x26,
          (byte) 0xdc,
          (byte) 0xB3,
          0x07,
          0x00,
          0x00,
          0x00,
          (byte) 0xFF,
          (byte) 0xD6,
          (byte) 0xC3
        };

    var byteIndexes = new int[] {8, 2, 7, 1};

    var alphabet = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ".getBytes();
    var keyConstantParts = "GpLaMjEWpVOjnnmkRGiledp6Mvcezxls";

    final var keyVariablePartLength = 4;
    final var keyConstantPartLength = 8;
    final var keyPartLength = keyConstantPartLength + keyVariablePartLength;
    final var keyParts = 4;
    final var foundParts = new BitSet(keyParts);

    var sb = new StringBuilder();
    for (int i = 0; i < keyParts; ++i) {
      sb.repeat(alphabet[0], keyVariablePartLength);
      sb.append(
          keyConstantParts,
          keyConstantPartLength * i,
          keyConstantPartLength * i + keyConstantPartLength);
    }

    var key = sb.toString().getBytes();
    var md5 = MessageDigest.getInstance("MD5");
    var md5Output = new byte[md5.getDigestLength()];

    var alphabetIndexes = IntStream.rangeClosed(0, alphabet.length - 1).boxed().toList();

    Generator.permutation(alphabetIndexes).withRepetitions(keyParts).stream()
        .takeWhile(n -> foundParts.cardinality() < keyParts)
        .forEach(
            combination -> {
              for (int keyPartIndex = 0; keyPartIndex < keyParts; ++keyPartIndex) {
                if (foundParts.get(keyPartIndex)) {
                  continue;
                }

                for (int i = 0; i < combination.size(); ++i) {
                  key[keyPartLength * keyPartIndex + i] = alphabet[combination.get(i)];
                }

                try {
                  md5.reset();
                  md5.update(key, keyPartLength * keyPartIndex, keyPartLength);
                  md5.digest(md5Output, 0, md5Output.length);
                } catch (DigestException e) {
                  throw new RuntimeException(e);
                }

                if (Arrays.equals(
                    md5Output,
                    byteIndexes[keyPartIndex],
                    byteIndexes[keyPartIndex] + keyVariablePartLength,
                    toFind,
                    keyPartIndex * keyVariablePartLength,
                    keyPartIndex * keyVariablePartLength + keyVariablePartLength)) {
                  foundParts.set(keyPartIndex);
                }
              }
            });

    if (foundParts.cardinality() == keyParts) {
      System.out.print("found: ");
      IntStream.range(0, key.length - 1)
          .filter(i -> i % keyPartLength == 0)
          .forEach(n -> System.out.print(new String(key, n, keyVariablePartLength)));
      System.out.println();
    } else {
      System.out.println("not found");
    }
  }
}
