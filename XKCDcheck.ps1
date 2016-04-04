param(
    # Optionally define the address to send the report to
    # If not otherwise specified, send to the From address
    [string]$EmailTo = '_@gmail.com',

    # Specify the SMTP server address (if not gmail)
    # Assumes SSL, because security!
    [string]$SMTPserver = 'smtp.gmail.com',

    # Specify the SMTP server's SSL port
    [int]$SMTPport = '587',

    # Specify the name used for the Credential Manager entry
    [string]$Cred = '_'

)

#region Associated Files
if (-not (Get-Module Get-CredentialFromWindowsCredentialManager)) {
    Try {
        Import-Module Get-CredentialFromWindowsCredentialManager.psm1 -ErrorAction Stop
    } Catch {
        Write-Host "Failed to load Get-CredentialFromWindowsCredentialManager.psm1. Aborting."
        Exit
    }
}
#endregion

$date = Get-Date -Format 'MM/dd/yy'
$xkcdResponse = Invoke-WebRequest http://www.xkcd.com/info.0.json
$xkcd = ConvertFrom-Json $xkcdResponse.Content


$credentials = Get-StoredCredential -Name $cred

$body = "<h1>$($xkcd.safe_title)</h1><br/><br/>"

if ($xkcd.img -eq "http://imgs.xkcd.com/comics/") {
    $body += "So, today's comic isn't a static image. You'll want to check it out <a href='http://www.xkcd.com/$($xkcd.num)'>on-site</a>.<br/><br/>"
} else {
    $body += "<img src='$($xkcd.img)'>"
}

$body += "<br/><br/><i>$($xkcd.alt)</i><br/><br/><a href='http://www.xkcd.com/'>xkcd.com</a>"
    
# If not otherwise specified, set the To address the same as the From
if ($EmailTo -eq 'default') {
    $EmailTo = $credentials.UserName
}

$subject = "XKCD for $date"

Send-MailMessage -From $($credentials.UserName) -to $EmailTo -SmtpServer $SMTPserver -Port $SMTPport -UseSsl -Credential $credentials -Subject $subject -Body $body -BodyAsHtml