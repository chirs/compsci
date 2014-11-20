
isValid n = n `mod` 3 == 0 || n `mod` 5 == 0

s = sum [x | x <- [1..999], isValid x]

main = do
     putStrLn (show s)

