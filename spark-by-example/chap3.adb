package body Chap3 with
     Spark_Mode is

   -----------
   -- Equal --
   -----------

   function Equal (A : T_Arr; B : T_Arr; Size : Natural) return Boolean is
   begin
      --  Note: here, we provide a full implementation of the equal
      --  operator in place of a simple array comparison

      for J in 0 .. Size - 1 loop
         if A (A'First + J) /= B (B'First + J) then
            return False;
         end if;

         pragma Loop_Invariant
           (for all K in 0 .. J => A (A'First + K) = B (B'First + K));
         pragma Loop_Variant
           (Increases => J);
      end loop;

      return True;
   end Equal;

   --------------
   -- Mismatch --
   --------------

   function Mismatch (A : T_Arr; B : T_Arr; Size : Natural) return Natural is
   begin
      for J in 0 .. Size - 1 loop
         if A (A'First + J) /= B (B'First + J) then
            return J;
         end if;

         pragma Loop_Invariant
           (for all K in 0 .. J => A (A'First + K) = B (B'First + K));
         pragma Loop_Variant
           (Increases => J);
      end loop;

      return Size;
   end Mismatch;

   ----------
   -- Find --
   ----------

   function Find (A : T_Arr; Size : Natural; Val : T) return Natural is
   begin
      for J in 0 .. Size - 1 loop
         if A (A'First + J) = Val then
            return J;
         end if;

         pragma Loop_Invariant
           (for all K in 0 .. J => A (A'First + K) /= Val);
         pragma Loop_Variant
           (Increases => J);
      end loop;

      return Size;
   end Find;

   --------------------
   --  Find_First_Of --
   --------------------

   function Find_First_Of
     (A : T_Arr;
      M : Natural;
      B : T_Arr;
      N : Natural) return Natural
   is
   begin
      for J in 0 .. M - 1 loop
         if Find (B, N, A (A'First + J)) < N then
            return J;
         end if;

         pragma Loop_Invariant
           (not Has_Value_Of(A, J + 1, B, N));
         pragma Loop_Variant
           (Increases => J);
      end loop;

      return M;
   end Find_First_Of;

end Chap3;
