module Elem

%default total

fromYes : (prf:Dec x) -> {auto ok : (prf = Yes p)} -> x
fromYes _ {p} = p

applyEq : (a = b) -> a -> b
applyEq Refl x = x

data Elem : List a -> a -> Type where
  Here : Elem (x :: xs) x
  There : Elem xs x -> Elem (y :: xs) x

instance Uninhabited (Elem [] x) where
  uninhabited Here impossible
  uninhabited (There _) impossible

decElem : DecEq a => (xs : List a) -> (x : a) -> Dec (Elem xs x)
decElem [] _ = No absurd
decElem (x :: xs) y =
  case x `decEq` y of
    Yes prfEq => Yes (applyEq (cong prfEq) Here)
    No prfNotEq =>
      case decElem xs y of
        Yes prfElem => Yes (There prfElem)
        No prfNotElem => No (\v =>
          case v of
            There c => prfNotElem c
            Here => prfNotEq Refl)

position : Elem xs x -> Nat
position Here = 0
position (There p) = 1 + position p

positionInBounds : (prf : Elem xs x) -> InBounds (position prf) xs
positionInBounds Here = InFirst
positionInBounds (There p) = InLater (positionInBounds p)

lookupElemEq : (prf:Elem xs x) -> index (position prf) xs {ok=positionInBounds prf} = x
lookupElemEq Here = Refl
lookupElemEq (There p) = lookupElemEq p
