#!/bin/bash

# Genereerime suvalise numbri vahemikus 1-20
number=$(( $RANDOM % 20 + 1 ))

# Küsime kasutajalt, millist numbrit ta arvab
read -p "Arva ära suvaline number vahemikus 1-20: " arv

# Algseis
katsete_arv=1

# Võrdleme kasutaja arvatud numbrit genereeritud numbriga ja anname vihjeid, kuni kasutaja arvab õigesti
while [ $arv -ne $number ]
do
    if [ $arv -gt $number ]; then
        echo "Arv on väiksem kui $arv"
    else
        echo "Arv on suurem kui $arv"
    fi
    read -p "Proovi uuesti: " arv
    ((katsete_arv++))
done

# Kui kasutaja on õigesti arvanud, teavitame teda sellest ja kuvame katsete arvu
echo "Õige! Arvasid ära numbri $number $katsete_arv katsega."
