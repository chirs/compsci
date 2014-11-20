

isprime :: (Integral i) => i -> Bool
isprime n = isprime_ n primes
  where isprime_ n (p:ps)
          | p*p > n        = True
          | n `mod` p == 0 = False
          | otherwise      = isprime_ n ps

primes :: (Integral i) => [i]
primes = 2 : filter isprime [3,5..]


getPrime n = last (take n primes)


main = do
     putStrLn (show (getPrime 10001))