

# $PSScriptRoot <- script root
$ScriptPath = Split-Path -Parent -Path $($MyInvocation.MyCommand.Definition)


$jsonFile = $($ScriptPath + "\gt.json")
Write-Host $jsonFile  -ForegroundColor blue

#read the json data
$json = (Get-Content $jsonFile -Raw) | ConvertFrom-Json | Sort-Object title



#initialize the dir variable
$dir = ""

#check the value of the argument (first and only)
if ($args[0].Count -eq 0)
{   
   #Clear-Host 
    Write-Output $json;
    #Write-Output "test        stest";
    #Write-Output "Home        $Env:HomeDrive$Env:HomePath";
}
elseif($args[0] -eq "Home")
{
    #If the target is "Home" then go to the computer home path
    cd -Path $Env:HomePath
}
else
{

    Write-Output ""
    
    #Loop through all of the elements in the json file
    foreach ($i in $json.GetEnumerator()) { 

        #If the command matches what is in the json data then change directory to that path
        if ($i.command -eq $args[0])
         {
            #set the dir variable
            $dir = $args[0]

            Write-Output "Changing directories... " $i.directory
            
            #do the change directory
            cd -Path $i.directory
            break

        }
    }


    #if we have looped all the elements and no matches then give not listed notice
    if ($dir -eq "")
    {
        Write-Output "Directory not listed in JSON file."
    }

}


Write-Output ""