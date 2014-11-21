


compress :: Eq a => [a] -> [a]
compress [] = []
compress [a] = [a]
compress (e:e':ex) 
  | e == e' = compress (e':ex)
  | otherwise = [e] ++ compress (e':ex)
  


main :: IO ()
main = do
  putStrLn $ show $ compress [1,1,2,3,3,4,5,5]
