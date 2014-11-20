from utils import fib_stream


get_digits = lambda n: len(str(n))

def find_fib_with_digits(n):
    i = 0
    for f in fib_stream():
        if get_digits(f) == n:
            return f


if __name__ == "__main__":
    import pdb; pdb.set_trace()
    print find_fib_with_digits(1000)
