from utils import primes_generator

def sum_primes(maximum):
    s = 0
    for e in primes_generator():
        if e < maximum:
            s += e
        else:
            return s


if __name__ == "__main__":
    sum_primes(2000000)
        
        
    
