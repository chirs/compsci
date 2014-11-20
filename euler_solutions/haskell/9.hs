

simpleTriples = [(x, y, z) | z <- [1..], x <- [1..z], y <- [x..z], x^2 + y^2 == z^2]

triples = [(a^2-b^2, 2*a*b, a^2+b^2) | a <- [1..], b <- [1..a]]


allTriples = 



main = do
     putStrLn (show triples)