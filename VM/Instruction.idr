module VM.Instruction

import VM.MType
import VM.CallSite
import VM.Operator

data Instruction : (MType -> Type) -> (List MType -> MType -> Type) -> MType -> Type where
  Call : CallSite ref fun output -> Instruction ref fun output
  Operate : CallSite ref Operator output -> Instruction ref fun output
