import itertools

#Generators
#----------

#Iteration - see http://nedbatchelder.com/text/iter.html

#Special syntaxes:
# follow through execution below:

def foo(x):
    while True:
        x += 1
        yield x

def foo2(x):
    for e in itertools.count(x):
        yield x

# (x for x in xrange(10000000000))

# How to chain generators to make every for loop you ever write very simple, and get lazy evaluation

# for item in unique(objectized(fileobj)):
#     print item
