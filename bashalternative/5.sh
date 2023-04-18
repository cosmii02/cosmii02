#!/bin/bash

# Küsime kasutajalt, kas soovitakse kausta kopeerida või liigutada
echo "Kas soovite kausta kopeerida (cp) või liigutada (mv)?"
read -r action

case $action in
    cp)
        # Kopeerimise valiku korral

        # Küsime millist kausta kopeerida
        echo "Millist kausta soovite kopeerida?"
        read -r source_dir

        # Kontrollime, kas sisestatud kaust eksisteerib
        if [ ! -d "$source_dir" ]; then
            echo "Kausta ei leitud! Skript lõpetab oma töö."
            exit 1
        fi

        # Küsime kuhu kausta kopeerida
        echo "Kuhu kausta soovite kopeerida?"
        read -r target_dir

        # Teostame kopeerimise
        cp -r "$source_dir" "$target_dir"

        # Väljastame tulemuse
        echo "Kausta '$source_dir' kopeerimine '$target_dir' on lõppenud."
        ;;
    mv)
        # Liigutamise valiku korral

        # Küsime millist kausta liigutada
        echo "Millist kausta soovite liigutada?"
        read -r source_dir

        # Kontrollime, kas sisestatud kaust eksisteerib
        if [ ! -d "$source_dir" ]; then
            echo "Kausta ei leitud! Skript lõpetab oma töö."
            exit 1
        fi

        # Küsime kuhu kausta liigutada
        echo "Kuhu soovite kausta '$source_dir' liigutada?"
        read -r target_dir

        # Teostame liigutamise
        mv "$source_dir" "$target_dir"

        # Väljastame tulemuse
        echo "Kausta '$source_dir' liigutamine '$target_dir' on lõppenud."
        ;;
    *)
        # Tundmatu valiku korral
        echo "Tundmatu valik! Skript lõpetab oma töö."
        exit 1
        ;;
esac
