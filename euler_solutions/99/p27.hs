-- 7 Problem 27
-- Group the elements of a set into disjoint subsets.
-- a) In how many ways can a group of 9 people work in 3 disjoint subgroups of 2, 3 and 4 persons? Write a function that generates all the possibilities and returns them in a list.
   
-- You may find more about this combinatorial problem in a good book on discrete mathematics under the term "multinomial coefficients".
-- Example in Haskell:
-- 27> group [2,3,4] ["aldo","beat","carla","david","evi","flip","gary","hugo","ida"]
-- [[["aldo","beat"],["carla","david","evi"],["flip","gary","hugo","ida"]],...]
-- (altogether 1260 solutions)
--  27> group [2,2,5] ["aldo","beat","carla","david","evi","flip","gary","hugo","ida"]
--  [[["aldo","beat"],["carla","david"],["evi","flip","gary","hugo","ida"]],...]
--  (altogether 756 solutions)
   

import Data.List


combinations :: (Eq a) => Int -> [a] -> [[a]]
combinations 0 xs = [[]]
combinations n [] = []
combinations n (x:xs) = [x:y | y <- combinations (n-1) xs] ++ combinations n xs

group :: (Eq a) => [Int] -> [a] -> [[[a]]]
group [] xs = []
group n [] = []
group (n:ns) xs = 
                  where combos = combinations n xs
  


                         
main :: IO ()
main = do
  putStrLn $ show $ combinations 2 [1,2,3,4,5]

                         