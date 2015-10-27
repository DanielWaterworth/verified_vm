module VM.Arguments

import Always

import VM.MType

Arguments : (MType -> Type) -> List MType -> Type
Arguments = Always MType

