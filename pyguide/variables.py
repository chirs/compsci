#Variables

#same as js, ruby - there are no variables, just names that point to objects
#Objects: each thing is an object

x = 5
print x

x = "string"
print x

# Lists behavior.

la = lb = [1,2,3]
lc = [1,2,3]

la[0] = 0

assert( la[0] == 0 )
assert( lb[0] == 0 )
assert( lc[0] == 1 )


