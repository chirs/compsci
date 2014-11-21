

-- Could use some more thought invested in this one.
-- Not exactly clear how List is being used here.

data NestedList a = Elem a | List [NestedList a]


flatten :: NestedList a -> [a]
flatten (Elem x) = [x]
flatten (List (x:xs)) = flatten x ++ flatten (List xs)
flatten (List []) = []


main :: IO ()
main = do
  putStrLn $ show $ flatten (List [Elem 1, List [Elem 2, List [Elem 3, Elem 4], Elem 5]])
