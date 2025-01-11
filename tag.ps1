# Run the Git command and capture its output
$latestTag = git describe --tags --abbrev=0

$year = (Get-Date).Year
$month = (Get-Date).Month
$day = (Get-Date).Day
$newTag = ""

if(-not $latestTag -or $latestTag -eq "")
{
    Write-Host "No Prior Tag Found"
    $newRevision = 1
}
else 
{

    # Display the captured output
    Write-Host "The latest tag is:" -NoNewline
    Write-Host $latestTag -ForegroundColor Yellow

    # Split the value into an array using '.' as the delimiter
    $parts = $latestTag -split '\.'

    # Access individual parts
    $tag_year = $parts[0]
    $tag_month = $parts[1]
    $tag_day = $parts[2]
    $tag_revision = $parts[3]

    # compare latest tag parts to current year.month.day
    if($year -eq $tag_year -and $month -eq $tag_month -and $day -eq $tag_day)
    {
        $tag_revision = $tag_revision + 1
        $newTag = "$tag_year.$tag_month.$tag_day.$newRevision"
    }
    else 
    {
        $newTag = "$year.$month.$day.1"
    }
}

Write-Host "New Tag will be: " -NoNewline
Write-Host $newTag -ForegroundColor Green

$comment_question = Read-Host "Would you like to add a comment?  If yes then type 'y'"
if($comment_question -eq "y")
{
    $comment = Read-Host "Enter your comment"
}
else {
    $comment = "No Comment Added"
}

#send message to the terminal
Write-Host "Tag:" -NoNewline
Write-Host " $newTag" -ForegroundColor Green
Write-Host "Comment:" -NoNewline
Write-Host " $comment" -ForegroundColor Blue

#ask the user if they would like push the code to the cloud repository
$PushToCloud = Read-Host "Are these values correct?  If yes then type 'y'"

#if the user typed "y" then run the git push command
if($PushToCloud -eq "y")
{
    Write-Host "Sending commands..."
    #run the git commit commands
    git tag -a $newTag -m $comment
    git push origin --tags
}



