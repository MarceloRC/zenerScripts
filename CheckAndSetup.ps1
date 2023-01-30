$path=$Env:Path.ToUpper()
#Write-Host $path
$fail=0
# create a new folder 
if ($Env:Path -inotlike '*C:\CYGWIN64\BIN*')
{
    Write-Host ('FALHA - O caminho do Cygwin nao esta corretamente inserido no path do sistema. Caso ainda não tenha instalado, instale-o preferencialmente no diretorio padrao e adicione "c:\cygwin64\bin" ao path do sistema, de preferencia antes de todos os outros. Após inserir, feche esta janela, abra outra e execute novamente o scrit de checagem para que o path seja recarregado.') -ForegroundColor Yellow
    Write-Host ('--') -ForegroundColor Yellow
    $fail=1
    Exit
} else {
    Write-Host ('Cygwin no path correto') -ForegroundColor DarkGreen
}

if ((get-command rsync.exe).Path -inotlike '*CYGWIN64\BIN*') {
    Write-Host ('FALHA - Rsync nao esta no path correto. Possivelmente, o pacote rsync do cygwin não está instalado. Siga o passo a passo em https://gist.github.com/AllanNozomu/6b108324f9c72285adb2c77499cad4b8 e tente novamente. Aproveite para verificar o pacote ssh também pois iremos precisar dele') -ForegroundColor Yellow
    $fail=1
    Exit
} else {
    Write-Host ('rsync no path correto') -ForegroundColor DarkGreen
}
if ((get-command ssh.exe).Path -inotlike '*CYGWIN64\BIN*') {
    Write-Host ('SSH nao esta no path correto. Instale o cygwin ou remova o excedente ou coloque o path do cygwin em primeiro nas variaveis de ambiente') -ForegroundColor Yellow
    $fail=1
    Exit
} else {
    Write-Host ('SSH no path correto') -ForegroundColor DarkGreen
}

if ($fail -eq 0){
    Write-Host ('Pre requisitos completados com sucesso. Iniciando instalacao') -ForegroundColor Green
    Write-Host ('Criando diretorio c:\rclone (Diretorio base de todo o conjunto de scripts)') -ForegroundColor Green
    New-Item -ItemType Directory -Force -Path 'c:\rclone\logs'> $null
    #The following line is for Windows 2012 and bellow (TLS1.2)
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    Write-Host ('Fazendo Download do arquivo BackupOne') -ForegroundColor Green
    Invoke-WebRequest -URI https://github.com/andretapxure/zenerScripts/blob/master/BackupOne.ps1?raw=True -OutFile C:/rclone/BackupOne.ps1
    Write-Host ('Fazendo Download do arquivo BackupAll') -ForegroundColor Green
    Invoke-WebRequest -URI https://github.com/andretapxure/zenerScripts/blob/master/BackupAll.ps1?raw=True -OutFile C:/rclone/BackupAll.ps1
    Write-Host ('Fazendo Download do arquivo Filters.txt') -ForegroundColor Green
    Invoke-WebRequest -URI https://github.com/andretapxure/zenerScripts/blob/master/filters.txt?raw=True -OutFile C:/rclone/filters.txt
    Write-Host ('Fazendo Download do Rclone para a pasta temporaria do sistema %TEMP%') -ForegroundColor Green
    Invoke-WebRequest -URI https://downloads.rclone.org/rclone-current-windows-amd64.zip -OutFile $Env:TEMP/rclone.zip
    Write-Host ('Descompactando o arquivo rclone.exe do download que foi executado') -ForegroundColor Green
    Add-Type -AssemblyName System.IO.Compression.FileSystem
    $zip = [System.IO.Compression.ZipFile]::Open("$Env:TEMP/rclone.zip", 'read')
    $zip.Entries | Where-Object Name -match rclone.exe | ForEach-Object{[System.IO.Compression.ZipFileExtensions]::ExtractToFile($_, "c:/rclone/$($_.Name)", $true)}
    $zip.Dispose()
    Write-Host ('Gerando chave SSH. Caso a mesma exista, digiti nao na proxima pergunta. Nao esqueca de colocar o conteudo do id_rsa.pub no servidor que recebe logs.') -ForegroundColor Green
    ssh-keygen -q -t rsa -N '""' -f c:/rclone/id_rsa
    Write-Host ('Instalacao completada com sucesso') -ForegroundColor Green

    
}

