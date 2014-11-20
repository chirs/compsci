import itertools

from utils import get_prime_factors


n = "1_2_3_4_5_6_7_8_9_0".replace("_", "%s")


def create_number(l):
    import pdb; pdb.set_trace()
    return int(n.format(l))


def main():
    for e in itertools.product('0123456789', repeat=9):
        nums = [int(s) for s in e]
        num = create_number(nums)
        print get_prime_factors(num)
    


if __name__ == "__main__":
    main()

