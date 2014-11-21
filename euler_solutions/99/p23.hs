-- 3 Problem 23
-- Extract a given number of randomly selected elements from a list.
-- Example in Haskell:
-- Prelude System.Random>rnd_select "abcdefgh" 3 >>= putStrLn
-- eda

-- I cheated on this one. Should come back and do again.


import System.Random
import Control.Monad (replicateM)

rndSelect :: [a] -> Int -> IO [a]
rndSelect [] _ = return []
rndSelect l n
  | n < 0 = error "N must be greater than zero."
  | otherwise = do pos <- replicateM n $ getStdRandom $ randomR (0, (length l)-1)          
                   return [l !! p | p <- pos]


main :: IO ()
main = (rndSelect [1,2,3] 2) >>= putStrLn . show

            

                         