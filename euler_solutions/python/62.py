
import itertools


def cube_stream():
    for e in itertools.count():
        yield e**3




def get_digit_permutations(n):
    l = list(str(n))
    for p in itertools.permutations(l):
        n = int("".join(p))
        yield n


def get_cubes_in_permutations():
    pass



def answer():
    s = set()
    for n in cube_stream():
