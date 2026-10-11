# Rice Windows Dotfiles

My Windows desktop and terminal setup: a customized YASB bar, Komorebi tiling, a translucent WezTerm terminal, Fastfetch artwork, a matching PowerShell prompt, and Yazi.

## What I changed

- **YASB:** customized an existing theme with rounded segments and a Catppuccin-style palette. Workspaces, clock, and running apps are on the left; the active app is centered; tray, CPU, RAM, weather, volume, and power are on the right. The bar is 36 px high. Notifications are defined but omitted from the visible widget list. Volume opens an audio menu, and the tray hides unpinned icons until expanded.
- **WezTerm:** Catppuccin Frappe, JetBrainsMonoNL Nerd Font Propo at 12 pt, **70% background opacity**, resize-only window decorations, no tab bar for a single tab, padding, a blinking bar cursor, and PowerShell 7 as the shell. This is transparency; no acrylic/blur backdrop is configured.
- **Fastfetch:** a custom image on the left, a personalized greeting, colored hardware/software/uptime sections, RAM and drive bars, and a helper that reads WezTerm's font and font size. It runs automatically when opening WezTerm.
- **PowerShell:** ANSI/truecolor output in WezTerm, Terminal-Icons, and a custom Oh My Posh prompt with folder, Git branch/status, and execution time.
- **Yazi:** installed with Scoop, using default Yazi settings. The `y` function returns the shell to the directory selected in Yazi. A dedicated launcher skips the Fastfetch greeting.
- **Komorebi / whkd:** seven workspaces with different layouts, 20 px workspace padding, 6 px container padding, 8 px muted lavender borders, Flow Launcher excluded from tiling, and keyboard shortcuts for focus, movement, stacking, resizing, workspaces, and app launchers.

These are copies of the current setup, with home-directory paths converted to installation placeholders. Backups, logs, runtime state, credentials, and inactive artwork are excluded. Your live configs are not changed by cloning this repository.

## Files and destinations

