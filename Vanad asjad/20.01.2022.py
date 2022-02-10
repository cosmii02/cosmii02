#While on korduv tsükkel
#sokolaadi tükikeste söömine kuni tahvel otsa saab
#iga päevaselt: äratus kell --> riidesse --> sööma --> kooli
#vähendab töömahtu
#eelkontrolliga tsükkel
#teeb tsüklisse kirjutatud tegevusi/käske nii kaua kuni tingimus on tõene
#while tingimus 
#   <lause 1>
#   <lause 2>
#If-lause ja While-tsükkel
#SARNASUS
#kehas olevad käske täidetakse vaid siis, kui päises olev tingimus kehtib e. tsüklisse minnakse, siis kui tingimus on tõene
#ERINEVUS
#kui kehas olevad lause(d) on täidetud, siis minnakse uuesti päises näidatud tingimust kontrollima
#Iga muutuja viitab ühele pesale või lahtrile kusagil Pythoni sisemuses olevas tabelis e.
##################
'''
salasõna="Programmeerimine123"
sisestus=""
while sisestus != salasõna:
    sisestus=input("Sisestage salasõna ")
    if sisestus != salasõna:
        print ("Vale salasõna")
        break
else:
    print ("Õige salasõna!")
'''
'''
i=20
while i > 0:
    print('i väärtus on ',i)
    i-=3
'''
naela_pikkus=13
haamri_voimsus=2
while naela_pikkus>0:
    print("kömaki")
    naela_pikkus=naela_pikkus-haamri_voimsus
print("Nael sees")