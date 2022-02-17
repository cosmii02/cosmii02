import random
import click

sodalane1 = 100
sodalane2 = 100
while True:
    isdamage= random.randint(0,1)
    if isdamage==1:
        sodalane2=sodalane2-20
        print ("Sõdalane 1 ründas teist sõdalast ja sõdalane 2 kaotas 20hp")
        print ("Sõdalane 1 elud: "+(str(sodalane1)))
        print ("Sõdalane 2 elud: " + (str(sodalane2)))
    elif isdamage==0:
        sodalane1=sodalane1-20
        print("Sõdalane 2 ründas teist sõdalast ja sõdalane 1 kaotas 20hp")
        print ("Sõdalane 1 elud: " + (str(sodalane1)))
        print ("Sõdalane 2 elud: "+(str(sodalane2)))
    if sodalane2<=0:
        print("\nMäng läbi, sõdalane 2 suri")
        break
    if sodalane1<=0:
        print("\nMäng läbi, sõdalane 1 suri")
        break
    if click.confirm('Kas tahad jätkata?', default=True):
        continue
    else:
        break