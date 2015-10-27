module main

import Elem

data MType = MWord64 | MBool | MUnit | MStruct (List MType) | MArray Nat MType

data TypeIndex : MType -> MType -> Type where
  ID : TypeIndex a a
  Trans : TypeIndex a b -> TypeIndex b c -> TypeIndex a c
  StructField : Elem members member -> TypeIndex (MStruct members) member
  ArrayIndex : Fin n -> TypeIndex (MArray n t) t

data Inputs : (MType -> Type) -> List MType -> Type where
  Nil : Inputs ref []
  (::) : ref ty -> Inputs ref l -> Inputs ref (ty :: l)

data Instruction : (MType -> Type) -> (List MType -> MType -> Type) -> MType -> Type where
  Call : fun inputs output -> Inputs ref inputs -> Instruction ref fun output

  Add : ref MWord64 -> ref MWord64 -> Instruction ref fun MWord64
  Sub : ref MWord64 -> ref MWord64 -> Instruction ref fun MWord64
  Lt : ref MWord64 -> ref MWord64 -> Instruction ref fun MBool

  Or : ref MBool -> ref MBool -> Instruction ref fun MBool
  And : ref MBool -> ref MBool -> Instruction ref fun MBool
  Xor : ref MBool -> ref MBool -> Instruction ref fun MBool
  Not : ref MBool -> Instruction ref fun MBool

data IntroduceRef : MType -> (MType -> Type) -> MType -> Type where
  Introduced : IntroduceRef introduced f introduced
  Elevate : f ty -> IntroducedRef introduced f ty

data Terminator : (MType -> Type) -> (List MType -> MType -> Type) -> MType -> Type where
  Condition : ref MBool -> fun inputs1 rettype -> Inputs ref inputs1 -> fun inputs2 rettype -> Inputs ref inputs2 -> Terminator ref fun rettype
  TailCall : fun inputs rettype -> Inputs ref inputs -> Terminator ref fun rettype
  Return : ref rettype -> Terminator ref fun rettype

data InstructionSequence : (MType -> Type) -> (List MType -> MType -> Type) -> MType -> Type where
  Nil : Terminator ref fun rettype -> InstructionSequence ref fun rettype
  (::) : Instruction ref fun output -> InstructionSequence (IntroduceRef output ref) fun rettype

emptyRef : MType -> Type
emptyRef _ = Void

emptyFun : List MType -> MType -> Type
emptyFun _ _ = Void

argsScope : List MType -> MType -> Type;
-- fold over the list, starting with emptyRef and introducing references

data Function : (List MType -> MType -> Type) -> List MType -> MType -> Type where
  MkFunction : InstructionSequence (argsScope inputs) fun rettype -> Function fun inputs rettype

data Program : (List MType -> MType -> Type) -> Type where
  MkProgram : 

data Syscall : List MType -> MType -> Type where
  
