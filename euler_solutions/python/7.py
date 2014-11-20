from utils import primes_generator


def get_prime(n):
    for i, prime in enumerate(primes_generator(),
                              start=1):
        if i == n:
            return prime



                
    
if __name__ == "__main__":
    get_prime(1001)
