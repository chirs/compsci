-- (**) Extract a slice from a list.
-- Given two indices, i and k, the slice is the list containing the elements between the i'th and k'th element of the original list (both limits included). Start counting the elements with 1.
--   Example in Haskell:
--    *Main> slice ['a','b','c','d','e','f','g','h','i','k'] 3 7
-- "cdefg"


slice  :: [a] -> Int -> Int -> [a]
slice [] _ _ = []
slice (x:xs) start end 
  | end == 0 = []                  
  | start > 1 = slice xs (start-1) (end-1)
  | otherwise = x : slice xs (start-1) (end-1)
                

main :: IO ()
main = do
  putStrLn $ show $ slice [1..20] 3 7

