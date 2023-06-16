#!/bin/bash

rm -f scanned_ip.txt

echo "Well, this is gonna take some time.. sit back, relax and sip a cup of coffee.."

# Check if a file name is provided as an argument
if [ $# -ne 1 ]; then
  echo "Usage: $0 <file>"
  exit 1
fi

file="$1"

# Check if the file exists
if [ ! -f "$file" ]; then
  echo "File not found: $file"
  exit 1
fi

echo "Port Scanning Initiated.."

# Read the file line by line
while IFS= read -r line; do
  echo "Scanning IP: $line"
  
  # Execute masscan command for each line/IP
  sudo masscan -p1-65535 -v "$line" --rate=1000 --open -e wlan0 -oX - >> scanned_ip.txt

done < "$file"

# Check if the scanned_ip.txt file exists
if [ ! -f "scanned_ip.txt" ]; then
  echo "File not found: scanned_ip.txt"
  exit 1
fi

echo "Port scan finished successfully"
echo "Nmap Scanning Initiated.."

# Array to track scanned IP addresses
scanned_ips=()

# Read the file line by line
while IFS= read -r line; do
  # Check if the line contains the keyword "addr"
  if echo "$line" | grep -q "addr="; then
    # Extract the value of the "addr" keyword
    ip=$(echo "$line" | sed -n 's/.*addr="\([^"]*\)".*/\1/p')

    # Check if IP address is already scanned
    if [[ " ${scanned_ips[@]} " =~ " ${ip} " ]]; then
      continue
    fi

    # Add IP address to scanned_ips array
    scanned_ips+=("$ip")

    # Extract all ports for the IP address
    ports=$(grep "addr=\"$ip\"" "scanned_ip.txt" | sed -n 's/.*portid="\([^"]*\)".*/\1/p' | tr '\n' ',' | sed 's/,$//')

    # Perform nmap scan for the IP address and all ports
    echo "Scanning $ip on ports $ports"
    nmap -A -p $ports -Pn $ip >> "nmap_output_$ip.txt"
  fi
done < "scanned_ip.txt"
