module VM.MType

import Data.Fin

import Elem

data MType = MWord64 | MBool | MUnit | MStruct (List MType) | MArray Nat MType

data TypeIndex : MType -> MType -> Type where
  ID : TypeIndex a a
  Trans : TypeIndex a b -> TypeIndex b c -> TypeIndex a c
  StructField : Elem members member -> TypeIndex (MStruct members) member
  ArrayIndex : Fin n -> TypeIndex (MArray n t) t
