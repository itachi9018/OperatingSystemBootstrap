param(
[string]$VaultPath = ".\Operating System"
)


$requiredFolders = Import-PowerShellDataFile `
".\data\folders.psd1"



Write-Host ""
Write-Host "Validating Vault..."
Write-Host ""


foreach($folder in $requiredFolders)
{

$path = Join-Path `
$VaultPath `
$folder


if(Test-Path $path)
{
Write-Host "[OK] $folder"
}

else
{
Write-Host "[MISSING] $folder"
}

}


Write-Host ""
Write-Host "Validation Finished."