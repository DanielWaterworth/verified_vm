module VM.Operator

import VM.MType

data Operator : List MType -> MType -> Type where
  ADD : Operator [MWord64, MWord64] MWord64
  SUB : Operator [MWord64, MWord64] MWord64

  LT : Operator [MWord64, MWord64] MBool
  GT : Operator [MWord64, MWord64] MBool
  LE : Operator [MWord64, MWord64] MBool
  GE : Operator [MWord64, MWord64] MBool
  EQ : Operator [MWord64, MWord64] MBool
  NE : Operator [MWord64, MWord64] MBool

  OR : Operator [MBool, MBool] MBool
  AND : Operator [MBool, MBool] MBool
  XOR : Operator [MBool, MBool] MBool
  XNOR : Operator [MBool, MBool] MBool
  NOT : Operator [MBool] MBool
