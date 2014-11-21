
-- Come back and finish.

pack :: Eq a => [a] -> [[a]]
pack [] = []
pack [a] = [[a]]
pack (e:ex) 
  | ex == [] = [e]
  | e == head(ex) = e : pack (e:ex)
  | otherwise = [e] : pack (e:ex)
  
                

main :: IO ()
main = do
  putStrLn $ show $ pack [1,1,2,3,3,4,5,5]
