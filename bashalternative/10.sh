#!/bin/bash

# Serverite IP-aadressid
server1="192.168.1.10"
server2="192.168.1.11"
server3="192.168.1.12"

# Salvestame veateated faili
log_file="serverid_$(date +'%Y-%m-%d_%H-%M-%S').txt"

# Kontrollime, kas serverid on võrgus ja kuvame uptime
for server in $server1 $server2 $server3
do
    # Pingime serverit, aga ei kuva tulemust
    ping -c 1 $server > /dev/null 2>&1

    # Kontrollime pingi väljundit ja teavitame kasutajat vastavalt tulemusele
    if [ $? -eq 0 ]; then
        echo "Server $server on võrgus kättesaadav"
        uptime=$(ssh user@$server "uptime -s")
        echo "Server on töös olnud alates: $uptime"
    else
        echo "Server $server pole võrgus kättesaadav"
        echo "$(date +'%Y-%m-%d %H:%M:%S') $server pole kättesaadav" >> $log_file
    fi
done
