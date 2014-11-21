


isPalindrome :: Eq a => [a] -> Bool
isPalindrome lx = lx == reverse lx

main :: IO ()
main = do
  putStrLn $ show $ isPalindrome [1,3,5,3,1]
