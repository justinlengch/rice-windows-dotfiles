# Launch target for Win+Alt+F: load the profile without the Fastfetch greeting.
$global:SkipWezTermGreeting = $true
if (Test-Path -LiteralPath $PROFILE) { . $PROFILE }
Remove-Variable SkipWezTermGreeting -Scope Global
y
