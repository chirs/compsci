-- 6 Problem 26
-- (**) Generate the combinations of K distinct objects chosen from the N elements of a list
-- In how many ways can a committee of 3 be chosen from a group of 12 people? We all know that there are C(12,3) = 220 possibilities (C(N,K) denotes the well-known binomial coefficients). For pure mathematicians, this result may be great. But we want to really generate all the possibilities in a list.
-- Example in Haskell:
-- > combinations 3 "abcdef"
-- ["abc","abd","abe",...]

import Data.List


combinations :: (Eq a) => Int -> [a] -> [[a]]
combinations 0 xs = [[]]
combinations n [] = []
--combinations n xs = concat [ [x : y | y <- ( combinations (n-1) (delete x xs) ) ]  | x <- xs]
combinations n (x:xs) = [x:y | y <- combinations (n-1) xs] ++ combinations n xs -- Alan's suggestion.

                         
main :: IO ()
main = do
  putStrLn $ show $ combinations 2 [1,2,3,4,5]

                         