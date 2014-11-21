# Descriptors
# -----------

# maybe save descriptors for the end

# (interesting, but many people don't know this and don't need to)

# it's sometimes useful to override what gets returned upon attribute lookup -
# if the object getting looked up implements __get__ or __set__,
# then different things will happen on attribute lookup when it gets got.

# object.__get__(self, instance, owner)
# object.__set__(self, instance, value)
# object.__delete__(self, instance)

# This is different from overloading __getattr__ because that affects how lookup works
# on the object to the left of the dot in `obj.att` - descriptors customize what gets
# returned from this by overriding a method on .att

#Application of descriptors
#--------------------------

# @staticmethod vs @classmethod

class Foo(object):

    @staticmethod
    def a(foo):
        print foo

    @classmethod
    def b(foo):
        print foo



#@property

# 1

class Foo(object):
    def a(self):
        return self.a

print Foo().a()

# 2

class Foo(object):
    @property
    def a(self):
        return self.a

print Foo().a # dive into why

# 3

class Foo(object):
    @property
    def a(self):
        return self._a

print Foo().a

# 4

class Foo(object):
    def __init__(self):
        self._a = None

    @property
    def a(self):
        return self._a

print Foo().a
print Foo().a = 20

# 5

class Foo(object):
    def __init__(self):
        self._a = None

    @property
    def a(self):
        return self._a

    @a.setter
    def a(self, value):
        self._a = value * 2


print Foo().a = 20
