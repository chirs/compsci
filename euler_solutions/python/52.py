import itertools



def get_digits(n):
    s = str(n)
    return sorted(s)


def check_equal(n):
    d = get_digits(n)
    for e in [2,3,4,5,6]:
        if get_digits(n * e) != d:
            return False
    return True


if __name__ == "__main__":
    for e in itertools.count():
        if check_equal(e):
            print e
