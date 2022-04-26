
#get the argument passed in from CLI
$Description = $args[0]


#if the description is empty or there are now arguments from 
#CLI then exit the script
if($Description -eq "" -or $args.Count -eq 0)
{
    Write-Host "Must provide description"
    Return
}

#send message to the terminal
Write-Host "Commiting to GIT"

#run the git add command to insert/update (stage) files in current project
git add .

#run the git commit command to commit the changes
git commit -m $Description


#ask the user if they would like push the code to the cloud repository
$PushToCloud = Read-Host "Would you like to PUSH to the cloud? (Y/N): "

#if the user typed "y" then run the git push command
if($PushToCloud -eq "y")
{
    git push
}

