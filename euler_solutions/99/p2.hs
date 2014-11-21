-- (*) Find the last but one element of a list.

lastButOne' :: [a] -> a
lastButOne' [a,b] = a
lastButOne' (a:ax) = lastButOne' ax

main :: IO ()
main = do
  putStrLn $ show $ lastButOne' [1,2,3,4,5]
