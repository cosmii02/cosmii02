#!/bin/bash

# Määratud muutujad
SOURCE_DIR="/var/log"
BACKUP_DIR="/varundus"

# Loome varunduskausta, kui see veel puudub
mkdir -p $BACKUP_DIR

# Loome varundusfaili nime, mis sisaldab kuupäeva ja kellaaega
FILENAME="$BACKUP_DIR/logsbu_$(date +"%y.%m.%d_%H.%M.%S").tar.gz"

# Loome varundusfaili tar abil
tar -czf $FILENAME $SOURCE_DIR > /dev/null 2>&1

# Kuvame teate varunduse lõpetamisest
echo "Varundamine lõpetatud: $FILENAME"

# cron 0 4 * * * root /path/to/script.sh