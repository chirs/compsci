from utils import fast_primes






def is_left_truncatable(s, prime_set):
    if s == '':
        return True
    else:
        return int(s) in prime_set and is_left_truncatable(s[1:], prime_set)
        

def is_right_truncatable(s, prime_set):
    if s == '':
        return True
    else:
        return int(s) in prime_set and is_right_truncatable(s[:-1], prime_set)


def is_lr_truncatable(s, prime_set):
    return is_left_truncatable(s, prime_set) and is_right_truncatable(s, prime_set)


    
def find_truncatable():
    t = []
    l = list(fast_primes(10 ** 6))
    for e in l:
        if is_lr_truncatable(str(e), l):
            if e > 10:
                print e
                t.append(e)
        if len(t) == 10:
            return sum(t)


if __name__ == "__main__":
    #prime_set = list(fast_primes(10 ** 4))
    #print is_lr_truncatable(str(3797), prime_set)
    print find_truncatable()
        
        
        

