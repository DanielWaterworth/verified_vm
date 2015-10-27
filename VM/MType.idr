module VM.MType

import Data.Fin
import Data.Vect

import Always
import Elem

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
