from os import set_inheritable


elukoht='Paide'
sisestatud=input('Sisesta linna nimi? ')
if sisestatud==elukoht:
    print(elukoht.upper())
else:
    print(sisestatud.lower())