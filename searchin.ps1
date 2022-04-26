
$SearchString = $args[0]

Get-ChildItem -Recurse | Select-String $SearchString -List | Select-Object Path, LineNumber, Matches, Line