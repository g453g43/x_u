# deploy.ps1 - Automated Deployment Script for x_u private
$source = "C:\Users\vin\.gemini\antigravity\scratch\roblox_project\main_bundle.lua"
$dest = "C:\Users\vin\.gemini\antigravity\scratch\x_u_upload\sniper_duels.lua"
$repoDir = "C:\Users\vin\.gemini\antigravity\scratch\x_u_upload"

# Copy the file
Copy-Item -Path $source -Destination $dest -Force

# Git operations
Set-Location -Path $repoDir
git add sniper_duels.lua
git commit -m "Auto-update: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
git push origin main
