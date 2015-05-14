cons :: a -> b -> (a -> b -> c) -> c
cons a b selector = selector a b
-- cons = \ a b f -> f a b

car :: ((a -> b -> a) -> c) -> c
car ab = ab (\a b -> a)
-- car = \ ab -> ab $ \ a b -> a
-- car ab = ab const

cdr :: ((a -> b -> b) -> c) -> c
cdr ab = ab (\a b -> b)
-- cdr = \ ab -> ab $ \ a b -> b
-- cdr ab = ab (flip const)

cadr :: ((a -> b -> b) -> (c -> d -> c) -> e) -> e
cadr = car . cdr

xs = cons (Just "the power of closures") $ 
     cons "a" $ 
     cons 5.6 $ 
     cons 1 $ 
     cons 'a' []
