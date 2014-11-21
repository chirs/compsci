#Scope

# closures

def foo():
    def bar():
        print a
    a = 1

foo()
# Returns nothing - needs a bar call in foo?
# What's the point of this?


# Hoisting 
# Does python even have hoisting?

def foo():
    print a
    a = 1

foo()
# throws UnboundLocalError

# hoisting (with closure)

def foo2():
    def bar():
        print a
    a = 1
    bar()

foo()
# Is this really hoisting? or run-time variable-checking?


def foo3():
    def bar():
        print a
    bar()
    a = 1

foo()
# NameError: free variable 'a' referenced before assignment in enclosing scope

# global keyword

# why this doesn't work
foo()
def foo():
    print "foo"

# NameError: name 'foo' is not defined
