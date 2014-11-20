from itertools import permutations


def get_perm_number(l, n):

    for i, e in enumerate(permutations(l), start=1):
        if i == n:
            return e

    import pdb; pdb.set_trace()
    pass


if __name__ == "__main__":
    print "".join([str(e) for e in get_perm_number(range(10), 10**6)])
        
        
