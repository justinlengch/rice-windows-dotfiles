$fontOutput = (& wezterm ls-fonts 2>$null) -join "`n"
$primary = [regex]::Match($fontOutput, '(?m)^\s*"([^"]+)"').Groups[1].Value
$lua = Get-Content -LiteralPath '__HOME_NATIVE__\.config\wezterm\wezterm.lua' -Raw
$size = [regex]::Match($lua, 'config\.font_size\s*=\s*([\d.]+)').Groups[1].Value
if ($primary) {
    if ($size) { Write-Output "$primary ($size pt)" } else { Write-Output $primary }
} else { Write-Output 'Font could not be resolved' }

