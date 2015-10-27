module VM.Terminator

import VM.MType
import VM.CallSite
import VM.FunctionSignature

data Terminator : (MType -> Type) -> (FunctionSignature -> Type) -> MType -> Type where
  Condition : ref MBool -> CallSite ref f rettype -> CallSite ref f rettype -> Terminator ref fun rettype
  TailCall : CallSite ref f rettype -> Terminator ref fun rettype
  Return : ref rettype -> Terminator ref fun rettype
