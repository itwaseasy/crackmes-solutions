import java.util.Arrays;
import java.util.stream.Collectors;

public class Verify2 {
   private static boolean compareByte(Byte var0, Short var1) {
      System.out.println(var0 + " == " + var1);
      return var0 == var1;
   }

   private static String complexSort(String var0, Boolean var1) {
      Object[] var2 = var0.chars().mapToObj(var0x -> (char)var0x).toArray();
      if (var1) {
         Arrays.sort(var2);
      }

      return Arrays.stream(var2).map(Object::toString).collect(Collectors.joining());
   }

   private static Boolean verifyPassword(String var0, String var1) {
      return var0.equals(var1);
   }

   public static void main(String[] var0) {
      if (var0 != null && var0.length == 1) {
         String var1 = var0[0];
         if (var1 == null) {
            System.out.println("Source may not be null");
            System.exit(1);
         } else if (var1.length() % 2 != 0) {
            System.out.println("Length must be even");
            System.exit(1);
         } else {
            System.out.println("Verifying user has authorization...");

            for(int var2 = 0; var2 < var1.length() / 2; ++var2) {
               String var3 = var1.substring(var2 * 2, var2 * 2 + 2);
               String var4 = complexSort(var3, true);
               String var5 = complexSort("Cr1KD5mk0_uUzQYifaGVqlN2B3wvpgPtSx6Odo{8hjJLHy9IXb4RnWZ}TAFEsMce7", false);
               if (var4.equals(var5.substring(var2 * 2, var2 * 2 + 2))) {
                  System.exit(var2 + 3);
               }
            }

            if (!verifyPassword(var1, "Tinfoil")) {
               System.out.println("Please enter the correct password");
               System.exit(2);
            }
         }
      } else {
         System.out.println("Verifying requires source");
         System.exit(1);
      }
   }
}

