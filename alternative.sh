#!/bin/bash

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
    tar -czf /var/varundus/kausta_varundus_$(date +"%Y-%m-%d_%H-%M-%S").tar.gz "$kaust"
    mv /var/varundus/kausta_varundus_$(date +"%Y-%m-%d_%H-%M-%S").tar.gz "$asukoht"
    echo "Kausta varundus õnnestus."
  else
    echo "Viga: Varunduskausta asukohta ei leitud."
  fi
else
  echo "Viga: Kausta teekonda ei leitud."
fi

# Küsi andmebaasi nimi ja asukoht, kuhu varundada
echo "Sisesta andmebaasi nimi, mida soovid varundada:"
read andmebaas
echo "Sisesta asukoht, kuhu soovid andmebaasi varundada:"
read asukoht
echo "Sisesta kasutajanimi, millega soovid andmebaasi varundada:"
read kasutajanimi
echo "Sisesta parool, millega soovid andmebaasi varundada:"
read -s parool

# Tee andmebaasi varundus, paki failid ja andmebaas kokku ning liiguta varunduskausta
if mysqldump --user="$kasutajanimi" --password="$parool" "$andmebaas" > /dev/null 2>&1; then
  mysqldump --user="$kasutajanimi" --password="$parool" "$andmebaas" > /var/varundus/$andmebaas.sql
  tar -czf /var/varundus/andmebaasi_varundus_$(date +"%Y-%m-%d_%H-%M-%S").tar.gz /var/varundus/$andmebaas.sql
  rm /var/varundus/$andmebaas.sql
  mv /var/varundus/andmebaasi_varundus_$(date +"%Y-%m-%d_%H-%M-%S").tar.gz "$asukoht"
  echo "Andmebaasi varundus õnnestus."
else
  echo "Viga: Andmebaasi varundamine ebaõnnestus."
fi
