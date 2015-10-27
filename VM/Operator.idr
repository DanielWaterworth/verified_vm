module VM.Operator

import VM.MType
import VM.FunctionSignature

data Operator : FunctionSignature -> Type where
  ADD : Operator (MkFunctionSignature [MWord64, MWord64] MWord64)
  SUB : Operator (MkFunctionSignature [MWord64, MWord64] MWord64)

  LT : Operator (MkFunctionSignature [MWord64, MWord64] MBool)
  GT : Operator (MkFunctionSignature [MWord64, MWord64] MBool)
  LE : Operator (MkFunctionSignature [MWord64, MWord64] MBool)
  GE : Operator (MkFunctionSignature [MWord64, MWord64] MBool)
  EQ : Operator (MkFunctionSignature [MWord64, MWord64] MBool)
  NE : Operator (MkFunctionSignature [MWord64, MWord64] MBool)

  OR : Operator (MkFunctionSignature [MBool, MBool] MBool)
  AND : Operator (MkFunctionSignature [MBool, MBool] MBool)
  XOR : Operator (MkFunctionSignature [MBool, MBool] MBool)
  XNOR : Operator (MkFunctionSignature [MBool, MBool] MBool)
  NOT : Operator (MkFunctionSignature [MBool] MBool)

  NOP : Operator (MkFunctionSignature [] MUnit)
