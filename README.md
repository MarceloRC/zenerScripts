# Obvsiouly this repo need a lot of improvement.
## Setup and check
The file Setup and Check script checks the minimum requiriments to our backup to run. Just download it, open a powershell and execute it (./SetupAndCheck.ps1)
Don't forget to create the bucket, configure the BackBlaze account (or whatever object storage you want) and replace the 'client_account:bucket-name' part of the command string on BackupOneDir.bat
## BackupOneDir.ps1
O Arquivo BackupOne.ps1 deve ter a capacidade de fazer um backup sozinho com apenas dois parametros, ou seja, abra o powershell e digite apenas:
```
c:\rclone\BackupOne.ps1 -Transfers n -SourceDir x:\algum_diretorio
```
Onde n é o numero de tarefas a serem abertas, x: é um drive do sistema e algum_diretoio é o diretório a ser backupeado. Ao agendar a tarefa, esse procedimento deverá ser seguido igualmente.
## BackupAllDirs.bat
Before you start this file, remember: ONE ROUTINE PER SERVER, ONE BUCKET PER SERVER. Once the server has only one folder, you will not need this file
You can do whatever you want with this script since you give it a list of things to do. In this version I give 2 examples
The first one reads from a file (dirs.txt) and call the BackupOneDir.bat recursively. The second one makes a 'dir' command in a directory and execute the BackupOneDir.bat recursively with the result. Be creative and do whatever is best for the client
## Filters.txt
Include in this file all filters the client asked line by line. For example:
```
- System Volume Information/**
- /VMs
- *.iso
```
The "-" signal will exclude that pattern and the "+" signal will include
## To do
- Convert the scripts to PS1
- Replace any names with vars
- Create script to filter logs and send email
- Maybe a dashboard
