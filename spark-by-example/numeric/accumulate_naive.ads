with Types;         use Types;
with Acc_Def_Naive; use Acc_Def_Naive;

package Accumulate_Naive with
     Spark_Mode is

   function Accumulate_Naive (A : T_Arr; Init : T) return T with
      Pre  => (for all I in A'Range => Acc_Def (A (A'First .. I), Init) in T),
      Post => Accumulate_Naive'Result = Acc_Def (A, Init);

end Accumulate_Naive;
