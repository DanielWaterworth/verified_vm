module Introduce

data Introduce : a -> (a -> Type) -> a -> Type where
  Introduced : Introduce introduced f introduced
  Elevate : f ty -> Introduce introduced f ty
