$path=$Env:Path.ToUpper()
#echo $path
$fail=0
# create a new folder 
New-Item -ItemType Directory -Force -Path 'c:\rclone\logs'
if ($Env:Path -inotlike "*C:\CYGWIN64\BIN")
{
    echo "Cygwin nao esta no path. Instale-o preferencialmente no diretorio padrao da instalacao (c:\cygwin64\bin)"
    $fail=1
} else {
    echo ("Cygwin no path correto")
}

if ((get-command rsync.exe).Path -inotlike "*CYGWIN64\BIN*") {
    echo "Rsync nao esta no path correto. Instale o cygwin ou remova o excedente ou coloque o path do cygwin em primeiro nas variaveis de ambiente"
    $fail=1
} else {
    echo ("rsync no path correto")
}
if ((get-command ssh.exe).Path -inotlike "*CYGWIN64\BIN*") {
    echo "SSH nao esta no path correto. Instale o cygwin ou remova o excedente ou coloque o path do cygwin em primeiro nas variaveis de ambiente"
    $fail=1
} else {
    echo ("SSH no path correto")
}

if ($fail -eq 0){
    $rclone='rclone-current-windows-amd64'
    #The following line is for Windows 2012 and bellow (TLS1.2)
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    Invoke-WebRequest -URI https://downloads.rclone.org/rclone-current-windows-amd64.zip -OutFile $Env:TEMP/rclone.zip
    #Adding zip capabilities
    Add-Type -AssemblyName System.IO.Compression.FileSystem
    #[System.IO.Compression.ZipFile]::ExtractToDirectory( "$Env:TEMP/rclone.zip", "$Env:TEMP")
    #Extracting rclone.exe to the backup directory.
    $zip = [System.IO.Compression.ZipFile]::Open("$Env:TEMP/rclone.zip", 'read')
    $zip.Entries | Where-Object Name -match rclone.exe | ForEach-Object{[System.IO.Compression.ZipFileExtensions]::ExtractToFile($_, "c:/rclone/$($_.Name)", $true)}
    $zip.Dispose()

    
}

