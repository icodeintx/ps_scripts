Write-Host "Finding Git Folders Recursive" -ForegroundColor blue 

Get-ChildItem -filter ".git" -Directory -Recurse -Force |  ForEach-Object { Write-Host $_.FullName -ForegroundColor green}