

# $PSScriptRoot <- script root
$ScriptPath = Split-Path -Parent -Path $($MyInvocation.MyCommand.Definition)

$jsonFile = $($ScriptPath + "\gt.json")
Write-Output $jsonFile

#read the json data
$json = (Get-Content $jsonFile -Raw) | ConvertFrom-Json -Depth 10| Sort-Object directory

# First verify and argument was passed in
if ($args[0].Count -eq 0)
{   
   # No Command Passed 
    Write-Output ""
    Write-Host "No Command was Passed" -ForegroundColor red 
    (Write-Host "Valid Commands: " -ForegroundColor white -NoNewLine) + $(Write-Host " (List, Add, Remove, Update) " -ForegroundColor green -NoNewLine) 

    #Write-Output $json;
    exit
}



# Switch the argument
switch -Exact ($args[0])
{
    'List'
    {
        Write-Output $json;
    }
    'Add'
    {
        # Ask user for command name
        Write-Output "";
        $Command = $(Write-Host "Enter new command name" -ForegroundColor red -NoNewLine) + $(Write-Host " (cancel to exit) " -ForegroundColor yellow -NoNewLine; Read-Host) 
        #$Command = Read-Host "Enter new command name (cancel to exit)"
        if ($Command -eq 'cancel')
        {
            Write-Output "cancelled by user"
            exit
        }
        else
        {
            if($json.Command -eq $Command)
            {
                Write-Host "Command already exist... Exiting..." -ForegroundColor red -NoNewLine
                exit
            }

            # Ask User for Title
            Write-Output "";
            $Title = $(Write-Host "Enter Title" -ForegroundColor red -NoNewLine) + $(Write-Host " (cancel to exit) " -ForegroundColor yellow -NoNewLine; Read-Host) 
            #$Title = Read-Host "Enter Title (cancel to exit)"
            if ($Title -eq 'cancel')
            {
                exit
            }

            # Ask User for Directory
            Write-Output "";
            $Directory = $(Write-Host "Enter full Directory path" -ForegroundColor red -NoNewLine) + $(Write-Host " (cancel to exit) " -ForegroundColor yellow -NoNewLine; Read-Host) 
            #$Directory = Read-Host "Enter full Directory path (cancel to exit)"
            if ($Directory -eq 'cancel')
            {
                exit
            }

            # Check if Directory Exists
            if (!(Test-Path $Directory -PathType Container)) 
            {
                Write-Host "Folder does not exist.  Try again." -ForegroundColor red -NoNewLine
                exit
            }


            # Create new json object and give it properites
            $newJsonObj = @()
            $newJsonObj = "" | Select-Object Command, Title, Directory

            # Set the new json properties
            $newJsonObj.Command = $Command
            $newJsonObj.Title = $Title
            $newJsonObj.Directory = $Directory

            # Add the new json object to the existing json object
            $json += $newJsonObj
            
            # Save the json file
            $json | ConvertTo-Json | Set-Content $jsonfile
            $json

        }
    }
    'Remove'
    {
        $Command = $(Write-Host "Enter command name to remove" -ForegroundColor red -NoNewLine) + $(Write-Host " (cancel to exit) " -ForegroundColor yellow -NoNewLine; Read-Host) 
        $newjson = $json | Where-Object Command -ne $Command
        # Save the json file
        $newjson | ConvertTo-Json | Set-Content $jsonfile
        $newjson

    }
    'Update'
    {
        # Ask user for command name
        $Command = $(Write-Host "Enter command name to update" -ForegroundColor red -NoNewLine) + $(Write-Host " (cancel to exit) " -ForegroundColor yellow -NoNewLine; Read-Host) 
        #$Command = Read-Host "Enter command name to update(cancel to exit)";
        if ($Command -eq 'cancel')
        {
            Write-Output "cancelled by user"
            exit
        }
        else
        {
            if($json.Command -eq $Command)
            {
                # Create new json object and give it properites
                $editItem = $json | Where-Object Command -eq $Command

                # Ask User for Title
                Write-Output "";
                $y = $(Write-Host "Do you want to change the TITLE" -ForegroundColor yello -NoNewLine) + $(Write-Host " (entery 'y' to modify) " -ForegroundColor white -NoNewLine; Read-Host) 
                #$y = Read-Host "Modify Title (entery 'y' to modify)"
                if ($y -eq 'y')
                {
                    Write-Output "";
                    $Title = $(Write-Host "Enter new title" -ForegroundColor blue -NoNewLine) + $(Write-Host " (cancel to exit) " -ForegroundColor yellow -NoNewLine; Read-Host) 
                    #$Title = Read-Host "Enter Title (cancel to exit)"
                    if ($Title -eq 'cancel')
                    {
                        exit
                    }
                    # Set Title to new value
                    $editItem.Title = $Title
                }

                # Ask User for Directory
                Write-Output "";
                $y = $(Write-Host "Do you want to change the DIRECTORY" -ForegroundColor yellow -NoNewLine) + $(Write-Host " (entery 'y' to modify) " -ForegroundColor white -NoNewLine; Read-Host) 
                #$y = Read-Host "Modify Directory (entery 'y' to modify)"
                if ($y -eq 'y')
                {
                    Write-Output "";
                    $Directory = $(Write-Host "Enter new directory" -ForegroundColor blue -NoNewLine) + $(Write-Host " (cancel to exit) " -ForegroundColor yellow -NoNewLine; Read-Host) 
                    #$Directory = Read-Host "Enter full Directory path (cancel to exit)"
                    if ($Directory -eq 'cancel')
                    {
                        exit
                    }
                
                    # Check if Directory Exists
                    if (!(Test-Path $Directory -PathType Container)) 
                    {
                        Write-Output "";
                        Write-Host "Folder does not exist.  Try again." -ForegroundColor red
                        Write-Output "";
                        exit
                    }

                    # Set Directory to new value
                    $editItem.Directory = $Directory
                }
                    
                # Create object with all nodes exept the item we are editing
                $jsonTrimmed = $json | Where-Object Command -ne $Command

                # Append the edited item to json
                $jsonTrimmed += $editItem

                # Save the json file
                $jsonTrimmed | ConvertTo-Json | Set-Content $jsonfile
                $jsonTrimmed
            }
        }
    }
}