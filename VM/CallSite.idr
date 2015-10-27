module VM.CallSite

import Always

import VM.MType
import VM.FunctionSignature

data CallSite : (MType -> Type) -> (FunctionSignature -> Type) -> MType -> Type where
  MkCallSite : f (MkFunctionSignature inputTypes retType) -> Always ref inputTypes -> CallSite ref f retType
