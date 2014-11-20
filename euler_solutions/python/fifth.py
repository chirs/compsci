import itertools



def make_power_map(power):
    m = {}
    for e in range(10):
        m[e] = e ** power
    return lambda k: m[k]

fourth_map = make_power_map(4)
fifth_map = make_power_map(5)


def make_power_sum(power_map):
    return lambda n: sum([power_map(int(e)) for e in str(n)])


def match_stream(power_sum, n=None):
    for e in itertools.count(2):
        if power_sum(e) == e:
            yield e

        if n and n < e:
            return


if __name__ == "__main__":
    l = [e for e in match_stream(make_power_sum(fifth_map), 1000000)]
    print l
    print sum(l)
          




