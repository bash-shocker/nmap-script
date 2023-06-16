#!/bin/bash

rm -f scanned_ip.txt

echo " Well, this is gonna take some time.. sit back, relax and sip a cup of coffee.."

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

echo "Nmap Scanning Initiated.."

while IFS= read -r line; do
  # Check if the line contains the keyword "ports"
  if echo "$line" | grep -q "portid="; then
    # Extract the value of the "addr" keyword
    ip=$(echo "$line" | sed -n 's/.*addr="\([^"]*\)".*/\1/p')
    echo "IP Address value: $ip"

    # Extract the ports for the IP address
    ports=$(grep "addr=\"$ip\"" "$file" | sed -n 's/.*portid="\([^"]*\)".*/\1/p' | tr '\n' ',')
    ports="${ports%,}"  # Remove trailing comma
    echo "Ports: $ports"

    # Perform nmap scan for the IP address and ports
    echo "Scanning $ip on ports $ports"
    nmap -A -p$ports -Pn $ip >> "nmap_output_$ip.txt"
  fi
done < "scanned_ip.txt"
