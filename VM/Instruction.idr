module VM.Instruction

import VM.MType
import VM.CallSite
import VM.Operator
import VM.FunctionSignature

data Instruction : (MType -> Type) -> (FunctionSignature -> Type) -> MType -> Type where
  Call : CallSite ref fun output -> Instruction ref fun output
  Operate : CallSite ref Operator output -> Instruction ref fun output
  Const : MValue ty -> Instruction ref fun ty
