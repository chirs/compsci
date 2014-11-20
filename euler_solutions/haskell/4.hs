

isPalindrome :: String -> Bool
isPalindrome s | length s < 2 = True
	       | True          = s == reverse s


isNPalindrome :: Int -> Bool
isNPalindrome n = isPalindrome (show n)



main = do
     putStrLn (show (maximum [ x | y <- [100..999],
               	             z <- [100..999],
			     let x = y * z,
			     isNPalindrome x]))

