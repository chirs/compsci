import random

# Functions
#---------


# splats? what are these called?
# *args

def foo(*args):
    print args

foo(1, 2)
foo()

foo(1, a=1) # TypeError: foo() got an unexpected keyword argument 'a'

# **kwargs

def foo(**kwargs):
    print kwargs

# splatting of each

foo(a=1, b=2)
foo()

foo(1, a=1) # TypeError: foo() takes exactly 0 arguments (2 given)


# default arguments are evaluated once, on function definition

a = 1
def foo(la=a):
    print la


def foo2(r=random.random())
    return r

foo2() == foo2()



def fib(n, cache={}):
    print cache
    if n == 0: return 0
    if n == 1: return 1
    if n in cache:
        return cache[n]
    r = fib(n-1) + fib(n-2)
    cache[n] = r
    return r


#function objects can have stuff tacked on, just like most objects
def foo(): return None
foo.a = 4
# but function code doesn't have access to it

# investigate writing our own obj w __call__
# Functions are just objects that have a __call__ method (which makes the foo() syntax work),
# and you can write your own objects with __call__ methods

# Higher order functions, decorators
# what functools.wraps, functools.decorator do



#"Operator Overloading"
#----------------------

# implement custom dictionary or custom list using __fns__
# know a good portion of the double underscore methods
