package body Search_Equal_Range_P with
  SPARK_Mode is
   
   function Search_Equal_Range
     (A : T_Arr;
      V : T) return Option_Pair is
      
      Result : Option_Pair := (Exists => False);
   begin
      
      if A'Length >0 then
	 Result :=(Exists => True, 
		   Lower => Search_Lower_Bound(A,V).Value,
		   Upper => Search_Upper_Bound(A,V).Value);
	 
	 pragma Assert(if Result.Upper <= A'Last then V < A(Result.Upper));
	 
	 else
	    null;
	    
	 end if;
	 
	 return Result;
      end Search_Equal_Range;

   end Search_Equal_Range_P;


	 
