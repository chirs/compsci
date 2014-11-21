-- (**) Drop every N'th element from a list.
-- * (drop '(a b c d e f g h i k) 3)
-- (A B D E G H K)


d' :: [a] -> [Int] -> [a]
d' xs ns = [ snd x | x <- zip [1..] xs, not ((fst x) `elem` ns)]


dropEvery :: [a] -> Int ->[a]
dropEvery xs n = d' xs [n, n+n..length xs]

             
main :: IO ()
main = do
  putStrLn $ show $ dropEvery [2,4..20] 3

