module Scope

import Elem

oneOf : List a -> a -> Type
oneOf = flip Elem

emptyScope : a -> Type
emptyScope = const Void

data Introduce : a -> (a -> Type) -> a -> Type where
  Introduced : Introduce introduced f introduced
  Elevate : f ty -> Introduce introduced f ty

data CombineScopes : (a -> Type) -> (a -> Type) -> a -> Type where
  Left : f a -> CombineScopes f g a
  Right : g a -> CombineScopes f g a
