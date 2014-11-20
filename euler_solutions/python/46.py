from utils import fast_primes, fast_squares

import itertools



def has_match(n, dsquares, primes):
    for d in dsquares:
        
        if d < n:
            p = n - d
            if p in primes:
                return True



    return False


def main():
    primes = list(fast_primes(1000000))
    dsquares = [e*2 for e in fast_squares(1000000)]

    for n in itertools.count(2):
        if n % 2 == 1 and n not in primes:
            if not has_match(n, dsquares, primes):
                return n


if __name__ == "__main__":
    print main()        
