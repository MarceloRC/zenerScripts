#!/bin/bash
# This script is the actual backup script. It can be called standalone passing the four parameters bellow. The original script is https://github.com/mintsoft/PFSense-CURL-Backup

customer_name=$1;
description=$2;
hostname=$3;
password=$4;
username=$5;
type=$6

([ -z "$hostname" ] || [ -z "$username" ] || [ -z "$password" ]) && echo "all 3 arguments must be specified: hostname username password " && exit 1;

mkdir /home/ubuntu/backup_firewall/$customer_name;

csrf=$(curl -Ss --insecure --cookie-jar /tmp/$hostname-cookies.txt https://$hostname/diag_backup.php | sed -n 's/.*name=.__csrf_magic. value="\([^"]*\)".*/\1/p');
csrf2=$(curl -Ss --insecure --location --cookie-jar /tmp/$hostname-cookies.txt --cookie /tmp/$hostname-cookies.txt --data "login=Login&usernamefld=$username&passwordfld=$password&__csrf_magic=$csrf" https://$hostname/diag_backup.php | sed -n 's/.*var csrfMagicToken = "\([^"]*\)".*/\1/p');

backupfile=config-$1-$2-`date +%Y%m%d%H%M%S`.xml;

if [ $type == "filial" ]
then
    mkdir /home/ubuntu/backup_firewall/$customer_name/filiais/;
    mkdir /home/ubuntu/backup_firewall/$customer_name/filiais/$description;
    backupdir=/home/ubuntu/backup_firewall/$customer_name/filiais/$description;
else 
    mkdir /home/ubuntu/backup_firewall/$customer_name/$description;
    backupdir=/home/ubuntu/backup_firewall/$customer_name/$description;
fi

curl -Ss --insecure --cookie /tmp/$hostname-cookies.txt --cookie-jar /tmp/$hostname-cookies.txt --data "download=download&donotbackuprrd=yes&__csrf_magic=$csrf2" https://$hostname/diag_backup.php > $backupdir/$backupfile;

grep --silent '^<?xml ' $backupdir/$backupfile || echo "Downloaded file is not XML; is probably broken."

rm /tmp/$hostname-cookies.txt;
/home/ubuntu/zenerScripts/upload-backup-firewall.sh
