#!/bin/bash

# Skript küsib kasutajalt, millist tegevust ta soovib teha - kausta varundust või andmebaasi varundust
echo "Kas soovid käivitada kausta varundust või andmebaasi varundust? Sisesta k/kk/a/aa:"
read valik

# Kausta varundus
if [ "$valik" = "k" ] || [ "$valik" = "K" ]; then
  # Küsi kasutajalt kausta teekond ja asukoht, kuhu varundada
  echo "Sisesta kausta teekond, mida soovid varundada:"
  read kaust
  echo "Sisesta asukoht, kuhu soovid kausta varundada:"
  read asukoht

  # Kontrolli, kas kausta teekond on olemas
  if [ -d "$kaust" ]; then
    # Kontrolli, kas varunduskausta asukoht on olemas
    if [ -d "$asukoht" ]; then
      # Tee kausta varundus ja liiguta failid varunduskausta
      tar -czf /var/varundus/kausta_varundus_$(date +%d_%m_%Y_%H_%M_%S).tar.gz "$kaust"
      mv /var/varundus/kausta_varundus_$(date +%d_%m_%Y_%H_%M_%S).tar.gz "$asukoht"
      echo "Kausta varundus õnnestus."
    else
      echo "Viga: Varunduskausta asukohta ei leitud."
    fi
  else
    echo "Viga: Kausta teekonda ei leitud."
  fi

# Andmebaasi varundus
elif [ "$valik" = "a" ] || [ "$valik" = "A" ]; then
  # Küsi kasutajalt andmebaasi nime ja asukoht, kuhu varundada
  echo "Sisesta andmebaasi nimi, mida soovid varundada:"
  read andmebaas
  echo "Sisesta asukoht, kuhu soovid andmebaasi varundada:"
  read asukoht

  # Kontrolli, kas andmebaas on olemas
  if mysqlshow --user=root --password=PASSWORD "$andmebaas" > /dev/null 2>&1; then
    # Kontrolli, kas varunduskausta asukoht on olemas
    if [ -d "$asukoht" ]; then
      # Tee andmebaasi varundus, paki failid ja andmebaas kokku ning liiguta varunduskausta
      mysqldump --user=root --password=PASSWORD "$andmebaas" > /var/varundus/$andmebaas.sql
      tar -czf /var/varundus/andmebaasi_varundus_$(date +%d_%m_%Y_%H_%M_%S).tar.gz /var/varundus/$andmebaas.sql
      rm /var/varundus/$andmebaas.sql
      mv /var/varundus/andmebaasi_varundus_$(date
