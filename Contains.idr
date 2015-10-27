module Contains

%default total

data Contains : List a -> a -> Type where
  First : Contains (x :: xs) x
  Elavate : Contains xs x -> Contains (y :: xs) x

instance Uninhabited (Contains [] x) where
  uninhabited First impossible
  uninhabited (Elavate _) impossible

applyEq : (a = b) -> a -> b
applyEq Refl x = x

contains : DecEq a => (xs : List a) -> (x : a) -> Dec (Contains xs x)
contains [] _ = No absurd
contains (x :: xs) y =
  case x `decEq` y of
    Yes prfEq => Yes (applyEq (cong prfEq) First)
    No prfNotEq =>
      case contains xs y of
        Yes prfContains => Yes (Elavate prfContains)
        No prfNotContains => No (\v =>
          case v of
            Elavate c => prfNotContains c
            First => prfNotEq Refl)

