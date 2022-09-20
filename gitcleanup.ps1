
Write-Host "Removing ALL Git branches but Master"

git checkout master

git branch -D  @(git branch | select-string -NotMatch "master" | Foreach {$_.Line.Trim()})


