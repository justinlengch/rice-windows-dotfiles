# Dot-source this file from your PowerShell 7 $PROFILE.
if ($env:TERM_PROGRAM -eq 'WezTerm') {
    Remove-Item Env:NO_COLOR -ErrorAction SilentlyContinue
    $env:TERM = 'xterm-256color'
    $env:COLORTERM = 'truecolor'
    $PSStyle.OutputRendering = 'Ansi'
}

if ($env:WT_SESSION -or $env:TERM_PROGRAM -eq 'WezTerm') {
    if (Get-Module -ListAvailable Terminal-Icons) { Import-Module Terminal-Icons }
    if (Get-Command oh-my-posh -ErrorAction SilentlyContinue) {
        oh-my-posh init pwsh --config (Join-Path $env:USERPROFILE '.config\oh-my-posh\wallpaper.omp.json') | Invoke-Expression
    }
}

if ($env:TERM_PROGRAM -eq 'WezTerm' -and -not $global:SkipWezTermGreeting) {
    if (Get-Command fastfetch -ErrorAction SilentlyContinue) {
        fastfetch --config (Join-Path $env:USERPROFILE '.config\fastfetch\wezterm.jsonc')
    }
}

function y {
    $yaziCwdFile = (New-TemporaryFile).FullName
    try {
        yazi.exe @args --cwd-file="$yaziCwdFile"
        $yaziCwd = Get-Content -LiteralPath $yaziCwdFile -Raw -Encoding UTF8
        if ($yaziCwd) {
            $yaziCwd = $yaziCwd.TrimEnd([char]13, [char]10)
            if ($yaziCwd -ne $PWD.Path -and (Test-Path -LiteralPath $yaziCwd -PathType Container)) {
                Set-Location -LiteralPath $yaziCwd
            }
        }
    } finally {
        Remove-Item -LiteralPath $yaziCwdFile -ErrorAction SilentlyContinue
    }
}
