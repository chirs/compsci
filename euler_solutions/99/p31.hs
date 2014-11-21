-- 1 Arithmetic
-- 2 Problem 31
-- (**) Determine whether a given integer number is prime.
-- Example in Haskell:
-- P31> isPrime 7
-- True

  
isPrime :: Int -> Bool
isPrime 0 = False
isPrime 1 = False
isPrime n
  | n < 0 = isPrime (-n)
  | otherwise = divides [2..end] n
                where end = n - 1 -- floor $ sqrt n (not working.)
                      divides [] i = False
                      divides (x:xs) i = ((i `mod` x) == 0) || divides xs i

main :: IO ()
main = do
  putStrLn $ show $ isPrime 13
  putStrLn $ show $ isPrime 18

                         