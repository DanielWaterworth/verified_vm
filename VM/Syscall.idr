module VM.Syscall

import VM.MType
import VM.FunctionSignature

data Syscall : FunctionSignature -> Type where
