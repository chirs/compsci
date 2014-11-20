from magic_number import to_string




if __name__ == "__main__":
    s = 0
    for num in range(1, 1001):
        letters = to_string(num).replace(" ", "")
        s += len(letters)
    print s
    
