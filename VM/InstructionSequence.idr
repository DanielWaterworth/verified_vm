module VM.InstructionSequence

import Introduce

import VM.MType
import VM.Instruction
import VM.Terminator

data InstructionSequence : (MType -> Type) -> (List MType -> MType -> Type) -> MType -> Type where
  Nil : Terminator ref fun rettype -> InstructionSequence ref fun rettype
  (::) : Instruction ref fun output -> InstructionSequence (Introduce output ref) fun rettype

