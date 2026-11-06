Write-Host "==================================================================" -ForegroundColor Cyan
Write-Host "Project NULL — Vesper District 01: Shunting Cut Platform 02" -ForegroundColor Green
Write-Host "Target Renderer: gl_compatibility (OpenGL 3.3 Core Profile)" -ForegroundColor Yellow
Write-Host "Controls:" -ForegroundColor White
Write-Host "  [W, A, S, D]        : Move Thomas Mercer"
Write-Host "  [Mouse Look]        : Rotate Camera Rig"
Write-Host "  [V] / [Tab]         : Toggle First-Person / Third-Person Camera"
Write-Host "  [E]                 : Interact with Clues and Signal Levers"
Write-Host "  [Esc] / Right Click : Close 3D Clue Inspection Viewport"
Write-Host "==================================================================" -ForegroundColor Cyan

& "$env:LOCALAPPDATA\Microsoft\WinGet\Packages\GodotEngine.GodotEngine_Microsoft.Winget.Source_8wekyb3d8bbwe\Godot_v4.7.2-stable_win64.exe" --path "06_GAME_PROJECT"
