-- (*) Find the K'th element of a list. The first element in the list is number 1.

elementAt :: [a] -> Int -> a
-- can't return [] since it's not of type a! elementAt [] _ = []
elementAt (a:ax) 0 = a
elementAt (a:ax) n = elementAt ax (n-1)

main :: IO ()
main = do
  putStrLn $ show $ elementAt [1,2,3,4,5] 3
