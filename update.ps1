param(
[string]$VaultPath = ".\Operating System"
)


Write-Host ""
Write-Host "Updating Operating System Vault..."
Write-Host ""


.\bootstrap.ps1 `
-VaultPath $VaultPath


Write-Host ""
Write-Host "Update Complete."