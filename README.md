# XKCDcheck
Retrieves the day's XKCD comic and emails it to the specified recipient.

You'll need Get-CredentialFromWindowsCredentialManager for this to work. That's how it securely sends an email. You can find that here (credit where credit is due):
https://gist.github.com/40a/7892466

Once you have that in your specified module path (C:\Users\%username%\Documents\WindowsPowershell\Modules\Get-CredentialFromWindowsCredentialManager probably?) be sure to add a set of credentials in the Credential Manager. I use a gmail account, just store the username and password, enable the account to send from unsecure apps (I use a dedicated gmail account for that, btw), and then plug whatever name you gave the credentials into the script (or pass in as a param).
