$path=$Env:Path.ToUpper()
$pathRclone= 'c:\rclone'
#Write-Host $path
$fail=0
# create a new folder 
if ($fail -eq 0){
    Write-Host ('Pre requisitos completados com sucesso. Iniciando instalacao') -ForegroundColor Green
    Write-Host ('Criando diretorio c:\rclone (Diretorio base de todo o conjunto de scripts)') -ForegroundColor Green
    New-Item -ItemType Directory -Force -Path 'c:\rclone\logs'> $null
    #New-Item -ItemType Directory -Force -Path 'c:\rclone\log-compactado'> $null   
    #The following line is for Windows 2012 and bellow (TLS1.2)
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    Write-Host ('Fazendo Download do arquivo BackupOne') -ForegroundColor Green
    Invoke-WebRequest -URI https://github.com/MarceloRC/zenerScripts/blob/master/BackupOne.ps1?raw=True -OutFile $pathRclone/BackupOne.ps1
    Write-Host ('Fazendo Download do arquivo BackupAll') -ForegroundColor Green
    Invoke-WebRequest -URI https://github.com/MarceloRC/zenerScripts/blob/master/BackupAll.ps1?raw=True -OutFile $pathRclone/BackupAll.ps1
    Write-Host ('Fazendo Download do arquivo Filters.txt') -ForegroundColor Green
    Invoke-WebRequest -URI https://github.com/MarceloRC/zenerScripts/blob/master/filters.txt?raw=True -OutFile $pathRclone/filters.txt
    Write-Host ('Fazendo Download do Rclone para a pasta temporaria do sistema %TEMP%') -ForegroundColor Green
    Invoke-WebRequest -URI https://downloads.rclone.org/rclone-current-windows-amd64.zip -OutFile $Env:TEMP/rclone.zip
    Write-Host ('Descompactando o arquivo rclone.exe do download que foi executado') -ForegroundColor Green
    Add-Type -AssemblyName System.IO.Compression.FileSystem
    $zip = [System.IO.Compression.ZipFile]::Open("$Env:TEMP/rclone.zip", 'read')
    $zip.Entries | Where-Object Name -match rclone.exe | ForEach-Object{[System.IO.Compression.ZipFileExtensions]::ExtractToFile($_, "$pathRclone/$($_.Name)", $true)}
    $zip.Dispose()
    Write-Host ('Instalacao completada com sucesso') -ForegroundColor Green
}
