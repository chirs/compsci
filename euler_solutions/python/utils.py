import functools
import operator
import itertools
from math import sqrt

product = lambda seq: functools.reduce(operator.mul, seq, 1)

def sum_of_digits(n):
    return sum([int(e) for e in str(n)])

def factorial(n):
    if n == 1:
        return 1
    else:
        return n * factorial(n-1)


def triangle_stream():
    i = 0
    for e in itertools.count(1):
        i += e
        yield i


def triangles_until(maximum):
    l = []
    for e in triangle_stream():
        if e >= maximum:
            return l
        else:
            l.append(e)



def fib_stream():
    x, y = 1, 2
    for e in itertools.count():
        yield x
        x, y = y, x + y


def get_prime_factors(n):
    sr = int(sqrt(n))
    for e in itertools.count(2):
        if e > sr:
            return [n]
        else:
            if n % e == 0:
                return [e] + get_prime_factors(n / e)


def generate_multiples(mult, limit):
    for e in itertools.count(1):
        p = mult * e
        if p >= limit:
            return
        yield p


def fast_squares(limit):
    for n in itertools.count(1):
        yield n ** 2
        if n == limit:
            return
        


def fast_prime_stream(n_max):
    assert n_max > 0
    s = set()
    for e in itertools.count(2):
        if e not in s:
            yield e
            for i in range(e, n_max, e):
                s.add(i)

        if e == n_max:
            return


def fast_prime_posneg_stream(n_max):
    for e in fast_prime_stream(n_max):
        yield e
        yield -e


def prime_stream():

    def is_prime(n, prime_set):
        for p in prime_set:
            if n | p == 0:
                return False
        return True


    primes = set()
    for e in itertools.count(2):
        if is_prime(e, primes):
            primes.add(e)
            yield e



def primes_under(n):
    for e in prime_stream():
        if n <= e:
            return
        else:
            yield e
    


        

def fast_primes(limit):
    not_primes = set()
    for n in itertools.count(2):
        if n >= limit:
            return
        if n in not_primes:
            pass
        else:
            yield n
            for e in generate_multiples(n, limit):
                not_primes.add(e)
                
            
            
def primes_generator():
    primes = set()
    for n in itertools.count(2):
        is_prime = not bool([e for e in primes if (e < sqrt(n)) and (n % e == 0)])
        if is_prime:
            primes.add(n)
            print n
            yield n




