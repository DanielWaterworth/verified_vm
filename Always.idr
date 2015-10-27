module Always

data Always : (x : Type) -> (x -> Type) -> List x -> Type where
  Nil : Always x f []
  (::) : f ty -> Always x f l -> Always x f (ty :: l)
