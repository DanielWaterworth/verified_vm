module Always

data Always : (x -> Type) -> List x -> Type where
  Nil : Always f []
  (::) : f ty -> Always f l -> Always f (ty :: l)
