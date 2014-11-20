

check = lambda n: (n % 3 == 0) or (n % 5 == 0)

if __name__ == "__main__":
    print sum([e for e in range(1, 1000) if check(e)])
