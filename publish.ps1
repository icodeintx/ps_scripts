
#Remove the 'publish' folder if it exists
Remove-Item publish -Recurse

#Use DotNet to make a publish release in the 'publish' folder
dotnet publish -c Release -o ./publish