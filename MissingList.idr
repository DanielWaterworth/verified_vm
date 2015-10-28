module MissingList

%default total

deleteAt : (n : Nat) -> (xs : List a) -> {auto ok : InBounds n xs} -> List a
deleteAt Z (_ :: xs) = xs
deleteAt (S n) (x :: xs) {ok = InLater ok} = x :: deleteAt {ok} n xs

insertAt : (n : Nat) -> a -> (xs : List a) -> {auto ok : InBounds n xs} -> List a
insertAt Z elem xs = elem :: xs
insertAt (S n) elem (x :: xs) {ok = InLater ok} = x :: insertAt {ok} n elem xs

replaceAt : (n : Nat) -> a -> (xs : List a) -> {auto ok : InBounds n xs} -> List a
replaceAt Z elem (_ :: xs) = (elem :: xs)
replaceAt (S n) elem (x :: xs) {ok = InLater ok} = x :: replaceAt {ok} n elem xs

replaceIsDeleteAndInsert : insertAt {ok=ok1} n x (deleteAt {ok=ok2} n xs) = replaceAt {ok=ok3} n x xs
replaceIsDeleteAndInsert {xs = []} {ok3 = InFirst} impossible
replaceIsDeleteAndInsert {xs = []} {ok3 = InLater _} impossible
replaceIsDeleteAndInsert {xs = _ :: _} {ok3 = InFirst} = Refl
replaceIsDeleteAndInsert {xs = _ :: _} {ok3 = InLater _} {ok2 = InFirst} impossible
replaceIsDeleteAndInsert {xs = _ :: _} {ok3 = InLater _} {ok1 = InFirst} impossible
replaceIsDeleteAndInsert {xs = x :: xs} {ok3 = InLater ok3} {ok1 = InLater ok1} {ok2 = InLater ok2} =
  cong (replaceIsDeleteAndInsert {ok1} {ok2} {ok3})

deleteOppositeInsert : deleteAt {ok=ok1} n (insertAt {ok=ok2} n x xs) = xs
deleteOppositeInsert {xs = []} {ok2 = InFirst} impossible
deleteOppositeInsert {xs = []} {ok2 = InLater _} impossible
deleteOppositeInsert {xs = _ :: _} {ok2 = InFirst} = Refl
deleteOppositeInsert {xs = _ :: _} {ok1 = InLater _} {ok2 = InFirst} impossible
deleteOppositeInsert {xs = x :: xs} {ok1 = InLater ok1} {ok2 = InLater ok2} =
  cong (deleteOppositeInsert {ok1} {ok2})
