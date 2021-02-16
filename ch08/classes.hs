class Eq a where
   (==), (/=) :: a -> a -> Bool

   x /= y = not (x == y)

-- This means that for a type a to be an instance of Eq
-- it must support the equality and inequality operator.
-- There is a default definition of inequality, so to 
-- define a type to be Eq you need to only define equality.
instance Eq Bool where
   False == False = True
   True  == True  = True
   _     == _     = False
   