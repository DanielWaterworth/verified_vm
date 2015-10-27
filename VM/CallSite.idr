module VM.CallSite

import Always

import VM.MType

data CallSite : (MType -> Type) -> (List MType -> MType -> Type) -> MType -> Type where
  MkCallSite : f inputTypes retType -> Always ref inputTypes -> CallSite ref f retType
