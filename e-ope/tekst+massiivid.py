#################
# Teksti korrutamine
#################
print ("-" * 80)
#################
# Paroolisisestus
#################
from getpass import getpass
parool=getpass("Sisesta parool: ")
if parool=="kala":
   print ("Hei!")
else:
   print ("Nuputa veel")