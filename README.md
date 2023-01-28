# Obvsiouly this repo need a lot of improvement.
## Setup and check
The file Setup and Check script checks the minimum requiriments to our backup to run. Just download it, open a powershell and execute it (./SetupAndCheck.ps1)
Don't forget to create the bucket, configure the BackBlaze account (or whatever object storage you want) and replace the 'client_account:bucket-name' part of the command string on BackupOneDir.bat
## BackupAllDirs.bat
You can do whatever you want with this script since you give it a list of things to do. In this version I give 2 examples
The first one reads from a file (dirs.txt) and call the BackupOneDir.bat recursively. The second one makes a 'dir' command in a directory and execute the BackupOneDir.bat recursively with the result. Be creative and do whatever is best for the client
## BackupOneDir.bat
Gets a parameter %1 and make backup of it recursively on backblaze.