Install-Module ExchangeOnlineManagement
Import-Module ExchangeOnlineManagement

$Username = "ExOPS_Fresh@leadforensics.onmicrosoft.com"
$PasswordString = "example string (not providing for obvious reasons)"
$SecPasswd = ConvertTo-SecureString $PasswordString;
$Credentials = New-Object System.Management.Automation.PSCredential ($Username, $SecPasswd)

Connect-ExchangeOnline -Credential $Credentials
