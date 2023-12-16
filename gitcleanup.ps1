param (
   [Parameter(Mandatory=$true)]
   [string]$BranchToKeep
)

# this block is pointless and will never be hit due to mandatory parameter
if ([string]::IsNullOrEmpty($BranchToKeep)) {
   Write-Host "You MUST provide a branch name to keep"
   return
}

#ask the user if they would like push the code to the cloud repository
$AreYouSure = Read-Host "Are you SURE you want to run this script? Note the branch you are keeping.  Is it 'main' or 'master' << You MUST type 'yes' to continue >>" 

if($AreYouSure -eq "yes")
{
   Write-Host "Removing ALL Git branches except $BranchToKeep"

   git checkout $BranchToKeep
   
   git branch -D  @(git branch | select-string -NotMatch $BranchToKeep | Foreach {$_.Line.Trim()})
}
