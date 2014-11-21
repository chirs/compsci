-- 3 Problem 81
-- (**) Path from one node to another one
-- Write a function that, given two nodes a and b in a graph, returns all the acyclic paths from a to b.

-- Example in Haskell:
-- paths 1 4 [(1,2),(2,3),(1,3),(3,4),(4,2),(5,6)]
-- [[1,2,3,4],[1,3,4]]
-- paths 2 6 [(1,2),(2,3),(1,3),(3,4),(4,2),(5,6)]
-- []

paths :: Int -> Int -> [(Int, Int)]

