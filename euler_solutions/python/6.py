

sum_of_squares = lambda l: sum([e ** 2 for e in l])
square_of_sums = lambda l: sum(l) ** 2
diff = lambda l: square_of_sums(l) - sum_of_squares(l)


if __name__ == "__main__":
    print sum_of_squares(range(101))
    print square_of_sums(range(101))
    print diff(range(101))
