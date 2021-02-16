import Prelude hiding ((^))

sumdown :: Int -> Int
sumdown x 
  | x > 0 = x + sumdown (x - 1)
  | otherwise = 0

(^) :: Int -> Int -> Int
x ^ 0 = 1
x ^ 1 = x
x ^ y 
  | y > 0 = x * (x ^ (y-1))
-- can't do this typewise apparently
-- | otherwise = 1 / (x ^ (-y))
  | otherwise = 0

newtype Nat = N Int

euclid :: Nat -> Nat -> Nat
-- only applicable to natural numbers 
euclid x y | x == y = x
           | x > y = euclid (x - y) y
           | x < y = euclid x (y - x)
  