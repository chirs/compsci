


encode :: [a] -> [(a Int)]
encode [] = []
encode (x:xs) 
  | length x == 1 = (x !! 0) :: pack xs
  | otherwise = (x !! 0, length x) : encode xy                                
  
                where xy = pack xs
                      
                      
                      
main :: IO ()
main = do
  putStrLn $ show $ pack [1,1,2,3,3,4,5,5]
                      