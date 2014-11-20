
import itertools

from utils import fast_prime_stream

#consecutive should start =[2, 5, 10, 17]

class PrimeException(Exception):
    pass



def prime_list(n_max):
    return [e for e in fast_prime_stream(n_max)]


def make_is_prime(n_max):
    s = set(prime_list(n_max))
    return lambda n: n in s

    
def longest_prime_as_sum(n_max):

    l = [e for e in consecutive_prime_sum_stream(n_max)]
    m = [e for e in l if is_prime(e)]
    print l
    print m


def most_steps_under(n_max):
    ms = 0
    mn = None
    for n, steps in consecutive_prime_sum_stream(n_max):
        if steps > ms:
            mn = n, 
            ms = steps
    return mn, ms
        

def consecutive_prime_sum_stream(n_max):

    pl = prime_list(n_max)
    is_prime = make_is_prime(n_max)

    def stream_for_number(i):
        sum = 0
        length = 0
        index = pl.index(i)
        for e in pl[index:]:
            sum += e
            length += 1
            if sum >= n_max:
                return
            else:
                if is_prime(sum):
                    yield (sum, length)

    for e in pl:
        for s in stream_for_number(e):
            yield s





if __name__ == "__main__":
    print most_steps_under(10 ** 2)
    print most_steps_under(10 ** 3)
    print most_steps_under(10 ** 4)
    print most_steps_under(10 ** 5)
    print most_steps_under(10 ** 6)
    """
    import time
    start = time.time()
    stream = consecutive_prime_sum_stream(10 ** 6)
    print len(list(stream))
    print time.time() - start
    """
    
    


