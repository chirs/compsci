import itertools

def get_sequence(n):
    if n == 1:
        return [1]
    else:
        if n % 2 == 0:
            return [n] + get_sequence(n / 2)
        else:
            return [n] + get_sequence(3 * n + 1)


def get_longest(i):
    
    n = 0
    longest = []
    for e in itertools.count(2):
        s = get_sequence(e)
        if len(s) > len(longest):
            longest = s
            n = e
        if e == i:
            return n




if __name__ == "__main__":
    print get_longest(1000000)
