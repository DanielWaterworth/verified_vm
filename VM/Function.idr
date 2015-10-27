module VM.Function

import Scope

import VM.MType
import VM.InstructionSequence
import VM.FunctionSignature

function : (FunctionSignature -> Type) -> FunctionSignature -> Type
function fun (MkFunctionSignature inputs retType) = InstructionSequence (oneOf inputs) fun retType
