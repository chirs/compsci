#!/usr/bin/python

"""
This is a representation of a game (what type?)


"""

base = {
    0: "",
    1: "one",
    2: "two",
    3: "three",
    4: "four",
    5: "five",
    6: "six",
    7: "seven",
    8: "eight",
    9: "nine",
    10: "ten",
    11: "eleven",
    12: "twelve",
    13: "thirteen",
    14: "fourteen",
    15: "fifteen",
    16: "sixteen",
    17: "seventeen",
    18: "eighteen",
    19: "nineteen",
}

tens = ['',
        '',
        'twenty',
        'thirty',
        'fourty',
        'fifty',
        'sixty',
        'seventy',
        'eighty',
        'ninety',
        ]

large = [
    '',
    'thousand',
    'million',
    'billion',
    'trillion',
    'quadrillion',
    'quintillion',
    'sextillion',
    ]

class MagicNumber(object):

    def __init__(self, n):
        self.n = n
        self.ns = str(n)
        
    def split_number(self):
        ns = self.ns[::-1] #Reverse string
        l = []
        while ns:
            n = ns[:3][::-1]
            l.append(n)
            ns = ns[3:]
        return l

    def as_string(self):
        l = []
        for i, e in enumerate(self.split_number()):
            l.append(large[i])
            l.append(self.block_name(e).strip())
        l.reverse()
        l = [e for e in l if e]
        return " ".join(l)

    def block_name(self, block):
        block = str(block)
        if len(block) == 3:
            b1 = int(block[0])
            if b1 == 0:
                return self.block_name(block[1:])
            else:
                return "%s hundred %s" % (base[b1], 
                                          self.block_name(block[1:]))
        elif len(block) == 2:
            b = int(block)
            if b in base:
                return base[b]
            else:
                b1 = int(block[0])
                b2 = int(block[1])
                return "%s %s" % (tens[b1], base[b2])
        else:
            return base[int(block)]


def to_string(n):
    return MagicNumber(n).as_string()
        
def magic_number(n):
    return len(MagicNumber(n).as_string().replace(" ", ''))


