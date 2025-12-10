#!/bin/bash

DNS_SERVER="$1"

if [ -z "$DNS_SERVER" ]; then
    echo "Usage: $0 <dns_server>"
    exit 1
fi

check_ip() {
    local host="$1"
    local ip="$2"
    local dns="$3"

    if ! [[ "$ip" =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then
        echo "BAD FORMAT: $ip  ($host)"
        return
    fi

    resolved=$(dig +short @"$dns" "$host")

    if [ "$resolved" = "$ip" ]; then
        echo "OK:   $host --> $ip"
    else
        echo "FAIL: $host --> $ip (DNS says: $resolved)"
    fi
}

while read -r ip host rest; do
    [[ "$ip" =~ ^#|^$ ]] && continue
    check_ip "$host" "$ip" "$DNS_SERVER"
done < /etc/hosts

