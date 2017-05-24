-- a specification of Find_First_Of

with Types; use Types;
with Has_Value;
with Has_Value_Of;

package Find_First_Of with
     Spark_Mode is

   function Find_First_Of (A : T_Arr; B : T_Arr) return Option with
      Contract_Cases =>
      (Has_Value_Of.Has_Value_Of (A, B) =>
         (Find_First_Of'Result.Exists = True)
         and then (Has_Value.Has_Value (B, A (Find_First_Of'Result.Value)))
         and then
         (not Has_Value_Of.Has_Value_Of
            (A (A'First .. Find_First_Of'Result.Value - 1),
             B)),
       others => Find_First_Of'Result.Exists = False);

end Find_First_Of;
