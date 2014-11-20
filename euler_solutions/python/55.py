import itertools


class LychelException(Exception):
    pass

lychel_step_dict = {}

def reverse_number(n):
    return int(str(n)[::-1])

def num_is_palindrome(n):
    return is_palindrome(str(n))

def is_palindrome(s):
    if len(s) in (0, 1):
        return True
    else:
        return (s[0] == s[-1]) and is_palindrome(s[1:-1])


def lychel_steps(n, max_step=50):
    if max_step == 0:
        raise LychelException
    
    if num_is_palindrome(n):
        return 0
    else:
        o = n + reverse_number(n)
        if o in lychel_step_dict:
            return lychel_steps[o]
        else:
            r = 1 + lychel_steps(o, max_step-1)
            lychel_step_dict[0] = r
            return r

def is_lychel(n):
    try:
        b = lychel_steps(n)
        return True
    except LychelException:
        return False

def not_lychel_stream(n=0):
    for e in itertools.count(1):
        if not is_lychel(e):
            yield e
        if e == n:
            return


def lychel_below(n):
    return sum([1 for e in not_lychel_stream(10000)])
        


if __name__ == "__main__":
    print lychel_below(10000)













    
