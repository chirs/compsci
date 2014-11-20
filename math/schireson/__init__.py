# Solution to problem posted here:
# http://maxschireson.com/2011/04/23/want-a-job-working-on-mongodb-your-first-online-interview-is-in-this-post/

import random

def make_list(n):
    extra = random.randint(1, n)
    missing = random.randint(1, n)
    i = 1
    while i <= n:

        if i == missing:
            yield extra
        else:
            yield i
        i += 1

    print "extra %s" % extra
    print "missing %s" % missing
    

def get_sum(n):
    return n * (n + 1) / 2


def solve(n):
    list_sum = 0
    list_prod = 1.0
    for i, e in enumerate(make_list(n)):
        list_sum += e
        list_prod *= e
        list_prod /= i + 1

    diff = list_sum - get_sum(n)

    print "list_prod %s" % list_prod
    print "diff %s" % diff


    for e in range(1, n+1):
        extra = float(e + diff)
        d = extra / diff
        if abs(extra / e - list_prod) < .00000000001:
            print "extra: %s, missing: %s" % (extra, e)

        


