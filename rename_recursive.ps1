param (
    [string]$SearchString,    # The literal string to search for
    [string]$ReplaceString,   # The string to replace it with
    [switch]$ViewOnly         # Optional switch to view the changes without renaming
)

# Ensure the search string is provided
if (-not $SearchString) {
    Write-Error "Please provide a valid SearchString."
    exit 1
}

# Ensure the replace string is provided
if (-not $ReplaceString) {
    Write-Error "Please provide a valid ReplaceString."
    exit 1
}

# Set the root path to the current directory
$RootPath = Get-Location

# Get all files in the directory and its subdirectories
Get-ChildItem -Path $RootPath -Recurse | ForEach-Object {
    # Check if the file name contains the search string
    if ($_.Name -like "*$SearchString*") {
        # Generate the new file name by replacing the search string with the replacement string
        $NewName = $_.Name.Replace($SearchString, $ReplaceString)

        if ($ViewOnly) {
            # Print the original and new file names
            Write-Output "Original Filename: $($_.Name)"
            Write-Output "New Filename: $NewName"
            Write-Output ""
        } else {
            # Rename the file
            Rename-Item -Path $_.FullName -NewName $NewName
            Write-Output "Renamed: $($_.Name) -> $NewName"
        }
    }
}
