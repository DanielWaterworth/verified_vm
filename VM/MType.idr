module VM.MType

import Data.Fin
import Data.Vect

import Always
import Elem

%default total

data MType =
  MWord64 |
  MBool |
  MUnit |
  MStruct (List MType) |
  MUnion (List MType) |
  MArray Nat MType

data TypeIndex : MType -> MType -> Type where
  ID : TypeIndex a a
  Trans : TypeIndex a b -> TypeIndex b c -> TypeIndex a c
  StructField : Elem member members -> TypeIndex (MStruct members) member
  ArrayIndex : Fin n -> TypeIndex (MArray n t) t

data MValue : MType -> Type where
  VWord64 : Bits64 -> MValue MWord64
  VBool : Bool -> MValue MBool
  VUnit : MValue MUnit
  VStruct : Always MValue types -> MValue (MStruct types)
  VUnion : MValue ty -> Elem ty types -> MValue (MUnion types)
  VArray : Vect n (MValue ty) -> MValue (MArray n ty)

view : TypeIndex a b -> MValue a -> MValue b
view ID x = x
view (Trans f g) x = view g (view f x)
view (StructField elem) (VStruct elements) = index elem elements
view (ArrayIndex n) (VArray elements) = index n elements

set : TypeIndex a b -> MValue b -> MValue a -> MValue a
set ID x _ = x
set (Trans f g) x y = set f (set g x (view f y)) y
set (StructField elem) x (VStruct elements) = VStruct (replaceAt elem x elements)
set (ArrayIndex n) x (VArray elements) = VArray (replaceAt n x elements)
