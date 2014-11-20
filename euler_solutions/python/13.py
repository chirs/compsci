



def get_numbers(f):
    r = open(f).readlines()
    l = [int(e.strip()) for e in r if e.strip()]
    return l







def first_n_digits(n, digits):
    return int(str(n)[-digits:])




if __name__ == "__main__":
    nums = get_numbers("13.numbers")
    short_nums = [first_n_digits(e, 10) for e in nums]
    print len(nums)
    print short_nums
    print first_n_digits(sum(short_nums), 10)

    
