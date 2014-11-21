
#classes, inheritance
#--------------------

# new-style vs old-style classes
# new-style classes were introduced in Python 2.2 to unify classes and types


# I would really like to see any demonstration of this difference.
# What version?

# class attributes

class Foo(object):

    a = 1
    b = a + 1

    def bar(self):
        c = a + b  #what error do you get here? (NameError)

    def baz(self):
        c = self.a + Foo.b

# Using `type` to create classes

# ?

# Python is all about attribute lookup - that's what makes everything tick

# ?

# Class Decorators

# ?


# Types in general.
