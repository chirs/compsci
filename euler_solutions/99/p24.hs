-- 4 Problem 24
-- Lotto: Draw N different random numbers from the set 1..M.

-- Example in Haskell:
-- Prelude System.Random>diff_select 6 49
-- Prelude System.Random>[23,1,17,33,21,37]


import System.Random
import Control.Monad (replicateM)

                       
randomRange :: Int -> (Int, Int) -> IO [Int]
randomRange n (start, end) = do nums <- replicateM n $ getStdRandom $ randomR (start, end)
                                return nums
                              
main :: IO ()
main = randomRange 3 (5, 30) >>= putStrLn . show
       