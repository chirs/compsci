-- 9 Problem 19
-- (**) Rotate a list N places to the left.
-- Hint: Use the predefined functions length and (++).
-- Examples in Haskell:
-- *Main> rotate ['a','b','c','d','e','f','g','h'] 3
-- "defghabc"



rotate :: [a] -> Int -> [a]
rotate l 0 = l
rotate [] n = []
rotate (x:xs) n = rotate xs (rn-1) ++ [x]
                   where rn = mod n (length xs + 1)
  
                         
main :: IO ()
main = do
  putStrLn $ show $ rotate [1..20] 7

                         