#!/bin/bash

# Kontrollime, kas kaust /var/vanadfailid on olemas
if [ -d "/var/vanadfailid" ]; then
    echo "Kaust /var/vanadfailid on olemas."

    # Palume kasutajal valida, kas ta soovib kausta varundada või kustutada
    echo "Kas soovite kausta varundada või kausta sisu kustutada?"
    echo "1) Varunda kaust"
    echo "2) Kustuta kausta sisu"
    read valik

    # Vastavalt kasutaja valikule teostame tegevuse
    case $valik in
        1)
            # Küsime, kuhu kausta varundada
            echo "Sisestage kausta tee, kuhu soovite varunduse salvestada:"
            read backup_dir

            # Paljundame kausta varundusfailiks
            backup_file="varundus_$(date +'%Y-%m-%d_%H-%M-%S').tar.gz"
            tar -czf "${backup_dir}/${backup_file}" -C /var/vanadfailid .

            # Kontrollime, kas varundusfail loodi edukalt
            if [ -f "${backup_dir}/${backup_file}" ]; then
                echo "Kaust /var/vanadfailid on edukalt varundatud kausta ${backup_dir}/${backup_file}!"
            else
                echo "Varundamine ebaõnnestus!"
            fi
            ;;
        2)
            # Kustutame kausta sisu
            rm -rf /var/vanadfailid/*
            echo "Kaust /var/vanadfailid on edukalt tühjaks tehtud!"
            ;;
        *)
            # Väära valiku korral lõpetame skripti töö
            echo "Vale valik! Skript seiskub."
            exit 1
            ;;
    esac
else
    # Kui kausta pole, siis kuvame vastava teate ja lõpetame skripti töö
    echo "Kausta ei leitud, skript seiskub."
    exit 1
fi
