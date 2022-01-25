# Torren Tamm, IS21
# 3.3. Täringumäng

import random
taringuid = int(input("Sisesta täringute arv: "))
while taringuid > 0:
    print(random.randint(1,6))
    taringuid -= 1
    