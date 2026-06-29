param(
    [string]$VaultPath
)


$config = Import-PowerShellDataFile ".\config.psd1"

$folders = Import-PowerShellDataFile ".\data\folders.psd1"


if (!$VaultPath)
{
    $VaultPath = $config.DefaultVaultPath
}


Write-Host ""
Write-Host "================================"
Write-Host " Operating System Bootstrap"
Write-Host "================================"
Write-Host ""


#
# Create Vault
#

if (!(Test-Path $VaultPath))
{
    New-Item `
        -ItemType Directory `
        -Path $VaultPath `
        | Out-Null
}



#
# Create folders
#

foreach ($folder in $folders)
{

    $path = Join-Path `
        $VaultPath `
        $folder


    if (!(Test-Path $path))
    {

        New-Item `
            -ItemType Directory `
            -Path $path `
            | Out-Null


        Write-Host "[CREATED] $folder"

    }

}



#
# Copy content helper
#

function Copy-MarkdownFolder
{

param(
[string]$Source,
[string]$Destination
)


if (!(Test-Path $Source))
{
    return
}


Get-ChildItem `
    $Source `
    -File `
    -Filter "*.md" |
ForEach-Object {


$target =
Join-Path `
$Destination `
$_.Name



if(
(!$config.OverwriteExisting)
-and
(Test-Path $target)
)
{

Write-Host "[SKIP] $target"

}

else
{

Copy-Item `
$_.FullName `
$target `
-Force


Write-Host "[COPY] $target"

}


}

}



#
# Install content
#

Copy-MarkdownFolder `
".\content\templates" `
"$VaultPath\11 Templates"



Copy-MarkdownFolder `
".\content\ai" `
"$VaultPath\12 AI"



Copy-MarkdownFolder `
".\content\maps" `
"$VaultPath\13 Maps"



Copy-MarkdownFolder `
".\content\specification" `
"$VaultPath\15 Vault Specification"



#
# Root files
#

if(Test-Path ".\content\root")
{

Copy-Item `
".\content\root\*" `
$VaultPath `
-Force

}



Write-Host ""

Write-Host "================================"
Write-Host " Bootstrap Complete"
Write-Host "================================"