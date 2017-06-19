-- implementation of Search

package body Search_P with
     Spark_Mode is

   function Search (A : T_Arr; B : T_Arr) return Option is
      Result : Option := (Exists => False, Value => 1);
   begin
      if (A'Length < B'Length or else B'Length = 0) then
         return Result;
      end if;

      for I in A'First .. A'Last + 1 - B'Length loop
         if (A (I .. I + B'Length - 1) = B) then
            Result.Exists := True;
            Result.Value  := I;

            return Result;
         end if;

         pragma Loop_Invariant ((not Has_Sub_Range_In_Prefix (A, I, B)));
         pragma Loop_Invariant (not Result.Exists);
         pragma Loop_Variant (Increases => I);

      end loop;

      return Result;
   end Search;

end Search_P;
