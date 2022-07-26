
$SearchString = $args[0]
$FileFilter = $args[1]

#if the search pattern is empty do not continue
#CLI then exit the script
if($SearchString -eq "" -or $args.Count -eq 0)
{
    Write-Host "Search pattern must be provided."
    Return
}

if($SearchString -eq "--help")
{
    Write-Host "SearchIn - Powershell script to searching for strings inside files"
    Write-Host "Accepts 2 Parameters"
    Write-Host "--------------------------"
    Write-Host "Parameter 1: String to search for.  Example: request "
    Write-Host "Parameter 2 (optional): File Pattern.  Example: *.sql"
    Return
}

Get-ChildItem -Path .\ -Filter $FileFilter -Recurse -File | Select-String $SearchString -List | Select-Object Path, LineNumber, Line