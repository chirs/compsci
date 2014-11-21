-- 5 Problem 34
-- (**) Calculate Euler's totient function phi(m).
-- Euler's so-called totient function phi(m) is defined as the number of positive integers r (1 <= r < m) that are coprime to m.
-- Example: m = 10: r = 1,3,7,9; thus phi(m) = 4. Note the special case: phi(1) = 1.


coPrime :: Int -> Int -> Bool
coPrime 1 _ = True
coPrime _ 1 = True
coPrime a b 
  | a == b = False
  | otherwise = coPrime b (gcd a b)  
                
                
totient :: Int -> Int                
totient n = foldl1 f [1..n-1]
            where f a b = if coPrime b n 
                             then a + 1
                             else a 
                          

main :: IO ()
main = do
  putStrLn $ show $ totient 10

                         

