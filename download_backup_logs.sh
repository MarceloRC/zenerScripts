#!/bin/bash
##########################################################################
# PROGRAMA:             download_backup_logs.sh
# Autores:              Marcelo Cardoso (marcelo@zener.digital)
# Objetivo:             Fazer uma copia dos arquivos do bucket backblaze na nuvem para servidor local.
##########################################################################
# Criação:              03/02/2023
# Atualização: --/--/---
##########################################################################

##########################################################################
# Registro de Alteração:
# Data: --/--/----   Descrição:
# Data:              Descrição:
##########################################################################
# Variaveis
# =====================
date_now=$(date +"%Y-%m-%d")
logfile=/home/ubuntu/zenerScripts/logs/donwload_backup_$date_now.log
touch $logfile

bucketName="backup-logs-zener"
AccountName="backup_logs_zener"
DestFolder="/home/ubuntu/backup_logs"


log="/home/ubuntu/zenerScripts/logs"

echo "-------------------------------------------------------------------" >> $logfile
echo "Starting the donwload backup process for $(date +'%d/%m/%Y %H:%M:%S')" >> $logfile
rclone --log-level INFO --transfers=50 --log-file="$log/backup$date.log" copy $AccountName:$bucketName $DestFolder 
echo "Stopping the donwload backup process for $(date +'%d/%m/%Y %H:%M:%S')" >> $logfile
echo "-------------------------------------------------------------------" >> $logfile

ls  /home/ubuntu/backup_logs/ > /home/ubuntu/zenerScripts/empresas.txt

while read -r v1; do
sudo find /home/ubuntu/backup_logs/$v1 -type d -mtime +10 -exec rm -rf {} \;

done < /home/ubuntu/zenerScripts/empresas.txt
