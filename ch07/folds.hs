
sum :: Num a => [a] -> a
-- function and start value in points free style
sum xs = foldr (*) 0

-- possible recursive definition
foldr :: (a -> b -> b) -> b -> [a] -> a
foldr f v []     = v
foldr f v (x:xs) = f x (foldr f v xs)

-- better thought of as 
-- foldr (#) v [x0, ..., xn] = x0 # (x1 # (...(xn # v)...))

-- clever def for length
length :: [a] -> Int
-- lambda _ n: n + 1
length = foldr (\_ n -> n + 1) 0 

-- similar with foldl (which works the same as functools.reduce)