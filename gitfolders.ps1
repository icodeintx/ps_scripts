(Get-ChildItem -Path . -Filter "*.git" -Recurse -Directory -Force).Parent.FullName

#(Get-ChildItem -Path . -Filter "*.git" -Recurse -Directory -Force).FullName