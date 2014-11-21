-- 10 Problem 20
-- (*) Remove the K'th element from a list.
-- *Main> removeAt 2 "abcd"
-- ('b',"acd")

removeAt :: Int -> [a] -> [a]
removeAt n [] = []
removeAt 0 xs = xs
removeAt 1 (x:xs) = xs
removeAt n (x:xs) = x : removeAt (n-1) xs

                         
main :: IO ()
main = do
  putStrLn $ show $ removeAt 2 "abcd"

                         