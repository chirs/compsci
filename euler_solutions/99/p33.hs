-- 4 Problem 33
-- (*) Determine whether two positive integer numbers are coprime. Two numbers are coprime if their greatest common divisor equals 1.


coPrime :: Int -> Int -> Bool
coPrime 1 _ = True
coPrime _ 1 = True
coPrime a b 
  | a == b = False
  | otherwise = coPrime b (gcd a b)  
    
    

main :: IO ()
main = do
  putStrLn $ show $ coPrime 36 63
  putStrLn $ show $ coPrime 35 44

                         