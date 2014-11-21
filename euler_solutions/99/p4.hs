

length' :: [a] -> Int
length' [] = 0
length' (a:ax) = 1 + length' ax


main :: IO ()
main = do
  putStrLn $ show $ length' [1,3..19]
