



FRACTIONS = [
    (17, 91),
    (78, 85),
    (19, 51),
    (23, 38),
    (29, 33),
    (77, 29),
    (1, 17),
    (11, 13),
    (13, 11),
    (15, 2),
    (1, 7),
    (55, 1),
    ]
    


class Fraction(object):
    def __init__(self, numer, denom):
        self.numer = numer
        self.denom = denom


    def __repr__(self):
        return "%s/%s" % (self.number, self.denom)

class FractanException(Exception):
    pass


class Fractran(object):

    def __init__(self, seed, fractions):
        self.seed = seed
        self.fractions = fractions

        self._int = seed


    def test(self, fraction):
        for e in self.fractions:
            if (self._int * e.numer) % e.denom == 0:
                return (self._int * e.numer) / e.denom
        raise FractranException

    def next(self):
        n = self.test(self._int)
        self._int = n
        return n


def fractran_stream(seed, fractions):
    f = Fractran(seed, fractions)
    while True:
        yield f.next()


def two_root_prime_stream(stream):
    for e in stream:
        r = get_two_root(e)
        if r != -1:
            yield r


def get_two_root(n, i=0):
    if n == 1:
        return i
    else:
        if n % 2 == 0:
            return get_two_root(n/2,i+1)
        else:
            return -1
        

if __name__ == "__main__":
    import time
    fs = fractran_stream(2, [Fraction(a,b) for a,b in FRACTIONS])
    for e in two_root_prime_stream(fs):
        print e




