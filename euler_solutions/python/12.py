import itertools
from utils import get_prime_factors, triangle_stream


product = lambda lx: reduce(lambda a,b: a * b, lx, 1)


def divisors(n):
    prime_factors = get_prime_factors(n)
    s = set(prime_factors)
    l = [prime_factors.count(e) for e in s]
    lx = [e + 1 for e in l]
    return product(lx)
    



def get_first_over(divisor_num):
    for e in triangle_stream():
        if divisors(e) > divisor_num:
            return e
        
    
if __name__ == "__main__":
    for e in triangle_stream():
        if divisors(e) > 500:
            print e
            break
