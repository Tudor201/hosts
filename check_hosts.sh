#!/bin/bash

while read -r ip host rest; do
    [[ "$ip" =~ ^#|^$ ]] && continue

    # regex pentru IPv4
    if [[ "$ip" =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then
        echo "OK   $ip  $host"
    else
        echo "BAD  $ip  $host"
    fi
done < /etc/hosts
