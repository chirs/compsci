import itertools


def make_pair_filter(func):
    all_true = lambda l: reduce(lambda a,b: a and b, l, True)
    z = lambda n: zip(str(n), str(n)[1:])
    return lambda n: all_true([func(a, b) for a,b in z(n)])


def bouncy_stream():
    for e in itertools.count(1):
        if is_bouncy(e):
            yield e


is_increasing = make_pair_filter(lambda a,b: int(a) <= int(b))
is_decreasing = make_pair_filter(lambda a,b: int(a) >= int(b))
is_bouncy = lambda n: not (is_increasing(n) or is_decreasing(n))


def get_bouncy_proportion(proportion):
    nb = 0
    b = 0
    for e in itertools.count(1):
        if is_bouncy(e):
            b += 1
        else:
            nb += 1

        if nb * proportion == b:
            return e
    


if __name__ == "__main__":
    import time
    print "ANSWER %s" % 1587000
    start = time.time()
    for e in [2, 9, 20, 50,  99]:
        start = time.time()
        p = get_bouncy_proportion(e)
        end = time.time()
        print end - start
        print p

        
        
    
