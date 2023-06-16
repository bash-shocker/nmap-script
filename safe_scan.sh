#! /bin/bash
echo " scanning port 0-1000 "
nmap -A -p0-1000 -Pn $1 > nmap_output_$1.txt;
cat nmap_output_$1.txt
echo "scanning port 1000-10000 "
nmap  -A -p1000-10000 -Pn $1 >> nmap_output_$1.txt;
cat nmap_output_$1.txt
echo "scanning port 10000-15000 "
nmap  -A -p10000-15000 -Pn $1 >> nmap_output_$1.txt;
cat nmap_output_$1.txt
echo " scanning port 15000-25000 "
nmap  -A -p15000-25000 -Pn $1 >> nmap_output_$1.txt;
cat nmap_output_$1.txt
echo "scanning port 25000-40000 "
nmap  -A -p25000-40000 -Pn $1 >> nmap_output_$1.txt;
cat nmap_output_$1.txt
echo "scanning port 40000-65536 "
nmap  -A -p40000-65536 -Pn $1 >> nmap_output_$1.txt;
cat nmap_output_$1.txt
echo "scan completed "
