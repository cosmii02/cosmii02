# Ul 1
'''
i=1
while i<5:
    print(i)
    i = i + 1
'''
# Ul 2
'''
j = 1
while j<=4:
    print("Tere!")
    j*=2
print(j)
'''
# Ul 3
'''
i=0
while i<1:
    print("Tere!")
'''
# Ul 4
'''
k=0
while k<3:
    print("Tere!")
    k+=1
    print(k)
'''
'''
#Ul 5
from turtle import *

i=0
while i<3:
    forward(100)
    left(120)
    i+=1

exitonclick()
'''
'''
#Ul 6
from turtle import *

i=1
while i<7:
    forward(50*i)
    left(90)
    i+=1

exitonclick()
'''
'''
#Ul7
i=0
summa=0
while i<5:
    summa+=i
    i+=1
print(summa)
'''

'''
# Ul 8
i=0
summa=0
while summa<5:
    summa+=i
    i+=1
print(1)
'''
#'''
# Ul 9
from time import sleep
kood=""
katseid=3
while kood !="123" and katseid >0:
    kood=input("Sisesta kood: ")
    katseid-=1
    if kood == "123":
        print("Õige kood: ")
else:
    print("Vale kood")
    i=3
    while i<0:
        print(i)
        i-=1
        sleep(1)
    print("Lõpp")
#'''