| Repository file | Installed location |
| --- | --- |
| `yasb/config.yaml`, `yasb/styles.css` | `%USERPROFILE%\.config\yasb\` |
| `fastfetch/wezterm.jsonc`, artwork, font helper | `%USERPROFILE%\.config\fastfetch\` |
| `wezterm/wezterm.lua` | `%USERPROFILE%\.config\wezterm\wezterm.lua` |
| `oh-my-posh/wallpaper.omp.json` | `%USERPROFILE%\.config\oh-my-posh\wallpaper.omp.json` |
| `powershell/*.ps1` | `%USERPROFILE%\.config\powershell\` |
| `komorebi/komorebi.json`, `applications.json` | `%USERPROFILE%\` |
| `whkd/whkdrc` | `%USERPROFILE%\.config\whkdrc` |

The installer appends a dot-source line to PowerShell 7's `$PROFILE`. No custom `yazi.toml`, keymap, theme, or plugins were found; the Yazi customization here is its shell integration.

## Install the apps

Use PowerShell 7 on Windows. With [Scoop](https://scoop.sh/) already installed:

```powershell
scoop install git pwsh fastfetch yazi
```

Install [WezTerm](https://wezterm.org/installation.html), [YASB](https://github.com/amnweb/yasb), [Komorebi and whkd](https://lgug2z.github.io/komorebi/installation.html), and [Oh My Posh](https://ohmyposh.dev/docs/installation/windows) following their official instructions. Ensure `pwsh`, `fastfetch`, `wezterm`, `yazi`, `oh-my-posh`, `komorebic`, and `whkd` are on PATH. Komorebi has its own license; check the upstream terms.

Install Terminal-Icons in PowerShell 7:

```powershell
Install-Module Terminal-Icons -Scope CurrentUser -Repository PSGallery
```

Install [JetBrainsMono Nerd Font](https://www.nerdfonts.com/font-downloads). WezTerm expects `JetBrainsMonoNL Nerd Font Propo`; YASB's icon style expects `JetBrainsMono NFP`. If your installed font names differ, adjust `wezterm.lua` and `styles.css`.

## Restore the configs

```powershell
git clone git@github.com:justinlengch/rice-windows-dotfiles.git
cd rice-windows-dotfiles
pwsh -NoProfile -File .\install.ps1 -WhatIf
pwsh -NoProfile -File .\install.ps1
```

Existing destination files get timestamped `.bak` copies. The installer expands `__HOME_FWD__`, `__HOME_JSON__`, and `__HOME_NATIVE__` to your home directory; use it rather than copying the templates directly. It does not install apps, alter environment variables, or restart services.

If your profile already contains the old WezTerm greeting, Oh My Posh initialization, or `y` function, remove the duplicate old blocks after reviewing the backup. To reload the profile:

```powershell
. $PROFILE
```

Launch WezTerm again to see the transparent terminal and startup greeting. If a `~/.wezterm.lua` already exists, it can take precedence over the installed config; merge it or back it up before using this setup.

## YASB weather and personal shortcuts

Copy `yasb/.env.example` to `%USERPROFILE%\.config\yasb\.env`, then replace the placeholders with your WeatherAPI key and city. Never commit the resulting `.env`. The widget uses `api_key: env` and `location: env`. See [YASB configuration](https://github.com/amnweb/yasb/wiki/Configuration).

Home-menu paths are adapted to the current user's Downloads, Documents, and Pictures. Check the optional `apps` widget's paths if you enable it: Outlook and Music/Pictures shortcuts may need changes. The whkd app shortcuts assume Helium and WezTerm are installed in their usual Program Files locations, and the Codex app launcher assumes its Windows package ID.

Start tiling and hotkeys with:

```powershell
komorebic start --whkd
```

Start YASB separately. Startup-task registration and the Windows taskbar's own appearance/settings are machine-specific and are not exported here. The YASB workspace widget uses Komorebi's workspace settings.

## Yazi on Windows

Yazi needs Git for Windows' `file.exe` for MIME detection. In PowerShell, set its actual location if it is not discovered automatically:

```powershell
$fileExe = 'C:\Program Files\Git\usr\bin\file.exe'
if (-not (Test-Path -LiteralPath $fileExe)) { throw 'Adjust $fileExe to your Git installation.' }
[Environment]::SetEnvironmentVariable('YAZI_FILE_ONE', $fileExe, 'User')
$env:YAZI_FILE_ONE = $fileExe
y
```

If Git was installed through Scoop, find `file.exe` under your Scoop Git installation instead. Extra preview/search tools are optional; see [Yazi installation](https://yazi-rs.github.io/docs/installation/).

Use `h/j/k/l` to navigate, Enter to open a file, and `q` to quit. The `y` wrapper changes PowerShell's directory on exit. Yazi runtime state normally lives under `%APPDATA%\yazi`; it is deliberately excluded.

## Keyboard shortcuts

| Shortcut | Action |
| --- | --- |
| Alt + H/J/K/L | Focus left/down/up/right |
| Alt + Shift + H/J/K/L | Move a window |
| Alt + 1…7 | Switch workspace |
| Alt + Shift + 1…7 | Move window to workspace |
| Alt + T | Toggle floating |
| Alt + Shift + F | Toggle monocle |
| Alt + Shift + R | Retile |
| Alt + Shift + O | Reload Komorebi configuration |
| Win + Alt + 1 | Focus/open Helium |
| Win + Alt + 3 | Focus/open WezTerm |
| Win + Alt + C | Open Codex |
| Win + Alt + F | Open Yazi in WezTerm without the greeting |

The whkd template retains upstream Alt+8 shortcuts, but this setup only defines seven workspaces; use 1…7 or add an eighth workspace.

## Notes and credits

- Snapshot: October 11, 2026. Installed Scoop manifests showed Fastfetch 2.69.0, Yazi 26.9.1, and Komorebi 0.1.41. Configs may need adjustment for future versions.
- [WezTerm opacity](https://wezterm.org/config/lua/config/window_background_opacity.html): `0.70` means 70% opaque. Lower values reveal more of the desktop behind the terminal.
- The Fastfetch image uses the iTerm image protocol supported by WezTerm. Other terminals may not display it. [Fastfetch logo options](https://github.com/fastfetch-cli/fastfetch/wiki/Logo-options).
- The YASB stylesheet refers to “Soft Segment.” The exact original theme source/author has not been verified; this repository preserves a customized copy and does not claim authorship of the original theme.
- The active Fastfetch artwork is included to reproduce this setup; its original source/license has not been identified. No blanket license is applied to third-party artwork or theme assets.
- Wallpapers, Windows taskbar changes, app binaries, SSH keys, API keys, and system startup registrations are not included.
