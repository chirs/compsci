-- 2 Problem 22
-- Create a list containing all integers within a given range.
-- Example in Haskell:
-- Prelude> range 4 9
-- [4,5,6,7,8,9]



range :: Int -> Int -> [Int]
range start end 
  | start > end = []
  | otherwise = start : range (start+1) end                   
                         
main :: IO ()
main = do
  putStrLn $ show $ range 4 9

                         