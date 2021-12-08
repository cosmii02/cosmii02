kood=1+2+3
sisestatud=int(input("Sisesta kood: "))
if sisestatud==kood:
    print("Õige kood on: " + str(kood))
else:
    if sisestatud==kood+1:
        print("Võitsid")
    else:
        print("Kaotasid")
