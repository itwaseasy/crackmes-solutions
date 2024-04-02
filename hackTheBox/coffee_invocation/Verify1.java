public class Verify1 {
   private static boolean compareByte(Byte var0, Short var1) {
      return var0 == var1;
   }

   public static void main(String[] var0) {
      if (var0 != null && var0.length == 2) {
         String var1 = var0[0];
         String var2 = var0[1];
         if (var1 != null && var2 != null) {
            if (var1.length() != var2.length()) {
               System.out.println("Source and Target don't have the same length");
               System.exit(2);
            } else {
               System.out.println("Verifying user is of terrestrial origin...");

               for(int var3 = 0; var3 < var1.length(); ++var3) {
                  if (!compareByte((byte)var1.charAt(var3), (short)((byte)var2.charAt(var3)))) {
                     System.out.println("=> User might be an alien!!!");
                     System.exit(3);
                     return;
                  }
               }
            }
         } else {
            System.out.println("Source and Target may not be null");
            System.exit(2);
         }
      } else {
         System.out.println("Verifying requires source and target");
         System.exit(1);
      }
   }
}

