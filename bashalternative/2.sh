#!/bin/bash

# küsime millist kausta kopeerida
echo "Millist kausta soovid kopeerida?"
read source_dir

# kontrollime, kas sisestatud kaust eksisteerib
if [ ! -d "$source_dir" ]; then
  echo "Kausta $source_dir ei eksisteeri."
  exit 1
fi

# küsime, kuhu kausta kopeerida
echo "Kuhu kausta soovid kopeerida?"
read dest_dir

# kontrollime, kas sihtkaust eksisteerib
if [ ! -d "$dest_dir" ]; then
  echo "Sihtkausta $dest_dir ei eksisteeri."
  exit 1
fi

# teeme kausta kopeerimise
cp -r "$source_dir" "$dest_dir"

# väljastame kopeerimise tulemuse
echo "Kausta $source_dir koos failidega on kopeeritud kausta $dest_dir."
