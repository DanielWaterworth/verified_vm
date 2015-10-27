module VM.Terminator

import VM.MType
import VM.Arguments

data Terminator : (MType -> Type) -> (List MType -> MType -> Type) -> MType -> Type where
  Condition : ref MBool -> fun inputs1 rettype -> Arguments ref inputs1 -> fun inputs2 rettype -> Arguments ref inputs2 -> Terminator ref fun rettype
  TailCall : fun inputs rettype -> Arguments ref inputs -> Terminator ref fun rettype
  Return : ref rettype -> Terminator ref fun rettype
