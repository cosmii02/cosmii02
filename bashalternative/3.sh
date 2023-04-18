#!/bin/bash

# Küsime kasutajalt, millist kausta varundada
read -p "Sisesta kausta teekond, mida soovid varundada (näiteks /var/log): " source_dir

# Kontrollime, kas sisestatud kaust on olemas
if [ ! -d "$source_dir" ]; then
    echo "Viga! Kausta ei leitud."
    exit 1
fi

# Küsime kasutajalt, kuhu kausta varundada
read -p "Sisesta kausta teekond, kuhu soovid varunduse teha (näiteks /varundus): " backup_dir

# Kontrollime, kas sihtkaust on olemas
if [ ! -d "$backup_dir" ]; then
    echo "Viga! Sihtkausta ei leitud."
    exit 1
fi

# Loome varundusfaili nime
backup_file="logbu_$(date +%y%m%d_%H%M%S).tar.gz"

# Varundame kausta
tar -czf "$backup_dir/$backup_file" "$source_dir" >/dev/null 2>&1

# Väljastame tulemuse
echo "Kausta '$source_dir' varundamine kausta '$backup_dir' on lõppenud."
echo "Tekkinud failinimi: $backup_file"
