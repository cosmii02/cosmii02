import random
import click
sodalane1=1
sodalane2=2
isdamage= random.randint(0,1)
if isdamage==1:
    sodalane2-20
    print ("Sõdalane 1 ründas teist sõdalast ja sõdalane 2 kaotas 20hp")
    print ("Sõdalane 1 elud: 100 \nSõdalane 2 elud: 80")
elif isdamage==0:
    sodalane1-20
    print ("case2")
if click.confirm('Do you want to continue?', default=True):
    rdmg