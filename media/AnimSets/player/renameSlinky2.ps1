$rootFolder = (Get-Item -Path ".\").FullName

# Retrieve all XML files in the subfolders of the root folder
$xmlFiles = Get-ChildItem -Path $rootFolder -Recurse -Filter "*.xml" -File

foreach ($xmlFile in $xmlFiles) {
    $newName = "Slinky" + $xmlFile.Name
    $newPath = Join-Path -Path $xmlFile.DirectoryName -ChildPath $newName
    
    # Rename the XML file
    Rename-Item -Path $xmlFile.FullName -NewName $newName -Force
    
    Write-Host "Renamed $($xmlFile.Name) to $newName"
}