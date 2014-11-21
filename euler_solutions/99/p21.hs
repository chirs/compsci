-- 10 Problem 20
-- (*) Remove the K'th element from a list.
-- *Main> removeAt 2 "abcd"
-- ('b',"acd")

insertAt :: a -> [a] -> Int -> [a]
insertAt e xs 1 = e : xs
insertAt e [] n = [e]
insertAt e (x:xs) n = x : (insertAt e xs (n-1))
                         
main :: IO ()
main = do
  putStrLn $ show $ insertAt 'Z' "abcd" 3

                         