module VM.InstructionSequence

import Scope

import VM.MType
import VM.Instruction
import VM.Terminator
import VM.FunctionSignature

data InstructionSequence : (MType -> Type) -> (FunctionSignature -> Type) -> MType -> Type where
  Nil : Terminator ref fun rettype -> InstructionSequence ref fun rettype
  (::) : Instruction ref fun output -> InstructionSequence (Introduce output ref) fun rettype

