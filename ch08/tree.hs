-- Binary Tree
data Tree a = Leaf a | Node (Tree a) a (Tree a)

-- data and newtype types can be recursive.
-- Leaf and Node are constructor functions. e.g.
-- Node :: Tree a -> a -> Tree a -> Tree a
-- but they don't have defining equations - they're just data

-- is value in tree?
occurs :: Eq a => a -> Tree a -> Bool
occurs x (Leaf y)     = x == y
occurs x (Node l y r) = x == y || occurs x l || occurs x r

-- in worst case this will traverse the entire tree (or if value
-- isn't in the tree)
-- -> Better chances by using a search tree, i.e. a tree that can be
-- flattened into a sorted list:
flatten :: Tree a -> [a]
flatten (Leaf x)     = [x]
-- (why does cons (:) not work? no idea)
flatten (Node l x r) = flatten l ++ [x] ++ flatten r

-- then for a search tree occurs can be optimised:
occurs2 :: Ord a => a -> Tree a -> Bool
occurs2 x (Leaf y)                 = x == y
occurs2 x (Node l y r) | x == y    = True
                       | x < y     = occurs2 x l
                       | otherwise = occurs2 x r