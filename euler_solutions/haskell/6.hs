


sumOfSquares lx = foldr (\x y -> x^2 + y) 0 lx

squareOfSums lx = sum(lx)^2

diffSums lx = squareOfSums lx - sumOfSquares lx


main = do
     putStrLn (show (diffSums [1..100]))
     