-- type constructor = value constructor components
-- Book :: Int -> String -> [String] -> BookInfo
data BookInfo = Book Int String [String]
                deriving (Show)

myBook = Book 9780135072455 "Algebra of Programming"
         ["Richard Bird", "Oege de Moor"]

-- more commonly they'd have the same name
data BookReview = BookReview BookInfo CustomerID ReviewBody

-- type synonyms (no effect, just readability)
type CustomerID = Int
type ReviewBody = String
-- or with a tuple
type BookRecord = (BookInfo, BookReview)
type CardHolder = String
type CardNumber = Int
type Address = [String]

-- algebraic data types can have more than one value constructor
-- 'algebraic' because this is a sum type (other option is product), meaning the type is the disjoint union of its different constructor types
data BillingInfo = CreditCard CardHolder CardNumber Address
                 | CashOnDelivery
                 | Invoice CustomerID
                   deriving (Show)

someinvoice = Invoice 1234
someorder = CashOnDelivery

-- pattern match! using deconstruction
dosomething :: BillingInfo -> Int
dosomething (CashOnDelivery) = 1
dosomething (Invoice x) = x
-- wildcard so it's exhaustive
dosomething _ = 999

-- to avoid writing repetitive pattern-matching accessors, use record syntax
data Customer = Customer {
  customerID :: CustomerID
, customerName :: String
, customerAddress :: Address
} deriving (Show)

-- a record can be created with a more verbose syntax with free ordering
customer =  Customer {
              customerID = 271828
            , customerAddress = ["1048576 Disk Drive",
                                 "Milpitas, CA 95134",
                                 "USA"]
            , customerName = "Jane Q. Citizen"
            }

addr = customerAddress customer

-- parameterised types - used for the maybe thing
data MyMaybe a = MyJust a
               | MyNothing
               deriving (Show)

-- how do you actually use this?
maybestring = MyJust "something"
emptystring = MyNothing

-- recursive types - defined in terms of itself
data MyList a = MyCons a (MyList a)
              | Nil
              deriving (Show)

-- 'list-like' - cons is (:), Nil is []
numbers = MyCons 1 (MyCons 2 (Nil))

-- this and the inbuilt list are isomorphic, so it's easy to do this:
toList :: MyList a -> [a]
toList (MyCons x xs) = x : toList xs
toList Nil = []

-- error handling has special signature error :: String -> a because it doesn't actually return a value - but we can use it anywhere
somewhatSafeSecond :: [a] -> a
somewhatSafeSecond xs = if null (tail xs)
                        then error "too short"
                        else head (tail xs)

-- but it sucks because this isn't recoverable?
failing = somewhatSafeSecond [1]

-- much better to use Maybe and decide what to do at some later point
safeSecond :: [a] -> MyMaybe a
safeSecond [] = MyNothing
safeSecond xs = if null (tail xs)
                then MyNothing
                else MyJust (head (tail xs))

-- or even better KISS  (note that _ can match [])
tidySecond :: [a] -> MyMaybe a
tidySecond (_:x:_) = MyJust x
tidySecond _       = MyNothing

-- and this is how you get the value out again...
fromMaybe :: a -> MyMaybe a -> a
fromMaybe defval wrapped = 
    case wrapped of 
      MyNothing    -> defval
      MyJust value -> value
-- nice.

-- case <expression> of
--   <pattern> -> <expression>
-- all out-expressions MUST HAVE same type