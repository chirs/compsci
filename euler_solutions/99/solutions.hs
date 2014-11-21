
-- 1: (*) Find the last element of a list.

last' :: [a] -> a
last' [a] = a
last' (a:ax) = last' ax


-- 2: (*) Find the last but one element of a list.

penult :: [x] -> x
penult x:y:[] = x
penult (x:xs) = penult xs


-- 3: (*) Find the K'th element of a list. The first element in the list is number 1.

elementAt :: [x] -> Int -> x
-- add error statement here.
elementAt (x:xs) 0 = x
elementAt (x:xs) n = elementAt xs (n-1)


-- 4: (*) Find the number of elements of a list.

length' :: [x] -> Int
-- length' [] = 0
-- length' (x:xs) = 1 + length' xs
length' = foldl (+) 0


-- 5: (*) Reverse a list.

reverse' :: [x] -> [x]
reverse' [] = []
reverse' (x:xs) = reverse' xs ++ [x]


-- 6: (*) Find out whether a list is a palindrome. A palindrome can be read forward or backward; e.g. (x a m a x).

isPalindrome :: Eq a => [a] -> Bool
isPalindrome lx = lx == reverse lx


-- 7: (**) Flatten a nested list structure.
-- Transform a list, possibly holding lists as elements into a `flat' list by replacing each list with its elements (recursively).

-- this is terrible.

data NestedList a = Elem a | List [NestedList a]


flatten :: NestedList a -> [a]
flatten (Elem x) = [x]
flatten (List (x:xs)) = flatten x ++ flatten (List xs)
flatten (List []) = []



-- 8: (**) Eliminate consecutive duplicates of list elements.
-- If a list contains repeated elements they should be replaced with a single copy of the element. The order of the elements should not be changed.

-- is this ok? 

compress :: Eq a => [a] -> [a]
compress [] = []
compress [x] = [x]
compress (x:y:ys) 
  | x == y = compress (y':ys)
  | otherwise = [x] ++ compress (y:ys)
  

