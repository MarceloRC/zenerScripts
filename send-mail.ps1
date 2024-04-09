$Username = "user";
$Password = "senha";
$path = "C:\rclone\log-compactado\$CurrentDate.zip";
$sender = "email de quem envia"
$recipient = "e-mail que recebe"
$CurrentDate=Get-Date -Format "yyyy-MM-dd"
$server = "server"
$company= "empresa"

# compacta o log
Compress-Archive -Path C:\rclone\logs\$CurrentDate\ -DestinationPath C:\rclone\log-compactado\$CurrentDate.zip

# Enviar e-mail via SendGrid
function Send-ToEmail([string]$email, [string]$attachmentpath){

    $message = new-object Net.Mail.MailMessage;
    $message.From = "$sender";
    $message.To.Add($email);
    $message.Subject = "Log de backup $company Servidor $server $CurrentDate";
    $message.Body = "Log de backup $company Servidor $server";
    $attachment = New-Object Net.Mail.Attachment($attachmentpath);
    $message.Attachments.Add($attachment);

    $smtp = new-object Net.Mail.SmtpClient("smtp.sendgrid.net", "587");
    $smtp.EnableSSL = $true;
    $smtp.Credentials = New-Object System.Net.NetworkCredential($Username, $Password);
    $smtp.send($message);
    write-host "Mail Sent" ; 
    $attachment.Dispose();
 }
Send-ToEmail  -email "$recipient" -attachmentpath $path;

# Apagar o Log compactado
Remove-Item –path C:\rclone\log-compactado\$CurrentDate.zip
