import System.IO


hangman :: IO ()
hangman = do putStrLn "Think of a word mofo"
             word <- sGetLine
             putStrLn "Guess mofo"
             play word
             -- nice

-- read String but don't echo it in plaintext
sGetLine :: IO String
sGetLine = do x <- getCh
              if x == '\n' then
                 do putChar x
                    return []
              else
                 do putChar '-'
                    xs <- sGetLine
                    return (x:xs)

-- actual not echoing needs some special sauce
getCh :: IO Char
getCh = do hSetEcho stdin False
           x <- getChar
           hSetEcho stdin True
           return x

play :: String -> IO ()
play word = do putStr "?que? "
               guess <- getLine
               if guess == word then 
                  putStrLn "Galaxy brain"
               else
                  do putStrLn (match word guess)
                     play word

match :: String -> String -> String
match word guess = [if elem c guess then c else '-' | c <- word]
