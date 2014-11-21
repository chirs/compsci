

dupli :: [a] -> [a]
dupli [] = []
dupli (a:ax) = a : a : dupli ax


main :: IO ()
main = do
  putStrLn $ show $ dupli [1,3,5,9]
