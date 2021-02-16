-- A sequence of IO actions can be combined into a single
-- composite action with do notation and return, e.g.

-- an action that returns the first and third character
act :: IO (Char,Char)
act = do x <- getChar
         -- short for _ <- getChar
         getChar
         -- these expressions are called generators 
         -- (just like list comprehensions)
         -- becuase values for the variable to the left
         y <- getChar
         -- can't use just (x,y) here, need to go back
         -- to IOland
         return (x,y)


-- More complex: get line by recursively getting chars.
getLine :: IO String
getLine = do x <- getChar
             if x == '\n' then
                return []
             else
                do xs <- getLine
                   return (x:xs)
-- So the actual input string is hidden somewhere in the 
-- IO? 