# This script is suposed to be fixed. Any extra arguments, put in ExtraArgs variable
param (
[String] $SourceFolder= 'd:\',
[String] $Transfers = '80',
[String] $AccountName='customer-fileserver',
[String] $BucketName='customer-fileserver',
[String] $DestFolder='drive-d',
[String] $CustomerName='CustomerName',
[String] $ExtraArgs=""
)
# This vars shouldn't be changed
$CurrentDate=Get-Date -Format "yyyy-MM-dd"


New-Item -ItemType Directory -Force -Path "c:\rclone\$CurrentDate" > $null
c:\rclone\rclone.exe sync --transfers $Transfers --filter-from 'c:\rclone\filters.txt' --log-level INFO  --log-file='c:\rclone\'$CurrentDate'\'$DestFolder'.log' $SourceFolder $AccountName':'$BucketName'/'$DestFolder
