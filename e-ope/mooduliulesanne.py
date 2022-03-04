from datetime import datetime

def vanusekontroll():
    print("Insert something here")

today=datetime.today().strftime('%d. %B %Y')
print("Täna on: "+ (today))
isikukood=int(input("Sisesta isikukood: "))
isikukood2 = str(isikukood)
if len(isikukood2) != 11:
    print("Sisestatud isikukood on vale")
else:
    vanusekontroll()
