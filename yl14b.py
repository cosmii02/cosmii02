import typing_extensions


nimi=str(input("Nimi: "))
lubkiirus=int(input("Lubatud kiirus (km/h): "))
tegkiirus=int(input("Tegelik kiirus (km/h): "))
if tegkiirus >lubkiirus:
    ulki=int(tegkiirus-lubkiirus)
trahv=int(ulki*3)
miinimum=int(min(190, trahv))
print(str(nimi) + ", Kiiruse ületamise eest on teie trahv: "+str(miinimum)+"€")