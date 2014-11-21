
-- Replicate the elements of a list a given number of times
-- * (repli '(a b c) 3)
-- (A A A B B B C C C)


repli :: [a] -> Int -> [a]
repli l n = concat $ map (replicate n) l


main :: IO ()
main = do
  putStrLn $ show $ repli [1,3,5,9] 4
