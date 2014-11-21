import datetime

#Modules
#-------

# Explore import here also.
# modules are singleton objects - they get loaded into sys.modules once

datetime.a = 4

# What's going on here?

from datetime import a
print a # 4

#packages

#TOM: ?

#Or of course if you do the import yourself with __import__ or imp.load_module or something else under the hood
