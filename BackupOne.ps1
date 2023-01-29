param (
[String] $SourceDir= “C:\BuildOutput”,
[String] $Transfers = 222
)

Write-Host “SourceDir = [$($SourceDir)]”
Write-Host "Transfers = [$($Transfers)]”


$CurrentDate=Get-Date -Format "yyyy-MM-dd"
$AccountName='backblaze-account-on-backup-computer from rclone config'
$Bucket='bucket name created on the interface'
$FOLDER='destination folder inside the bucket'
$ARGUMENTS='--log-level=INFO --log-file=c:\rclone\logs\$CurrentDate\drive-d.log --filter-from filters.txt  --transfers=$TRANSFERS --delete-during'
$CUSTOMER_NAME='customer_name Without spaces, special chars and all letters non capital. if needed some separation, use underscore'
echo $b
echo $t
echo 'New-Item -ItemType Directory -Force -Path "c:\rclone\logs\$CurrentDate" > $null'
echo 'rsync -avHz -e "c:\cygwin64\bin\ssh.exe -o StrictHostKeyChecking=no -i ./id_rsa" ./ ubuntu@monitor.zener.digital:/home/ubuntu/backup_logs/$CUSTOMER_NAME'
echo 'c:\rclone\rclone.exe sync d:/ jovempan-fileserver:jovempan-fileserver/drive-d/ $ARGUMENTS'
