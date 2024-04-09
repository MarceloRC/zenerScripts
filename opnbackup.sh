#!/bin/bash

customer_name=$1;
description=$2;
fwhost=$3;
key=$4
secret=$5
type=$6

# Altere a chave e o segredo da API, o número de dias para manter backups, o caminho para seus backups e o nome do host para seu firewall

daystokeep=20
backupfile=config-$2-`date +%Y%m%d%H%M%S`.xml;

mkdir /home/ubuntu/backup_firewall/$customer_name;

if [ $type == "filial" ]
then
    mkdir /home/ubuntu/backup_firewall/$customer_name/filiais/;
    mkdir /home/ubuntu/backup_firewall/$customer_name/filiais/$description;
    destination=/home/ubuntu/backup_firewall/$customer_name/filiais/$description;
else 
    mkdir /home/ubuntu/backup_firewall/$customer_name/$description;
    destination=/home/ubuntu/backup_firewall/$customer_name/$description;
fi
 function backup_exec {
    /usr/bin/curl -s -k -u "$key":"$secret" https://$fwhost/api/backup/backup/download > $destination/$backupfile
 }
result=$(/usr/bin/curl -I -s -k -u "$key":"$secret" https://$fwhost/api/backup/backup/download | head -1)

if [[ $result != *"200"* ]]; then
   echo "Result of the HTTP request is $result"
    fwhost=$7 # Segundo IP do Firewall
    backup_exec
   exit 1
fi

backup_exec
error=$?

# Deletar arquivos com x dias
/usr/bin/find $destination/* -mtime +$daystokeep -exec rm {} \;


if [ $error == 0 ]; then
   echo "Curl returned error number $error"
   exit 1
fi


/home/ubuntu/zenerScripts/upload-backup-firewall.sh
