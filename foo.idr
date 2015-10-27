module main

import VM.MType
import VM.InstructionSequence

emptyRef : MType -> Type
emptyRef _ = Void

emptyFun : List MType -> MType -> Type
emptyFun _ _ = Void

argsScope : List MType -> MType -> Type
-- fold over the list, starting with emptyRef and introducing references

data Function : (List MType -> MType -> Type) -> List MType -> MType -> Type where
  MkFunction : InstructionSequence (argsScope inputs) fun rettype -> Function fun inputs rettype

{-
data Program : (List MType -> MType -> Type) -> Type where
  MkProgram : 

data Syscall : List MType -> MType -> Type where
  
-}
