#!/bin/bash
### Trim Proxmox host volumes and all LXCs on node ###

# Run as weekly cron job

# !/bin/bash

# Script colors
green=`tput setaf 2`
reset=`tput sgr0`

# Path to PCT
FSTRIM=/sbin/pct
# Path to FSTRIM
FSTRIM=/sbin/fstrim

# List of host volumes to trim separated by spaces
# eg TRIMVOLS="/mnt/a /mnt/b /mnt/c"
TRIMVOLS="/"

## Trim all LXC containers ##
echo "${green}LXC CONTAINERS${reset}"
for i in $(pct list | awk '/^[0-9]/ {print $1}'); do
  echo "Trimming Container $i"
  pct fstrim $i 2>&1 | logger -t "pct fstrim [$$]"
done
echo ""

## Trim host volumes ##
echo "${green}HOST VOLUMES${reset}"
for i in $TRIMVOLS; do
  echo "Trimming $i"
  $FSTRIM -v $i 2>&1 | logger -t "fstrim [$$]"
done
