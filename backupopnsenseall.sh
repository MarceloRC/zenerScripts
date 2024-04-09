#!/bin/sh
#This script reads a simple text file (in this case, hosts) and gets the hosts info to call the pfbackup.sh script and make the backup of each firewall
BASE="/home/ubuntu/zenerScripts/hostsopnsense"
while IFS=, read -r customer_name desc host key_opn secret_opn type ip2
do
    echo "Backing up $customer_name"
    /home/ubuntu/zenerScripts/opnbackup.sh $customer_name $desc $host $key_opn $secret_opn $type $ip2
done < $BASE
