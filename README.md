# Obvsiouly this repo need a lot of improvement.
## Setup and check
Este arquivo verifica se existe o cygwin, rsync e ssh instalado e no path correto. Caso existam, ele já criará o diretório do backup (c:\rclone) com os arquivos necessários ao backup. Em caso de não estarem satisfeitas esses pre requisitos, altere o sistema conforme pede o script, feche a janela do powershell e abra novamente para que os ajustes sejam carregados
## BackupOneDir.ps1
O Arquivo BackupOne.ps1 deve ter a capacidade de fazer um backup sozinho com apenas dois parametros, ou seja, abra o powershell e digite apenas:
```
c:\rclone\BackupOne.ps1 -Transfers n -SourceDir x:\algum_diretorio
```
Onde n é o numero de tarefas a serem abertas, x: é um drive do sistema e algum_diretoio é o diretório a ser backupeado. Ao agendar a tarefa, esse procedimento deverá ser seguido igualmente. Todas as variáveis nesse arquivo podem ser preenchidas no arquivo mesmo ou passadas como parâmetro na sessão 'param'. Uma recomendação é, no caso de haver mais de uma rotina no mesmo servidor, mande por parâmetro e no caso de uma só, preencha no arquivo mesmo para ficar mais fácil para o agendador de tarefas do Windows.
## BackupAllDirs.ps1
O intuito dessa arquitetura de scripts é passar o mínimo de informação para o agendador de tarefas do Windows. Nesse caso, o arquivo BackupAll.ps1 (que está vazio) será um concentrador de várias pastas no mesmo servidor. Para tanto, existem dois exemplos pelos quais já passamos:
### Exemplo 1 - Vários drives e pastas no mesmo servidor
Nesse caso, o BackupAll.ps1 chamaria a rotina BackupOne.ps1 quantas vezes forem necessárias com os parâmetros de origem, destino e número de tarefas. No exemplo que está descrito abaixo, o cliente tem os drives d:\, e:\arquivos_comuns e f:\contratos. Nesse caso, o BackupAll.ps1 ficaria da seguinte maneira:
```
c:\rclone\BackupOne.ps1 -SourceFolder d:\ -Transfers 80 -DestFolder drive-d
c:\rclone\BackupOne.ps1 -SourceFolder e:\arquivos_comuns -Transfers 80 -DestFolder drive-e-arquivos-comuns
c:\rclone\BackupOne.ps1 -SourceFolder f:\contratos -Transfers 80 -DestFolder drive-f-contratos

```
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
