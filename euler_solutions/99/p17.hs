-- (*) Split a list into two parts; the length of the first part is given.
-- Do not use any predefined predicates.
-- * (split '(a b c d e f g h i k) 3)
-- ( (A B C) (D E F G H I K))

split' :: [a] -> Int -> ([a], [a])
split' xs 0 = ([], xs)
split' (x:xs) n = ( x : (fst (split' xs (n-1))), snd (split' xs (n-1)))


main :: IO ()
main = do
  putStrLn $ show $  split' [1,3,5,9,11,32] 3

