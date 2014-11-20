from collections import defaultdict


import sys
import itertools

from utils import get_prime_factors



def get_prime_factor_tuples(n):
    d = defaultdict(int)
    for e in get_prime_factors(n):
        d[e] += 1
    return sorted(d.items(), key=lambda e: e[0])



def get_divisors_from_prime_factors(prime_factor_tuples):
    if len(prime_factor_tuples) == 0:
        return [1]
    else:
        num, power = prime_factor_tuples[0]
        divisors = [num ** e for e in range(0, power+1)]
        other_divisors = get_divisors_from_prime_factors(prime_factor_tuples[1:])
        return sorted([a*b for (a,b) in itertools.product(divisors, other_divisors)])



def get_divisors(n):
    return get_divisors_from_prime_factors(get_prime_factor_tuples(n))



def amicable_number_stream(maximum):
    d = {}
    sd = defaultdict(set)
    for e in xrange(1, maximum+1):
        d[e] = get_divisors(e)
    for k, v in d.items():
        sd[sum(v)].add(k)

    for e in sd.values():
        
        if len(e) > 1:
            for n in e:
                yield n

    
        
if __name__ == "__main__":
    print sorted([e for e in amicable_number_stream(10000)])


