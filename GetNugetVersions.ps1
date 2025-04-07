param(
    [string]$RootDirectory = (Get-Location).Path
)

# Array to hold all applications.
$Applications = @()

# Get all .csproj files recursively.
$csprojFiles = Get-ChildItem -Path $RootDirectory -Filter *.csproj -Recurse

foreach ($csproj in $csprojFiles) {
    try {
        # Load the XML from the .csproj file.
        [xml]$doc = Get-Content $csproj.FullName -Raw

        # Get the project name (file name without extension).
        $projectName = [System.IO.Path]::GetFileNameWithoutExtension($csproj.FullName)
        
        # Create a custom object to hold this app's info.
        $ApplicationObj = [PSCustomObject]@{
            CSPROJ          = $csproj.FullName
            ApplicationName = $projectName
            Nugets          = @()
        }
        
        # Find all PackageReference nodes regardless of their position in the XML.
        $packageReferences = $doc.SelectNodes("//PackageReference")
        
        foreach ($packageReference in $packageReferences) {
            $packageName = $packageReference.Include
            $version     = $packageReference.Version

            if (![string]::IsNullOrWhiteSpace($packageName) -and (![string]::IsNullOrWhiteSpace($version))) {
                # Create a custom object for each nuget package.
                $NugetObj = [PSCustomObject]@{
                    PackageName = $packageName
                    Version     = $version
                }
                $ApplicationObj.Nugets += $NugetObj
            }
        }
        
        # Add the application object to the list.
        $Applications += $ApplicationObj
    }
    catch {
        Write-Output "Error processing $($csproj.FullName): $($_.Exception.Message)"
    }
}

# Print the results.
foreach ($app in $Applications) {
    Write-Output ""
    Write-Output "Application: $($app.ApplicationName)"
    Write-Output "CSPROJ: $($app.CSPROJ)"
    foreach ($nuget in $app.Nugets) {
        Write-Output "  Package: $($nuget.PackageName), Version: $($nuget.Version)"
    }
}
