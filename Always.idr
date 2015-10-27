module Always

import Elem

%default total

data Always : (x -> Type) -> List x -> Type where
  Nil : Always f []
  (::) : f ty -> Always f l -> Always f (ty :: l)

index : Elem x xs -> Always f xs -> f x
index Here (x :: _) = x
index (There elem) (_ :: xs) = index elem xs

replaceAt : Elem x xs -> f x -> Always f xs -> Always f xs
replaceAt Here element (_ :: xs) = element :: xs
replaceAt (There n) element (x :: xs) = x :: replaceAt n element xs
