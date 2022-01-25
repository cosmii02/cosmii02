arv1=int(input("Maksimum: "))
arv2=int(input("Tegelik: "))
arv3=round(arv2/arv1*100)
if arv3 >= 90:
    print("viis")
else:
    if arv3 < 90 and arv3 >= 75:
        print("neli")
    else:
        if arv3 < 75 and arv3 >= 50:
            print("kolm!")
        else:
            print("uuesti!")
