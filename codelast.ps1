$folder = $args[0]

#Get the last created filename
$file = (Get-ChildItem $folder -File | Sort-Object LastWriteTime -Descending| Select-Object -First 1 Name).Name

# Watch the file in live view
code $file.ToString()

#Write-Output($file)