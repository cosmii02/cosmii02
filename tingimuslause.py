#Ül 2.1
'''
temp = float(input("Sisesta õhutemperatuur: "))
if temp >= 4:
    print ("Ei ole jäätumise ohtu")
else:
    print ("On jäätumise oht")
'''
#Ül 2.3
'''
nimi = input("Sisesta oma perenimi: ")
if nimi.endswith('ne'):
    print ("Abielus")
elif nimi.endswith("te"):
    print ("Vallaline")
elif nimi.endswith("e"):
    print ("Määramata")
else:
    print ("Pole ilmselt leedulanna perenimi")
'''

#Ül 2.4c
###
#inimesed=int(input("Sisesta inimeste arv: "))
#kohad= int(input("Sisesta kohtade arv: "))
peop = int(input("Inimeste arv: "))
bus  = int(input("Kohtade arv: "))

div  = round(peop / bus)

if (div <= 0) :
    print("busside arv: " + str(1))
else:
    print("palju busse vaja: " + str(div))
cal = round(peop % bus)
if (cal == 0):
    print("Viimases bussis olevate inimeste arv: " + str(bus))
else:
    print("Viimases bussis olevate inimeste arv: " + str(cal))
###

#if on kui, elif on juhul, else on siis
#if avaldis on: käsud, mis täidetakse, kui avaldis on tõene
#if avaldis on: mis täidetakse, kui avaldis_1 on tõene
#elif avaldis on: laused mis täidetakse, kui avaldis on väär, aga avaldis_2 on tõene
#else: laused, mis täidetakse, kui mõlemad avaldised on väärad
#if avaldis on: laused mis täidetakse, kui avaldis on tõene
#else: laused, mis täidetakse, kui avaldis on väär
#< > >= <= sobib arvude võrdlemiseks
#== tähistab võrdsust nii arvude kui ka sõnede puhul
#!= tähistab mittevõrdsust nii arvude kui ka sõnede puhul
#võrdlemad andmed peavad olema ühte tüüpi

'''
matemaatika_hinne=int(input("Sisesta hinne: "))
if matemaatika_hinne <= 2:
    print('lähen järeltööle ehk')
else:
    print('Olin tubli!')
'''
'''
a ="VIKK kutseõppekeskus"!="VIKK"+"Kutseõppekeskus"
b =0.1+0.1+0.1!=0.3
c ="Tartu"<"Tallinn"
print(a)
print(b)
print(c)
'''
#and (ja), or (või), not (eitus)
#Kasutatakse ka mitme avaldise korraga kontrollimiseks
#if avaldis laused mis täidetakse, kui mõlemad avaldised on tõesed
#if avaldis laused mis täidetakse, kui vähemalt üks on tõene
'''
pakutud_kood1=int(input("Sisesta esimene salakood: "))
kood1=1234
if pakutud_kood1==kood1:
    print("Juba poolel teel!")
else:
    print("Tsipa mõõda ei pannud?")
pakutud_kood2=int(input("Sisesta teine salakood: "))
kood2=4321
if pakutud_kood1==kood1 and pakutud_kood2==kood2:
    print("Seif avaneb dramaatiliselt")
else:
    print("Salakoodidega on veidi kehvasti. Tõstke käed üles!")
'''
#and, or ja not tehete tulemused:
#väide1 and väide2 - tõene ainult siis, kui mõlemad väited on tõesed
#väide1 or väide2 - tõene siis, kui vähemalt üks väidetest on tõene
#not väide1 - tõene ainult siis, kui väide1 on väär
#treppimine, taandamine (ingl identation)
#tühikute arvuga määratakse millised käsud kuuluvvad vastava tingimuslause osasse
#sama taseme taandega laused moodustavad ühe ploki/terviku
'''
x=int(input("Sisesta esimene arv: "))
y=int (input("Sisesta teine arv: "))

print("Arvude erinevus on " + str(abs(x-y)))
if x == y: #tingimus
    print("... järelikult on nad võrdsed")
'''
#abs on absoluut arv
#Lauses on tingimusi rohkem kui üks
#kasutatakse elif, else -harusid

'''
arv_tekstina=input('Palun sisesta mingi arv: ')
arv=float(arv_tekstina)
if arv < 0 :
    vastus=-arv
else:
    vastus=arv
'''
'''
arv1=int(input("Sisesta esimene arv: "))
arv2=int(input("Sisesta teine arv: "))

if arv1 > arv2:
    print("Esimene arv on suurem")
elif arv2 > arv1:
	print("Teine arv on suurem")
else:
   print("Arvud on võrdsed")
'''
'''
lyhend=input("Sisesta lühend: ")
if lyhend=="jne":
    tähendus="ja nii edasi"
elif lyhend=="tk":
    tähendus="tunnikontroll või tükk"
elif lyhend=="g":
    tähendus="gramm"
else:
    tähendus="Kahjuks selline lühend puudub meie andmebaasis"
    print(lyhend + " - " +tähendus)
'''