@echo off
rem Variable to avoid repeating names
set RCLONE_DIR=c:\rclone
set CYGWIN_DIR=c:\cygwin64
rem Get the system date
set CUR_YYYY=%date:~6,4%
set CUR_MM=%date:~3,2%
set CUR_DD=%date:~0,2%
set CUR_HH=%time:~0,2%
set CUR_NN=%time:~3,2%
set CURRENT_DATE=%CUR_YYYY%-%CUR_MM%-%CUR_DD%
if not exist "%CURRENT_DATE%" mkdir "%CURRENT_DATE%"


set BASE_DIR=\\192.168.254.47\d$\DOCS DEPARTAMENTOS
echo %~1
set ARGUMENTS=--log-level INFO --log-file="c:\rclone\%CURRENT_DATE%\%~1.log" --transfers=200 --delete-during -P --filter "- System Volume Information/**" --filter "- *.xml" sync
rem Backup up the log dir
rsync -avHz -e "c:\cygwin64\bin\ssh.exe -i ./id_rsa" ./ ubuntu@monitor.zener.digital:/home/ubuntu/backup_logs/client_name
c:\rclone\rclone.exe %ARGUMENTS% "%BASE_DIR%\%~1" "client_account:bucket-name/drive-d/DOCS DEPARTAMENTOS/%~1"
