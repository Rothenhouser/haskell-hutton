-- Intuition

-- A interactive program depends on the state of the
-- world. To model it as a single pure function we would
-- have to take into account the 'state of the world':
type IO = World -> World

-- Or, with a return value
type IO a = World -> (a, World)

-- expressions with that type are called *actions*, so
-- e.g. actions which return a character have type
-- IO Char. Example would be
getChar :: IO Char
getChar = ...

-- Or an action that returns nothing
putChar :: Char -> IO ()


-- Really passing around the 'state of the world' would
-- be cumbersome. So IO isn't really a function type but
-- a primitive. Think of it for this chapter as a built-in
-- type whose implementation is hidden:
data IO a = ...

--

-- `return` is needed to go from pure to impure
return :: a -> IO a
