module VM.Instruction

import Introduce

import VM.MType
import VM.Arguments

data Instruction : (MType -> Type) -> (List MType -> MType -> Type) -> MType -> Type where
  Call : fun inputs output -> Arguments ref inputs -> Instruction ref fun output

  Add : ref MWord64 -> ref MWord64 -> Instruction ref fun MWord64
  Sub : ref MWord64 -> ref MWord64 -> Instruction ref fun MWord64
  Lt : ref MWord64 -> ref MWord64 -> Instruction ref fun MBool

  Or : ref MBool -> ref MBool -> Instruction ref fun MBool
  And : ref MBool -> ref MBool -> Instruction ref fun MBool
  Xor : ref MBool -> ref MBool -> Instruction ref fun MBool
  Not : ref MBool -> Instruction ref fun MBool
