from utils import fast_primes



def rotate(s):
    return s[1:] + s[0]


def rotations(s):
    rotations = set([s])
    n = s
    while True:
        n = rotate(n)
        if n in rotations:
            return rotations
        else:
            rotations.add(n)
        
    
    

def check_circular(n, prime_set):
    s = str(n)
    for e in rotations(s):
        if int(e) not in prime_set:
            return False
    return True

def check_circulars(limit):
    primes = set(fast_primes(limit))
    circulars = set()
    for prime in primes:
        if check_circular(prime, primes):
            circulars.add(prime)
    return sorted(circulars)
        



if __name__ == "__main__":
    print len(check_circulars(100))
    c = check_circulars(1000000)
    print c
    print len(c)
    

