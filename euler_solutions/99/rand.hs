import System.Random

main = do
  gen <- newStdGen
  let randomChars = randomRs ('a', 'z') gen         
      first20 = take 20 randomChars
      second20 = take 20 randomChars
  putStr $ take first20
  putStr "\n"
  putStr $ take second20
  putStr "\n"
