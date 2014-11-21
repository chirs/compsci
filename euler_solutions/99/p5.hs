

reverse' :: [a] -> [a]
reverse' [] = []
reverse' (a:ax) = reverse' ax ++ [a]


main :: IO ()
main = do
  putStrLn $ show $ reverse' [1,3..19]
