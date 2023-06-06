$rootFolder = (Get-Item -Path ".\").FullName

# Retrieve all XML files in the subfolders of the root folder
$xmlFiles = Get-ChildItem -Path $rootFolder -Recurse -Filter "*.xml" -File

foreach ($xmlFile in $xmlFiles) {
    $xmlContent = Get-Content -Path $xmlFile.FullName -Raw
    $updatedContent = $xmlContent -replace '(<animNode x_extends=")(.*?)(">)', ('$1Slinky$2$3')

    # Overwrite the XML file with the updated content
    $updatedContent | Set-Content -Path $xmlFile.FullName
    
    Write-Host "Updated $($xmlFile.Name)"
}