#!/usr/bin/env python

import time

class AppendException(Exception):
    pass

def generate_strings(char_list, length):
    """Generate all strings of length n containing the characters
    in char_list"""
    if length <= 0:
        yield []
    elif length == 1:
        for char in char_list:
            yield [char]
    else:
        for char in char_list:
            for l in generate_strings(char_list, length-1):
                yield [char] + l

def generate_string_list(char_list, length):
    """Return a list instead of a generator"""
    return [e for e in generate_strings(char_list, length)]


def minimum_length(char_list, length):
    """
    The minimum possible length for a solution. This is The length of a base string
    plus one for each possible combination of characters, minus one (overcounting first string.
    """
    return len(char_list)**length + length - 1


# Greedy algorithm for finding the shortest possible string.
# Surprisingly, this seems to work. The shortest string is always
# the shortest possible string.    

def find_match(lists, base):
    """
    Find a list which can be added to the base list. 
    e.g. [0,1,1] and [1,0,1] could be added to [1,1,0],
    on the left and right end, respectively, but [0,0,1] could not.
    """
    match_length = len(lists[0]) - 1
    left_end = base[:match_length]
    right_end = base[-match_length:]
    for l in lists:
        if l[1:] == left_end:
            return l
        elif l[:-1] == right_end:
            return l
        else:
            pass
        
def add_string(l, base):
    """
    Add a string to the list by appending it to the front or back.
    e.g. [0,0,1] added to [0,1,1,1] would yield [0,0,1,1,1]
    """

    match_length = len(l) - 1
    left_end = base[:match_length]
    right_end = base[-match_length:]
    if l[1:] == left_end:
        return [l[0]] + base
    elif l[:-1] == right_end:
        return base + [l[-1]]
    else:
        raise AppendException


def generate_greedy(lists):
    """Greedily generate a single list containing all the provided lists
    as sublists."""
        
    def greedy_step(lists, base=[]):
        """Add a single item from the list of strings to the base list."""
        lists_copy = lists[:]
        if base == []:
            # Start with any string
            s = lists_copy.pop()
        else:
            l = find_match(lists_copy, base)
            s = add_string(l, base)
            lists_copy.remove(l)
        return lists_copy, s

    # This is probably nicer if it's recursive?
    base = []
    while lists:
        lists, base = greedy_step(lists, base)
    return base


def solve(chars, length):
    """
    Provided a list of characterss and a length, solves the problem.
    e.g. solve([0,1], 2) => 00110
    """
    return generate_greedy(generate_string_list(length, chars))
        

# Brute force method for finding correct strings.
# This is only useful for very small strings.

def check_string(s, strings):
    """Check to see if a string is contained in the base string."""
    for string in strings:
        if string not in s:
            return False
    return True

def find_string(n, c_length, start=None):
    """
    Starting with strings of the minimum possible length for a given character list,
    generate all possible strings. Check all of these strings to see if they contain
    all the required character combinations."""
    
    c = range(c_length)
    if start is None:
        i = get_minimum(n)
    else:
        i = start

    strings = [e for e in generate_strings(n, c)]
    while True:
        for x, s in enumerate(generate_strings(i, c)):
            if check_string(s, strings):
                return s

            if x % 1000000 == 0:
                print x
        i += 1
        print "processing %s" % i

def find_string_and_get_time(n, c):
    start = time.time()
    s = find_string(n, c)
    end = time.time()
    return s, end - start

def print_answer(n, c):
    s, t = find_string_and_get_time(n, c)
    print "%s: %s [%s] (%s seconds)" % (n, s, len(s), t)

    
    
