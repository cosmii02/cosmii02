minutid = int(input("Sisesta minutite arv: "))

i = 1 # Alguspunkt
laigid = 0 # Laikide summa
while i <= minutid: # Teeb nii kaua, kui on veel minuteid, mida arvestada
    if i % 2: # Kui i, ehk arvestatav minut, on paarisarv
        laigid += i # Lisab laikidele arvestatava minuti
    i += 1
print("Laikide koguarv on " + str(likes)) # Väljastab laikide arvu