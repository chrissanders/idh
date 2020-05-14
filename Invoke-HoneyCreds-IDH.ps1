# Adapted from Ben0xa - https://github.com/Ben0xA/PowerShellDefense/blob/master/Invoke-HoneyCreds.ps1
# Provide honey credentials at the bottom. 

function Invoke-HoneyCreds {
	[CmdletBinding()]
    Param (
        [Parameter(Mandatory = $True, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [String]
        $domain,

        [Parameter(Mandatory = $True, Position = 1)]
        [ValidateNotNullOrEmpty()]
        [String]
        $user,

        [Parameter(Mandatory = $True, Position = 1)]
        [ValidateNotNullOrEmpty()]
        [String]
        $password
    )

	# Add Member Defition for LogonUser
	$api = Add-Type -Name Ignore -MemberDefinition @"
		[DllImport("advapi32.dll", SetLastError = true)] 
		public static extern bool LogonUser(string lpszUsername, string lpszDomain, string lpszPassword, int dwLogonType, int dwLogonProvider, ref IntPtr phToken);
"@ -passthru

	$securepass = ConvertTo-SecureString "$password" -AsPlainText -Force
	$creds = New-Object System.Management.Automation.PSCredential -ArgumentList ($user, $securepass)

	$plain = "$($user):$($password)"

	# Impersonate the new user
	[IntPtr]$token = [Security.Principal.WindowsIdentity]::GetCurrent().Token
	$api::LogonUser($user, $domain, $password, 9, 0, [ref]$token) | Out-Null
	$identity = New-Object Security.Principal.WindowsIdentity $token
	$context = $Identity.Impersonate()

	
	while($True) {
		try {
			New-PSDrive -name X -PSProvider FileSystem -root \\$($domain)\C$ -Credential $creds -ErrorAction Ignore -ErrorVariable $err
			
		}
		catch {
			
		}
				
		Start-Sleep -s 5
	}
}

# Provide credentials here. The domain and username should be real, but the password should be fake. 
Invoke-HoneyCreds -domain skynet -user jcarter -password peanuts
