
$SearchString = $args[0]

#if the search pattern is empty do not continue
#CLI then exit the script
if($SearchString -eq "" -or $args.Count -eq 0)
{
    Write-Host "Search pattern must be provided."
    Return
}

Get-ChildItem -Recurse | Select-String $SearchString -List | Select-Object Path, LineNumber, Matches, Line