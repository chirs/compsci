Just a repo for math problems. Nothing special.


Universal Cycle
===============

This is a simple little program that I wrote to solve a math problem that had been bugging me for a while. Siddartha Rao helped a lot by knowing math, doing research and suggesting that a greedy algorithm might actually work.

I used to have a car with a keypad on the driver's side door so that you could unlock the car without a key. Unfortunately, I forgot the code.

This begged the question, how could I go about figuring out the code? I wanted to know what was the lowest possible number of keys that I could press and be guaranteed to find the code. Stated another way, the question is what is the shortest string for which all possible combinations of n characters of length m are contained as substrings. That is, if my car had just two buttons, and I knew the code was only two digits long, how many buttons would I have to press? Answer: 5, because 00110 contains 00, 01, 10, and 11.

It turns out that this problem seems to be solvable using a greedy algorithm that assumes that the solution string always has the minimum length and that no string combination is ever repeated. Weird, I know.

