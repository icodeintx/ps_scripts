
$AreYouSure = Read-Host "Are you SURE you want to wipe this folder?"

if ($AreYouSure -eq "y")
{
    
    Get-ChildItem -Recurse | Remove-Item -Recurse -Force 
    Write-Host "Folder has been wiped"
}
