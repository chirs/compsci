import itertools

from utils import fib_stream


def get_sum(n):
    s = 0
    for e in fib_stream():
        if e >= n:
            return s
        else:
            if e % 2 == 0:
                s += e



if __name__ == "__main__":
    print get_sum(4000000)
