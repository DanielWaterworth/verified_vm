module VM.Program

import Always
import Scope

import VM.Function
import VM.FunctionSignature
import VM.Syscall
import VM.MType

functionScope : List FunctionSignature -> FunctionSignature -> Type
functionScope signatures = CombineScopes Syscall (oneOf signatures)

functionDefinitions : List FunctionSignature -> Type
functionDefinitions signatures = Always (function (functionScope signatures)) signatures

data Program : Type where
  MkProgram :
    (signatures : List FunctionSignature) ->
    functionDefinitions signatures ->
    function (functionScope signatures) (MkFunctionSignature [] MUnit) ->
    Program
