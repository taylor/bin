#!/bin/bash
# Generate unique valid XEN MAC addresses in shell, 'cause it's faster ;)
# Xen MAC's begin with 00:16:3e

declare -i num="${1:-0}"
until [[ $num -gt 0 ]]; do
read -p "How many MAC's do you want to generate? " num
done

declare -a macs=( )

while [[ $num -gt 0 ]]; do
mac=$(printf '%02x:%02x:%02x' $((RANDOM % 256)) $((RANDOM % 256)) $((RANDOM % 256)))

for i in "${macs[@]}"; do
[[ $mac = $i ]] && continue 2
done

macs[${#macs[*]}]=$mac
echo 00:16:3e:$mac
num=$((num-1))
done
