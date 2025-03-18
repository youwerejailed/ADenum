# Active Directory Enumeration Script

# Get all users in Active Directory
Function Get-ADUsers {
    $Searcher = New-Object DirectoryServices.DirectorySearcher
    $Searcher.Filter = "(&(objectCategory=person)(objectClass=user))"
    $Users = $Searcher.FindAll()
    
    foreach ($User in $Users) {
        $User.Properties.displayname
    }
}

# Get all groups in Active Directory
Function Get-ADGroups {
    $Searcher = New-Object DirectoryServices.DirectorySearcher
    $Searcher.Filter = "(objectClass=group)"
    $Groups = $Searcher.FindAll()
    
    foreach ($Group in $Groups) {
        $Group.Properties.name
    }
}

# Get all computers in Active Directory
Function Get-ADComputers {
    $Searcher = New-Object DirectoryServices.DirectorySearcher
    $Searcher.Filter = "(objectClass=computer)"
    $Computers = $Searcher.FindAll()
    
    foreach ($Computer in $Computers) {
        $Computer.Properties.cn
    }
}

# Get PDC Role Owner
Function Get-PDCRoleOwner {
    $Domain = [System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain()
    $PDC = $Domain.PdcRoleOwner
    Write-Host "PDC Role Owner: $PDC" -ForegroundColor Yellow
}

# Execute functions
Write-Host "Enumerating Active Directory Users..." -ForegroundColor Green
Get-ADUsers

Write-Host "Enumerating Active Directory Groups..." -ForegroundColor Green
Get-ADGroups

Write-Host "Enumerating Active Directory Computers..." -ForegroundColor Green
Get-ADComputers

Write-Host "Retrieving PDC Role Owner..." -ForegroundColor Green
Get-PDCRoleOwner
