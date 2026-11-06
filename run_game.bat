@echo off
echo ==================================================================
echo Project NULL — Vesper District 01: Shunting Cut Platform 02
echo Target Renderer: gl_compatibility (OpenGL 3.3 Core Profile)
echo Target Baseline: GeForce G210 (1024 MB VRAM, 64-bit DDR3)
echo Controls:
echo   [W, A, S, D] / Arrow Keys : Move Thomas Mercer
echo   [Mouse Look]              : Rotate Camera Rig
echo   [V] / [Tab]               : Toggle First-Person / Third-Person Camera
echo   [E]                       : Interact with Clues and Signal Levers
echo   [Esc] / Right Click       : Close 3D Clue Inspection Viewport
echo ==================================================================
start "" "%LOCALAPPDATA%\Microsoft\WinGet\Packages\GodotEngine.GodotEngine_Microsoft.Winget.Source_8wekyb3d8bbwe\Godot_v4.7.2-stable_win64.exe" --path "06_GAME_PROJECT"
