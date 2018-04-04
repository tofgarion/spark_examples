package body Pop_Heap_P with
  SPARK_Mode 
is
   
   
   function Maximum_Heap_Child(H : Heap; P : Positive) return Positive
   is
      Right, Left : Positive;
   begin
      if P <= H.Size/2 then
	 Right := 2*P+1;
	 Left := Right -1;
	 if Right <= H.Size then
	    return (if H.A(Right) <= H.A(Left) then Left else Right);
	 else
	       return Left;
	 end if;
      else
	 return H.Size+1;
      end if;
	 
   end Maximum_Heap_Child;

   procedure Pop_Heap(H : in out Heap) 
   is
      V : T := H.A(1);
      Hole : Positive := 1;
      Child : Positive;
      Interm : T_Arr(H.A'Range) := H.A with Ghost;
      Init : T_Arr(H.A'Range) := H.A with Ghost;
   begin
      if H.A(H.Size) < V then
	 pragma Assert(H.Size >=2);
	 Child := Maximum_Heap_Child(H,Hole);
	 
	 while Child < H.Size and then H.A(H.Size) < H.A(Child) loop
            H.A(Hole) := H.A(Child);
            pragma assert(Hole in Interm'Range and then Child in Interm'Range);
	    
	    Swap_Array(Interm,Hole,Child);
            --pragma Loop_Invariant(H.A'Length = Init'Length);
            pragma Assert(H.A'Last >= H.Size);
            pragma Assert(H.Size >=2);
            pragma Loop_Invariant(H.Size = H'Loop_Entry.Size);
	    pragma Loop_Invariant(Hole in 1 .. H.Size-1);
	    pragma Loop_Invariant(Hole < Child);
	    pragma Loop_Invariant(Is_Heap_Def(H));
	    pragma Loop_Invariant(if Hole /=1 then H.A(H.Size) < H.A(Heap_Parent(Hole)));
	    pragma Loop_Invariant(if Child < H.Size then Hole = Heap_Parent(Child));
	    pragma Loop_Invariant(Heap_Maximum_Child(H,Hole,Child));
	    pragma Loop_Invariant(Upper_Bound(H.A(1 .. H.Size),V));
            pragma Loop_Variant(Decreases => H.Size-Hole);
            pragma Loop_Invariant(Multiset_Unchanged(Init,Interm));
	    Hole := Child;
	    pragma Assert(Child < H.Size);
	    pragma Assert(Hole < H.Size);
	    Child := Maximum_Heap_Child(H,Hole);
	    end loop;
         
	 H.A(Hole) := H.A(H.Size);
         H.A(H.Size) := V;
         Swap_Array(Interm,Hole,H.Size);
	 
      end if;
      pragma Assert(Interm = H.A);
      H.Size := H.Size-1;
      pragma Assert(H.A'Length >= H.Size+1);
      pragma Assert(Upper_Bound(H.A(1 .. H.Size+1),H.A(H.Size+1)));
      pragma Assert(Is_Heap_Def(H));
	 end Pop_Heap;
end Pop_Heap_P;
