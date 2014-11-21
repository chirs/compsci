-- 8 Problem 28
--  Sorting a list of lists according to length of sublists
-- a) We suppose that a list contains elements that are lists themselves. The objective is to sort the elements of this list according to their length. E.g. short lists first, longer lists later, or vice versa.
--  Example in Haskell:
-- lfsort ["abc", "de", "fgh", "de", "ijkl", "mn", "o"]
-- ["ijkl","o","abc","fgh","de","de","mn"]
  

quickSort' :: Ord a => [[a]] -> [[a]]
quickSort' [] = []
quickSort' (x:xs) = quickSort' lesser ++ [x] ++ quickSort' greater
                    where lesser = [e |e <- xs, length e < length x]
                          greater = [e |e <- xs, length e >= length x]



main :: IO ()
main = do
  putStrLn $ show $ quickSort' ["abc", "de", "fgh", "de", "ijkl", "mn", "o"]

                         