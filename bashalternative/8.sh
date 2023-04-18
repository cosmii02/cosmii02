#!/bin/bash

# Küsime, millist kausta varundada
read -p "Sisesta kausta tee, mida soovid varundada: " source_dir

# Kontrollime, kas kaust eksisteerib
if [ ! -d $source_dir ]; then
    echo "Kausta ei leitud!"
    exit 1
fi

# Küsime, kuhu kausta varundada
read -p "Sisesta kausta tee, kuhu soovid varundada: " backup_dir

# Kontrollime, kas varunduskaust eksisteerib
if [ ! -d $backup_dir ]; then
    echo "Varunduskausta ei leitud!"
    exit 1
fi

# Varundame kausta
backup_file="${source_dir##*/}_$(date +'%d.%m.%y_%H.%M.%S').tar.gz"
tar -czf "${backup_dir}/${backup_file}" -C "${source_dir%/*}" "${source_dir##*/}"

# Kontrollime, kas varundusfail loodi edukalt
if [ ! -f "${backup_dir}/${backup_file}" ]; then
    echo "Varundamine ebaõnnestus!"
    exit 1
fi

# Anname teada, et varundus lõpetati edukalt
echo "${source_dir} varundamine kausta ${backup_dir} on edukalt lõpetatud!"
