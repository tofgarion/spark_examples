with Types; use Types;
with Heap_Predicates; use Heap_Predicates;
with Multiset_Predicates; use Multiset_Predicates;
with Upper_Bound_P; use Upper_Bound_P;
with Swap_Array_P; use Swap_Array_P;
with Shuffle_Lemmas; use Shuffle_Lemmas;
with Occ_P; use Occ_P;
with Heap_Lemmas; use Heap_Lemmas;
with Ada.Text_IO; use Ada.Text_IO;

package Pop_Heap_P with
  SPARK_Mode
is
   
   function Maximum_Heap_Child(H : Heap; P : Positive) return Option with
     Pre =>
       H.Size  in 2 .. Positive'Last-1
       and then P in 1 .. H.Size-1
       and then Is_Heap_Def(H),
     Contract_Cases =>
       (H.Size/2 < P => not Maximum_Heap_Child'Result.exists,
        Others => Maximum_Heap_Child'Result.Exists 
        and then Heap_Maximum_Child(H,P,Maximum_Heap_Child'Result.Value)
        and then Maximum_Heap_Child'Result.Value in P + 1 .. H.Size
        and then P = Heap_Parent(Maximum_Heap_Child'Result.Value));
   
     procedure Pop_Heap(H : in out Heap) with
     Pre => H.Size >=1
     and then H.A'Length >=1
     and then Is_Heap_Def(H),
     Post => Multiset_Unchanged(H.A,H'Old.A)
     and then H'Old.Size = H.Size+1
     and then Is_Heap_Def(H) 
     and then H.A(H.Size+1) = H'Old.A(1);
     --and then Max_Element_Def(H.A(1 .. H.Size+1),H.Size+1);
   
end Pop_Heap_P;
