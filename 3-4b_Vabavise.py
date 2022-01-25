import random
prots = int(input("Sisestage visketabavuse protsent: "))
def trial():
    for i in range(100):
        if random.random() <= (prots/100):
            return True
        else:
            return False

tabamusi = 0
for i in range(1000):
    result = trial()
    if result == True:
        tabamusi += 1
        print(str(i+1) + ". vise tabas")
    else:
        print(str(i+1) + ". vise möödas")
print("Tabas " + str(tabamusi) + " viset.")