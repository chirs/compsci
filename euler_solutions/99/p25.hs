-- 5 Problem 25
--   Generate a random permutation of the elements of a list.


-- Example in Haskell:
-- Prelude>rnd_permu "abcdef"
-- Prelude>"badcef"
  

import System.Random
import Data.List



randomIndex :: RandomGen g => [a] -> g -> (Int, g)
randomIndex xs g = (index, gen)
                   where rng = (0, length(xs)-1)
                         (index, gen) = randomR rng g
                         
                         
-- Can get rid of the Eq a if i replace delete with a better list removal mechanism.                         
randomPerm' :: RandomGen g => (Eq a) => g -> [a] -> [a]
randomPerm' _ [] = []
randomPerm' g xs = item : randomPerm' ng nl
                  where (index, ng) = randomIndex xs g
                        item = xs !! index
                        nl = delete item xs
                        
                        
                        
-- for some reason this won't compile. Moving on for now.                        
randomPerm :: [Int] -> IO [Int]
randomPerm xs = do nxs <- randomPerm' getStdRandom xs
                   return nxs
                 

main :: IO ()
--main = randomPerm [1..10] >>= putStrLn . show
--main = putStrLn $ show $ randomPerm' (mkStdGen 101) [1,3,5,7,9] 
main = randomPerm [1,5,8,10,12] >>= putStrLn . show
