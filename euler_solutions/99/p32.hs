 -- 3 Problem 32
-- (**) Determine the greatest common divisor of two positive integer numbers. Use Euclid's algorithm.
-- Example in Haskell:
-- [myGCD 36 63, myGCD (-3) (-6), myGCD (-3) 6]
-- [9,3,3]



  
myGCD :: Int -> Int -> Int
myGCD a b 
  | modulus == 0 = b
  | otherwise = gcd b modulus  
  where modulus = a `mod` b
    

main :: IO ()
main = do
  putStrLn $ show $ myGCD 36 63

                         