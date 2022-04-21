type Pos = (Int, Int)

-- board tracks only positions which are alive
type Board = [Pos]


isAlive :: Board -> Pos -> Bool
isAlive b p = elem p b

isEmpty :: Board -> Pos -> Bool
isEmpty b p = not (isAlive b p)

neighbours :: Pos -> [Pos]
neighbours (x,y) = map wrap [(x-1, y-1), (x,   y-1),
                             (x+1, y-1), (x-1, y),
                             (x+1, y),   (x-1, y+1),
                             (x,   y+1), (x-1, y+1)]

-- make sure 10 -> 10 but 11 -> 1
wrap :: Pos -> Pos
wrap (x,y) = (((x-1) `mod` width) + 1,
              ((y-1) `mod` height) + 1)

liveNeighbours :: Board -> Pos -> Int
liveNeighbours b = length . filter (isAlive b) . neighbours
-- ok maybe implicit style isn't really clearer after all...

-- Rules of the game: positions with two or three live 
-- neighbours remain alive...
survivors :: Board -> [Pos]
survivors b = [p | p <- b, elem (liveNeighbours b p) [2,3]]

-- ...and also empty cells with exactly 3 neighbours come alive
births :: Board -> [Pos]
births b = [(x,y) | x <- [1..width],
                    y <- [1..height],
                    isEmpty b (x,y),
                    liveNeighbours b (x,y) == 3]

-- of course this is all preeetty inefficient

nextgen :: Board -> Board
nextgen b = survivors b ++ births b



{-
 - Game config
-}

width :: Int
width = 10

height :: Int
height = 10


glider :: Board
glider = [(4,2), (2,3), (4,3), (3,4), (4,4)]


{-
 - Drawing is implemented at the lowest level 
 - possible using control characters.
-}

writeat :: Pos -> String -> IO ()
writeat p xs = do cursorto p
                  putStr xs

cursorto :: Pos -> IO ()
cursorto (x,y) = putStr ("\ESC[" ++ show y ++ ";" ++ show x ++ "H")

showcells :: Board -> IO ()
showcells b = sequence_ [writeat p "O" | p <- b]

cls :: IO ()
cls = putStr "\ESC[2J"


life :: Board -> IO ()
life b = do cls
            showcells b
            wait 500000
            life (nextgen b)

-- a very dumb waiting function
wait :: Int -> IO ()
wait n = sequence_ [return () | _ <- [1..n]]
