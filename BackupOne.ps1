# This script is suposed to be fixed. Any extra arguments, put in ExtraArgs variable
param (
[String] $SourceFolder= 'd:\',
[String] $SourceFolderLog= 'c:\rclone\logs\',
[String] $Transfers = '80',
[String] $AccountName='customer',
[String] $AccountNameLog='customer',
[String] $BucketName='customer-fileserver',
[String] $BucketNameLog='customer',
[String] $DestFolder='drive-d',
[String] $CustomerName='customer',
[String] $ExtraArgs=""
)
# This vars shouldn't be changed
$CurrentDate=Get-Date -Format "yyyy-MM-dd"


New-Item -ItemType Directory -Force -Path "c:\rclone\logs\$CurrentDate" > $null

# Sync Files in bucket
c:\rclone\rclone.exe sync --transfers $Transfers --filter-from 'c:\rclone\filters.txt' --log-level INFO  --log-file='c:\rclone\logs\'$CurrentDate'\'$DestFolder'.log' "$SourceFolder" $AccountName':'$BucketName'/'"$DestFolder"

# Sync Logs Server 
c:\rclone\rclone.exe sync  --log-level INFO  --log-file="c:\rclone\logs\$CurrentDate\sendbackupzener.log" $SourceFolderLog $AccountNameLog':'$BucketNameLog/$CustomerName

# Enviar e-mail do log gerado do backup
c:\rclone\send-mail.ps1
