import itertools
from collections import defaultdict

from utils import get_prime_factors, product


def get_factor_set(factor_lists):
    s = set()
    for l in factor_lists:
        for char in l:
            s.add(char)
    return s

def get_lcm(l):
    factor_lists = [get_prime_factors(e) for e in l]
    factors = get_factor_set(factor_lists)
    d = defaultdict(int)
    for factor in factors:
        for fl in factor_lists:
            if fl.count(factor) > d[factor]:
                d[factor] = fl.count(factor)
    return product([k**v for k,v in d.items()])
        
            
if __name__ == "__main__":
    print get_lcm(range(1,20))
