import itertools

from utils import fast_prime_stream, fast_prime_posneg_stream, product


def triple_stream():
    # This will not generate all triples.
    # Need to multiply these by a constant to generate all.
    for a in itertools.count(2):
        for b in range(2, a):
            # Euclid's formula
            yield (a**2 - b**2, 2*a*b, a**2 + b**2)


def triple_children(t):
    for e in itertools.count(1):
        yield map(lambda n: n * e, t)



if __name__ == "__main__":
    for t in triple_stream():
        for c in triple_children(t):
            s = sum(c)
            if s == 1000:
                print c
                print product(c)
            if s > 1000:
                break
