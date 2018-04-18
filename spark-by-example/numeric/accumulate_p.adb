package body Accumulate_P with
  SPARK_Mode is
   
   function Accumulate(A : T_Arr; Init : T) return T is
      Result : T := Init;
   begin
      for I in A'Range loop
	 
	 pragma Assert(Acc_Def(A(A'First .. I-1),Init) in T);
	 pragma Assert(Acc_Def(A(A'First .. I),Init) in T);
	 Result := Result + A(I);
	 pragma Loop_Invariant(Result in T);
	 pragma Loop_Invariant(Result = Acc_Def(A(A'First .. I),Init)); 
	 
      end loop;
      return Result;
   end Accumulate;
end Accumulate_P;
