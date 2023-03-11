$folder = $args[0]

#Get the last created filename
$file = (Get-ChildItem $folder -File | Sort-Object LastWriteTime -Descending| Select-Object -First 1 Name).Name

# Watch the file in live view
Get-Content $file.ToString() -wait

#Write-Output($file)