#! /bin/bash
echo "\n scanning port 0-1000\n"
nmap -p0-1000 -Pn $1 > nmap_output_$1.txt;
cat nmap_output_$1.txt
echo "\n scanning port 1000-10000\n"
nmap  -p1000-10000 -Pn $1 >> nmap_output_$1.txt;
cat nmap_output_$1.txt
echo "\n scanning port 10000-15000\n"
nmap  -p10000-15000 -Pn $1 >> nmap_output_$1.txt;
cat nmap_output_$1.txt
echo "\n scanning port 15000-25000\n"
nmap  -p15000-25000 -Pn $1 >> nmap_output_$1.txt;
cat nmap_output_$1.txt
echo "\n scanning port 25000-40000\n"
nmap  -p25000-40000 -Pn $1 >> nmap_output_$1.txt;
cat nmap_output_$1.txt
echo "\n scanning port 40000-65536\n"
nmap  -p40000-65536 -Pn $1 >> nmap_output_$1.txt;
cat nmap_output_$1.txt
echo "\n scan completed \n "
