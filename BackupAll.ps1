# Scritp para uso de todas as pastas
c:\rclone\BackupOne.ps1 -SourceFolder E:\ -Transfers 150 -DestFolder drive-e -BucketName name-bucket -AccountName account-name

# Script para casos de listagem de pastas especificas
# Chamar script para listar as pastas
c:\rclone\dir.bat

# Colocar padrão UTF8 caso tenha acento
Get-Content "C:\rclone\dirs.txt" -encoding UTF8 | Set-Content "C:\rclone\dirs-utf8.txt" -encoding UTF8
Get-Content "C:\rclone\dirs-home.txt"  -encoding UTF8 | Set-Content "C:\rclone\dirs-home2.txt" -encoding UTF8

# Variaveis 
$FILE = Get-Content "C:\rclone\dirs-utf8.txt" 
$FILEHOME = Get-Content "C:\rclone\dirs-home2.txt" 
$Patch =  "\\diretorio\d$\DOCS DEPARTAMENTOS\"
$Patch2 = "drive-d/DOCS DEPARTAMENTOS/"

$PatchHome =  "\\diretorio\d$\"
$PatchHome2 = "drive-d/"
foreach ($BasePasteHome in $FILEHOME) 
{
  c:\rclone\BackupOne.ps1 -SourceFolder "$PatchHome$BasePasteHome" -Transfers 120 -DestFolder "$PatchHome2$BasePasteHome" -BucketName bucket-name -ExtraArgs "$BasePasteHome"

  foreach ($BasePaste in $FILE) 
    {
    c:\rclone\BackupOne.ps1 -SourceFolder "$Patch$BasePaste" -Transfers 120 -DestFolder "$Patch2$BasePaste" -BucketName bucket-name -ExtraArgs "$BasePaste"

    }

}

