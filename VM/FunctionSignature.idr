module VM.FunctionSignature

import VM.MType

data FunctionSignature =
  MkFunctionSignature (List MType) MType
