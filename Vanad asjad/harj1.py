# Klassi loomine:

class Item: # Defineerib klassi

    def calculate_total_price(self, x, y): #Loob definitsiooni mida saab hiljem uuesti kasutada lühidalt

        return x * y



# Klassi eksemplari loomine

item1 = Item()



# Atribuutide määramine:
# Määrab atribuudid muutujatele

item1.name = "Phone"

item1.price = 100

item1.quantity = 5



# Meetodite kutsumine klassi eksemplaridest:
# Kasutab klassis olevat funktsiooni ja kasutab selle sees eeltoodud muutujaid


print(item1.calculate_total_price(item1.price, item1.quantity))



# Kuidas luua klassi eksemplari (saame luua nii palju eksemplare, kui soovime)

item2 = Item()



#Atribuutide määramine

item2.name = "Laptop"

item2.price = 1000

item2.quantity = 3



# Meetodite kutsumine klassi eksemplaridest
# Prindib lõpptulemuse

print(item2.calculate_total_price(item2.price, item2.quantity))