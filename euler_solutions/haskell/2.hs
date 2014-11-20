fibs = 1 : 1 : zipWith (+) fibs (tail fibs)

evenFibs = [ x | x <- fibs, even x]

fibEvenSumUnder n = sum [ x | x <- takeWhile (<= n) evenFibs]

main = do 
     putStrLn (show (fibEvenSumUnder 4000000))