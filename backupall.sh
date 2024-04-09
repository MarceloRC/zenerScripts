#!/bin/sh
# This script reads a simple text file (in this case, hosts) and gets the hosts info to call the pfbackup.sh script and make the backup of each firewall
BASE="/home/ubuntu/zenerScripts/hosts"
while IFS=, read -r customer_name desc host password username type
do
    echo "Backing up $customer_name"
    /home/ubuntu/zenerScripts/pfbackup.sh $customer_name $desc $host $password $username $type
done < $BASE
