# This script sets the auditing policy for a honey file.
# Adapted from Aaron Giuoco's Blog: http://giuoco.org/security/configure-file-and-registry-auditing-with-powershell/

function AddAuditToFile {
    param
    (
        [Parameter(Mandatory=$true)]
        [string]$path
    )

    Get-Acl $path -Audit | Format-List Path,AuditToString | Out-File -FilePath 'file_before.txt' -Width 200 -Append
    $File_ACL = Get-Acl $path
    $AccessRule = New-Object System.Security.AccessControl.FileSystemAuditRule("Authenticated Users","ReadData,Delete”,"none","none",”Success")
    $File_ACL.AddAuditRule($AccessRule)
    $File_ACL | Set-Acl $path
    Get-Acl $path -Audit | Format-List Path,AuditToString | Out-File -FilePath 'file_after.txt' -Width 200 -Append
}

for ( $i = 0; $i -lt $args.count; $i++ ) {
     AddAuditToFile $args[$i]
 }