
from math import sqrt

import itertools


def is_square(n):
    return (int(sqrt(n)) ** 2) == n




def get_diophantine(x):
    for a in itertools.count(2):
        if a == x:
            return -1
        ls = a ** 2 - 1
        if ls % x == 0:
            b = ls / x
            if is_square(b):
                return (a,int(sqrt(b)))


def show_diophantine(n):
    a, b = get_diophantine(n)
    print "%s**2 - %s * %s**2 == 1" % (a, n, b)
    print "%s - %s * %s == 1" % (a ** 2, n, b ** 2)
    print "%s - %s == 1" % (a ** 2, n * (b ** 2))



def dio_stream(max):
    for e in itertools.count(2):
        if e == max:
            return
        if not is_square(e):
            if get_diophantine(e) != -1:
                yield e
            
        
if __name__ == "__main__":

    max_a = 0
    max_e = None
    for e in dio_stream(1001):
        print e
        a, b = get_diophantine(e)
        if a > max_a:
            max_a = a
            max_e = e
            print max_e

    print max_e
    print get_diophantine(max_e)
    print show_diophantine(max_e)
            
