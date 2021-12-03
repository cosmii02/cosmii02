from math import pi
import math

from discord.ext.commands.errors import PartialEmojiConversionFailure
# Kommentaar jee
n = 7
a = 3*n
#print(a)

# mida iganes = 7
a = 3*n
#print(n+8)

#print("Hello world")
'''
a = 5
b = 3
a = 2
if (a < b) :
    print (a)
else:
    print(b)
    '''
# a on väiksem kui b seega prinditakse a, ning a väärtus on 2
'''
a = 5
b = 3
a = 2
if (a > b) :
    print (a)
else:
    print(b)
'''
# a ei ole suurem kui b seega kasutatakse funktsiooni "else" mis prindib alati tolle variandi kui if on false
'''
a = 5
b = 3
a = 2
if (a == b) :
    print (a)
else:
    print(a+b)
'''
# a ei ole sama mis b seega kasutatakse else funktsiooni, ning see prindib a+b vastuse
'''
a = 5
b = 3
a = 2
if (a < b) :
    print (a*4)
else:
    print(b)
# a on väiksem kui b seega prinditakse esimene if variant, ning too prindib a*4 vastuse
'''

'''
int() on täisarvude infokogum
string on jutt või sõna (tekstiandme tüüp)
'''

# print ("Tere, maailm!")
# Algoritm mat, on infolahenduseeskiri (Mõlemi osapoole poolt arusaadav juhend millegi jaoks)
# Algoritmil on alati 1 algus ja 1 lõpp
'''
b=2.5
c=2
print(b+c)
'''
'''
c=(5.4*2)
print(c)
'''
'''
x=int(5.4*2)
print(x)
'''
'''
a=3
b=8
c=2
if (a > b) and (a > c):
   largest = a
elif (b > a) and (b > c):
   largest = b
else:
   largest = c
print("Suurim arv on", largest)
# Võrdleb a ja b ning siis a ja c, siis teises reas elif võrdleb b ja a ja siis b ja c. Ning siis prindib suurima arvu
'''
'''
nums=(1,2,3)
print("Suurim arv on", max(nums))
'''
'''
today='paaris'
if today=='paaris':
    print("Pargi vasakule poole")
elif today=='paaritu':
    print("Pargi paremale poole")
else:
    print("Täna on koristuspäev ja parkida ei saa")
# Halvem versioon sellest
'''
'''
num = int(input("Mis päev täna on?: "))
if (num % 2) == 0:
   print("Pargi vasakule poole".format(num))
elif num==1:
    print('Täna on koristuspäev ja parkida ei saa')
else:
   print("Pargi paremale poole".format(num))
'''
# Matemaatiliselt parem lahendus
'''
_thonny='trash'
print(_thonny)
'''
'''
suur='trash'
print(suur)
'''
'''
print(int(math.ceil(4.2)))

max=2,3,4,5,6,7,8
#annab teada mis on suurim arv jadas
'''