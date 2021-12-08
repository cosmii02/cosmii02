#ulesanne 1
'''
a = input("Sisesta ristküliku pikkus: ")
b = input("Sisesta ristküliku laius: ")
print("Ristküliku pindala on: " + (a*b))

#ulesanne 2
P = int(input("Sisesta ruudu ümbermõõt: "))
külg = P / 4
S = külg**2
print("Ruudu pindala on "+str(S))
#

#ulesanne 3
a = 5
b = 6
print("a vastandarv on: " str(-a))
print("b vastandarv on: " str(-b))
print("nende vahe on: " str(-a-(-b)))
#

#ulesanne 4
pikkus = float(input("1. pikkus: "))
pikkus = float(input("2. pikkus: "))
pikkus = float(input("3. pikkus: "))
kesk = (1.pikkus + 2.pikkus + 3.pikkus)/3
print("Keskmine on " + kesk)
#

#ulesanne 5
t_arv = int(input("Tüdrukuid: "))
p_arv = int(input("Poisse: "))
p_protsent = round(p_arv / kokku)
kokku = t_arv + p_arv
print("Poisse on " + str(p_protsent) + "%")

#ulesanne 6
reis = 1500
inimesi=int(input("Kui palju tuleb: ")) 
tuleb_maksta = reis / inimesi 
print("Igaüks: "+ str(round(tuleb_maksta,2)))
'''

import math	
a = int(input("ruutliikme kordaja: "))
b = int(input("lineaarliikme kordaja: "))
c = int(input("vabaliige: "))
ruutjuure_all = b**2 - 4*a*c
x1 = (-b + math.sqrt(ruutjuure_all))/(2*a)
x2 = (-b - math.sqrt(ruutjuure_all))/(2*a)
print("Üks lahend on: "+x1)
print("Teine lahend on: "+x2)
