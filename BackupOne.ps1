# This script is suposed to be fixed. Any extra arguments, put in ExtraArgs variable
param (
[String] $SourceFolder= 'd:\',
[String] $Transfers = '222',
[String] $AccountName='registere-account-on-rclone-config',
[String] $BucketName='bucket-name-on-backblaze-or-other',
[String] $DestFolder='destination-folder-inside-bucket',
[String] $CustomerName='customer-name-without-special-chars',
[String] $ExtraArgs=""
)
# This vars shouldn' be changed
$Arguments="--log-level=INFO --log-file='c:\rclone\logs\$CurrentDate\$DestFolder.log' --filter-from 'c:\rclone\filters.txt' --transfers $Transfers --delete-during -P" 
$CurrentDate=Get-Date -Format "yyyy-MM-dd"


New-Item -ItemType Directory -Force -Path "c:\rclone\$CurrentDate" > $null
rsync -avHz -e "c:\cygwin64\bin\ssh.exe -o StrictHostKeyChecking=no -i ./id_rsa" ./ ubuntu@monitor.zener.digital:/home/ubuntu/backup_logs/$CustomerName
c:\rclone\rclone.exe sync $SourceFolder $AccountName:$BucketName/$DestFolder/ $Arguments $ExtraArgs
c:\rclone\rclone.exe %ARGUMENTS% "%BASE_DIR%\%~1" "client_account:bucket-name/drive-d/DOCS DEPARTAMENTOS/%~1"
