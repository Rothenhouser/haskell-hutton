-- local variables are defined with let
-- these are expressions, not values - lazy evaluation!
-- no newBalance is computed if balance is too low.
lend :: (Ord a, Num a) => a -> a -> Maybe a
lend amount balance = let reserve    = 100
                          newBalance = balance - amount
                      in if balance < reserve
                         then Nothing
                         else Just newBalance

-- can shadow outer blocks or function args
quux :: a -> [Char]
quux a = let a = "foo"
         in a ++ "eek!"

-- alternatively use where
lend2 amount balance = if balance < reserve
                       then Nothing
                       else Just newBalance
    where reserve    = 100
          newBalance = balance - amount

-- let and where can also define local functions
-- note if you use where as here, don't add explicit variable or it screws performance
fib :: Int -> Integer
fib = (map fib' [0 ..] !!)
    where
      fib' 0 = 0
      fib' 1 = 1
      fib' n = fib (n - 1) + fib (n - 2)

-- GUARDS! GUARDS!
-- use when just pattern matching isn't enough
lend3 amount balance
--    | amount <= 0       = Nothing
      | balance < reserve = Nothing
      | otherwise         = Just newBalance
    where reserve    = 100
          newBalance = balance - amount