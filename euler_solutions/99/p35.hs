-- 6 Problem 35
-- (**) Determine the prime factors of a given positive integer. Construct a flat list containing the prime factors in ascending order.



                
primeFactors' :: Int -> Int -> [Int]
primeFactors' n i
  | i * i > n = [n]
  | divisible = i : primeFactors' quotient i
  | otherwise = primeFactors' n (i + 1)                    
  where divisible = n `mod` i == 0              
        quotient = n `quot` i
  
                

primeFactors :: Int -> [Int]
primeFactors b = primeFactors' b 2
                          

main :: IO ()
main = do
  putStrLn $ show $ primeFactors' 315 2

                         

