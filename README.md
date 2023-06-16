# nmap-script
## Full_FastScan - If you are too lazy and want to get your work done fast, this script should work for you. All you need to do is provide the ip list in a file and it will perform a mass scan and grep the ports to the nmap and performs a full scan on those IPs and Ports. The outputs will be saved in a text file.
*usage - chmod +x full_fastscan.sh && ./full_fastscan.sh ip_list.txt
## Safe_Scan - Use this script if you have OCD/ trust issues. This scipt will perform port scan from 1-1000 and 1000-5000 etc. Some humans say this gives more accurate results and also less load on servers.
*usage - chmod +x safe_scan.sh && ./safe_scan.sh <ip_address>
