-- having composition as an operator is neat
-- note is the other way round from a pipeline!
(.) :: (b -> c) -> (a -> b) -> (a -> c)
f . g = \ x -> f (g x)


-- as long as functions are chained correctly type-wise
-- the actual order of evaluation doesn't matter because
-- 'composition is associative'.  (???)
-- No idea how this would work in practice.
-- But it means no parentheses necessary:
sumsqreven = sum . map (^2) . filter even 


-- Identity function may be useful for folds with composition:
compose :: [a -> a] -> (a -> a)
compose :: foldr (.) id

-- See how it's also only possible to compose a list of
-- functions when they have identical signatures. 
-- There must be a better way.