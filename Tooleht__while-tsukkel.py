#Ül 2
"""
import turtle
#Turtle shape :)
turtle.shape("turtle")

#Ruut
for i in range(4):
    turtle.forward(90)
    turtle.left(90)
"""

#Ül 3

"""
import time

def aeg(t):
    
    while t:
        minut, sekund = divmod(t, 60)
        taimer = '{:02d}:{:02d}'.format(minut, sekund)
        print(taimer, end="\r")
        time.sleep(1)
        t -= 1
    
    print('Aeg on läbi!')

t = input("Sisesta aeg sekundites: ")
aeg(int(t))
"""

#Ül 4

"""
while True: 
	try: 
		number1 = int(input("Sisestage esimene number: ")) 
		assert(number1 > 0)
		break 
	except: 
		print("Number ei tohi olla negattivne :)") 

while True: 
	try: 
		number2 = int(input("Sisestage teine number: ")) 
		assert(number2 > 0) 
		break 
	except: 
		print("Number ei tohi olla negatiivne :)") 

arvu_seis = 0

for i in range(1, number2 + 1):
    arvu_seis = arvu_seis + number1

print("Vastus on:",arvu_seis)
"""

#Ül 5
"""
import random
sisestus = 0
suvaline_arv = random.randint(1, 20)
prv_katseid = int(input("Sisesta, mitu katset soovid (5 is default):"))
for i in range(prv_katseid):
    arvatud_number = int(input('Sisesta number: '))
    if arvatud_number != suvaline_arv:
        prv_katseid = prv_katseid - 1

#Liiga suur, liiga väike.
    if arvatud_number > suvaline_arv:
        print("Arv, mille sisestasid on liiga suur.")
    if arvatud_number < suvaline_arv:
        print("Arv, mille sisestasid on liiga väike.")
#Vastused.        
    if arvatud_number == suvaline_arv:
        print("Sa võidsid!")
        break
    elif prv_katseid == 0:
        print("Katsed said otsa, proovi uuesti!")
        break
    else:
        print(f"Proovi uuesti! {prv_katseid} jäänud")
"""

