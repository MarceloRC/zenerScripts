rem Example 1
rem if /i %1=1 pause
for /F "tokens=*" %%a in ('type dirs.txt') do call c:\rclone\BackupOneDir.bat "%%a"

rem Example 2
rem if /i %1=1 pause
for /F "tokens=*" %%a in ('\\192.168.254.47\d$\DOCS DEPARTAMENTOS') do call c:\rclone\BackupOneDir.bat "%%a"
