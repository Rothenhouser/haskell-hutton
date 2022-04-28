{-
 - State monad.
 - Gotta admit this is pretty tricky.
-}


-- ok this could be anything. like an app state for a brick TUI?
type State = Int


-- This is not good because it can't be made a monad etc instance
-- type ST a = State -> (a,State)

-- so define the state transformer as
newtype ST a = S (State -> (a,State))
-- with S being a dummy constructor.
-- For application remove the dummy: (what??)
app :: ST a -> State -> (a, State)
app (S stf) x = stf x
-- So that now 
-- stf :: State -> (a, State)


-- Now, to make the ST type into a monad, first make it a functor.
instance Functor ST where
   -- fmap :: (a -> b) -> ST a -> ST b
   fmap g st = S (\s -> let (x,s') = app st s in (g x, s'))
     -- i.e. = S (\s -> let (x,s') =    stf s in (g x, s'))

