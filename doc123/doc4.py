from turtle import*
import turtle
import random
import math
######### ül1
'''
sis=int(input("Sisesta kuu: "))
if sis==1:
    print("Jaanuar")
if sis==2:
    print("Veebruar")
if sis==3:
    print("Märts")
if sis==4:
    print("Aprill")
if sis==5:
    print("Mai")
if sis==6:
    print("Juuni")
if sis==7:
    print("Juuli")
if sis==8:
    print("August")
if sis==9:
    print("September")
if sis==10:
    print("Oktoober")
if sis==11:
    print("November")
if sis==12:
    print("Detsember")
elif sis<1:
    print("Kardan et olete joonud")
elif sis>12:
    print("Kardan et olete joonud")
'''
######## ül2
'''
kuud = ["jaanuar", "veebruar", "märts", "aprill", "mai", "juuni", "juuli", "august", "september", "oktoober", "november", "detsember"]
sood = ["mees", "naine", "mees", "naine", "mees", "naine", "mees", "naine"]
isikukood = input("Sisestage oma isikukood: ")

# pikkuse kontroll..
# noinspection PyInterpreter
if len(isikukood) == 11:
    # Eeldatav kontrollkood:
    # esimene järk..
    esimeneJark = ((int(isikukood[0])*1) + (int(isikukood[1])*2) + (int(isikukood[2])*3) +
                   (int(isikukood[3])*4) + (int(isikukood[4])*5) + (int(isikukood[5])*6) +
                   (int(isikukood[6])*7) + (int(isikukood[7])*8) + (int(isikukood[8])*9) + (int(isikukood[9])*1)) % 11
    # teine järk, kui jääk = 10..
    if esimeneJark == 10 :
        esimeneJark = ((int(isikukood[0])*3) + (int(isikukood[1])*4) + (int(isikukood[2])*5) + (int(isikukood[3])*6) +
                       (int(isikukood[4])*7) + (int(isikukood[5])*8) + (int(isikukood[6])*9) + (int(isikukood[7])*1) +
                       (int(isikukood[8])*2) + (int(isikukood[9])*3)) % 11
    # kas sisestatud == arvutatud..
    if esimeneJark == int(isikukood[10]) :
        # soo määramine
        for sugu in sood :
            sugu = int(isikukood[0])
            sooNimi = sood[sugu - 1]
        # kas soo väärtus on õige..
        if int(isikukood[0]) <= 8 and int(isikukood[0]) >= 1 :
            # paneme aasta paika..
            if int(isikukood[0]) == 1 or int(isikukood[0]) == 2 :
                aasta = "18" + str(isikukood[1] + isikukood[2])
            if int(isikukood[0]) == 3 or int(isikukood[0]) == 4 :
                aasta = "19" + str(isikukood[1] + isikukood[2])
            if int(isikukood[0]) == 5 or int(isikukood[0]) == 6 :
                aasta = "20" + str(isikukood[1] + isikukood[2])
            if int(isikukood[0]) == 7 or int(isikukood[0]) == 8 :
                aasta = "21" + str(isikukood[1] + isikukood[2])
         # leian kuu väärtuse ja määran kuu nime
            for kuuNimi in kuud :
                kuu = int(isikukood[3] + isikukood[4])
                kuuNimi = kuud[kuu - 1]
         # kas kuu on korrektne..
            if kuu >= 1 and kuu <= 12 :
                        # leian päeva väärtuse
                        paev = int(isikukood[5] + isikukood[6])
                        # kontrollin päeva korrektsust..
                        if paev >= 1 and paev <= 31 :
                            # järjekorra määramine, et saaks tekstina väljastada..
                                # Tekst
                            print("Tervist, oled " + sooNimi + ". Sündisid aastal " + aasta + ", sinu sünnipäev on " + str(paev) + ". " + kuuNimi + ".")   
                        else : # kui päeva väärtuse kontroll nurjub..
                            print("Ebakorrektne päeva väärtus. Proovi uuesti!")
            else : # kui kuu väärtuse kontroll nurjub..
                print("Ebakorrektne kuu väärtus. Proovi uuesti!")
        else : # kui soo tunnuse kontroll nurjub..
            print("Ebakorrektne soo tunnus. Proovi uuesti!")
    else : # kui kontrollkoodi väärtuse kontroll nurjub..
        print("Ebakorrektne kontrollkoodi väärtus. Proovi uuesti!")
else : # Kui pikkuse kontroll nurjub - veateade..
    print("Ebakorrektne sisend. Proovi uuesti!")
'''            
######## ül3

######## ül4

######## ül5
# Taking Inputs
lower = int(input("Mis numbrist alates:- "))
 
# Taking Inputs
upper = int(input("Kuni mis numbrini:- "))
 
# generating random number between
# the lower and upper
x = random.randint(lower, upper)
print("\n\tSul on ainult ",
       round(math.log(upper - lower + 1, 2)),
      " võimalust arvata ära number!\n")
 
# Initializing the number of guesses.
count = 0
 
# for calculation of minimum number of
# guesses depends upon range
while count < math.log(upper - lower + 1, 2):
    count += 1
 
    # taking guessing number as input
    guess = int(input("Arva numbrit:- "))
 
    # Condition testing
    if x == guess:
        print("Õnnitlused sa tegid selle ",
              count, " korraga")
        # Once guessed, loop will break
        break
    elif x > guess:
        print("Sinu pakkumine oli liiga väike!")
    elif x < guess:
        print("Sinu pakkumine oli liiga kõrge!")
 
# If Guessing is more than required guesses,
# shows this output.
if count >= math.log(upper - lower + 1, 2):
    print("\nNumber on %d" % x)
    print("\tRohkem õnne järgmine kord!")
 
######## ül6
from turtle import*
import turtle

hideturtle()
s=int(input("Sisesta külje pikkus: "))
h=int(input("Sisesta kõrgus: "))
forward(s)
left(90)
forward(h)
left(90)
forward(s)
left(90)
forward(h)
penup()
left(180)
forward(h)
pendown()
right(30)
forward(s)
right(120)
forward(s)
exitonclick()