#!/bin/bash

# Küsime, milline nädalapäev on täna
weekday=$(date +%a)

# Määrame varundatava kausta teekonna vastavalt nädalapäevale
if [ "$weekday" = "Mon" ] || [ "$weekday" = "Tue" ] || [ "$weekday" = "Wed" ]; then
    source_dir="/var/log"
    target_dir="/varundus/esimene"
elif [ "$weekday" = "Thu" ] || [ "$weekday" = "Fri" ] || [ "$weekday" = "Sat" ]; then
    source_dir="/var/log"
    target_dir="/varundus/teine"
elif [ "$weekday" = "Sun" ]; then
    source_dir="/var/log"
    target_dir="/varundus/kolmas"
else
    echo "Tundmatu nädalapäev: $weekday"
    exit 1
fi

# Kontrollime, kas varunduse kaust on olemas ja loome selle vajadusel
if [ ! -d "$target_dir" ]; then
    mkdir -p "$target_dir"
fi

# Loome varundusfaili nime
backup_file="logsbu_$(date +'%Y-%m-%d_%H-%M-%S').tar.gz"

# Teostame varunduse
tar -czf "${target_dir}/${backup_file}" -C "$source_dir" .

# Skript ei väljasta käivitamisel ühtegi teadet (ka mitte tar-i varunduse ajal)


# cron
# 0 4 * * * /path/to/your/script.sh >/dev/null 2>&1