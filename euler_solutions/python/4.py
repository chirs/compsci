from itertools import permutations

def is_palindrome(s):
    if len(s) <= 1:
        return True
    else:
        if s[0] == s[-1]:
            return is_palindrome(s[1:-1])
        else:
            return False


def perms():
    for a, b in permutations(range(100, 1000), 2):
        yield a * b


def find_max():
    return max([e for e in perms() if is_palindrome(str(e))])
    
    

    
