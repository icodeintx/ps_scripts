
$SearchString = $args[0]

Get-ChildItem -Path .\ -Filter $SearchString -Recurse -File| Sort-Object Length -Descending | ForEach-Object {$_.BaseName}