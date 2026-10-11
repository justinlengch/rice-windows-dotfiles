#Requires -Version 7.0
[CmdletBinding(SupportsShouldProcess)]
param(
    [string]$TargetHome = $env:USERPROFILE,
    [string]$ProfilePath = $PROFILE
)

$ErrorActionPreference = 'Stop'
$stamp = Get-Date -Format 'yyyyMMdd-HHmmss-fff'
$fileMap = [ordered]@{
    'yasb/config.yaml' = '.config/yasb/config.yaml'
    'yasb/styles.css' = '.config/yasb/styles.css'
    'fastfetch/wezterm.jsonc' = '.config/fastfetch/wezterm.jsonc'
    'fastfetch/wezterm-font.ps1' = '.config/fastfetch/wezterm-font.ps1'
    'fastfetch/larp-logo.png' = '.config/fastfetch/larp-logo.png'
    'wezterm/wezterm.lua' = '.config/wezterm/wezterm.lua'
    'oh-my-posh/wallpaper.omp.json' = '.config/oh-my-posh/wallpaper.omp.json'
    'komorebi/komorebi.json' = 'komorebi.json'
    'komorebi/applications.json' = 'applications.json'
    'whkd/whkdrc' = '.config/whkdrc'
    'powershell/rice-profile.ps1' = '.config/powershell/rice-profile.ps1'
    'powershell/start-yazi.ps1' = '.config/powershell/start-yazi.ps1'
}

foreach ($entry in $fileMap.GetEnumerator()) {
    $source = Join-Path $PSScriptRoot $entry.Key
    $destination = Join-Path $TargetHome $entry.Value
    if ($PSCmdlet.ShouldProcess($destination, 'Back up existing file and install config')) {
        New-Item -ItemType Directory -Path (Split-Path $destination) -Force | Out-Null
        if (Test-Path -LiteralPath $destination) {
            Copy-Item -LiteralPath $destination -Destination "$destination.$stamp.bak"
        }
        if ($source.EndsWith('.png')) {
            Copy-Item -LiteralPath $source -Destination $destination
        } else {
            $content = Get-Content -LiteralPath $source -Raw
            $content = $content.Replace('__HOME_FWD__', $TargetHome.Replace('\', '/'))
            $content = $content.Replace('__HOME_JSON__', $TargetHome.Replace('\', '\\'))
            $content = $content.Replace('__HOME_NATIVE__', $TargetHome)
            Set-Content -LiteralPath $destination -Value $content -Encoding utf8NoBOM
        }
    }
}

$profileLine = '. "' + (Join-Path $TargetHome '.config/powershell/rice-profile.ps1') + '"'
$oldProfile = if (Test-Path -LiteralPath $ProfilePath) { Get-Content -LiteralPath $ProfilePath -Raw } else { '' }
if ($oldProfile -notlike '*rice-profile.ps1*' -and $PSCmdlet.ShouldProcess($ProfilePath, 'Append dotfiles profile loader')) {
    New-Item -ItemType Directory -Path (Split-Path $ProfilePath) -Force | Out-Null
    if (Test-Path -LiteralPath $ProfilePath) { Copy-Item -LiteralPath $ProfilePath -Destination "$ProfilePath.$stamp.bak" }
    Add-Content -LiteralPath $ProfilePath -Value ("`n# Windows rice dotfiles`n" + $profileLine) -Encoding utf8NoBOM
}

Write-Output 'Finished. Review your profile for duplicate old startup blocks, configure YASB weather, then restart the apps.'
