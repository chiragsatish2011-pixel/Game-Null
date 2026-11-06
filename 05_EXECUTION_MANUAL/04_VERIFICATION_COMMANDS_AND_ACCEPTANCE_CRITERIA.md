# PROJECT NULL — BOOK 05: MASTER EXECUTION MANUAL
## CHAPTER 04: VERIFICATION COMMAND SEQUENCES & ACCEPTANCE CRITERIA

**Document ID:** PNL-B05-CH04  
**Document Version:** 1.0.0  
**Authority:** Production Director (Lead Production Agent)  
**Status:** Authored & Ratified  
**Target Engine:** Godot Engine 4.7.2 Stable (`gl_compatibility` / OpenGL 3.3 Core Profile)  
**Host Hardware:** Windows 11 Home 64-bit | Intel Core i5-12400F | 16 GB DDR4 RAM | NVIDIA GeForce G210 (1024 MB DDR3 VRAM)  

---

## 1. MASTER VERIFICATION COMMAND DIRECTORY

All verification gates in Project NULL are driven by deterministic command-line executions. Every command below specifies its required arguments, expected OS exit code, and stdout/stderr regex pass matchers:

```text
┌─────────────────────────────────┬──────────────────────────────────────────┬───────────┬─────────────────────────────────────┐
│ Subsystem / Verification Gate   │ Execution Command Line                   │ Exit Code │ Stdout Pass Criteria Regex          │
├─────────────────────────────────┼──────────────────────────────────────────┼───────────┼─────────────────────────────────────┤
│ 1. Pre-Commit Quality Gate      │ `python 04_AI_STUDIO/scripts/            │ 0         │ `PRE-COMMIT GATE EVALUATION         │
│                                 │  precommit_audit.py`                     │           │  COMPLETE`                          │
├─────────────────────────────────┼──────────────────────────────────────────┼───────────┼─────────────────────────────────────┤
│ 2. Semantic AST Hasher          │ `python 04_AI_STUDIO/scripts/            │ 0         │ `SEMANTIC_HASH: [a-f0-9]{64}`       │
│                                 │  hash_ast.py <file.gd>`                  │           │                                     │
├─────────────────────────────────┼──────────────────────────────────────────┼───────────┼─────────────────────────────────────┤
│ 3. GLB Header & Topology Check  │ `python 07_ASSETS/scripts/               │ 0         │ `PASS: Triangle count \d+ <= \d+`   │
│                                 │  inspect_glb.py <asset.glb>`             │           │                                     │
├─────────────────────────────────┼──────────────────────────────────────────┼───────────┼─────────────────────────────────────┤
│ 4. Pillow ORM Channel Packer    │ `python 07_ASSETS/scripts/               │ 0         │ `SUCCESS: Packed ORM texture saved` │
│                                 │  pack_orm.py --ao .. --rough .. --out ..`│           │                                     │
├─────────────────────────────────┼──────────────────────────────────────────┼───────────┼─────────────────────────────────────┤
│ 5. Collision Generator          │ `python 07_ASSETS/scripts/               │ 0         │ `SUCCESS: Generated CollisionShape3D│
│                                 │  generate_collision.py <asset.glb>`      │           │  resource`                          │
├─────────────────────────────────┼──────────────────────────────────────────┼───────────┼─────────────────────────────────────┤
│ 6. Headless Test Suite Runner   │ `& "Godot_v4.7.2-stable_win64_console.   │ 0         │ `ALL TESTS PASSED \(0 FAILED\)`     │
│                                 │  exe" --headless --path "06_" -s tests/..│           │                                     │
├─────────────────────────────────┼──────────────────────────────────────────┼───────────┼─────────────────────────────────────┤
│ 7. G210 Performance Watchdog    │ `& "Godot_v4.7.2-stable_win64_console.   │ 0         │ `BENCHMARK PASS: DrawCalls=\d+      │
│                                 │  exe" --headless --path "06_" -s bench/..│           │  VRAM=\d+MB FPS>=60`                │
└─────────────────────────────────┴──────────────────────────────────────────┴───────────┴─────────────────────────────────────┘
```

---

## 2. HARDWARE ACCEPTANCE CRITERIA MATRIX (GEFORCE G210 BASELINE)

All compiled scenes and assets must satisfy the rigid physical boundaries of the NVIDIA GeForce G210 running under Godot 4.7.2 Compatibility mode:

```text
┌──────────────────────────────────────┬──────────────────────┬──────────────────────┬───────────────────────────────┐
│ Performance Metric                   │ Vertical Slice Target│ Hard Hardware Ceiling│ Verification Methodology      │
├──────────────────────────────────────┼──────────────────────┼──────────────────────┼───────────────────────────────┤
│ Frame Draw Calls (Raster Passes)     │ 120 – 195 passes     │ <= 250 passes        │ `Performance.RENDER_TOTAL_    │
│                                      │                      │                      │  DRAW_CALLS_IN_FRAME`         │
├──────────────────────────────────────┼──────────────────────┼──────────────────────┼───────────────────────────────┤
│ Frame Primitives (Triangles)         │ 25,000 – 48,000      │ <= 65,000            │ `Performance.RENDER_TOTAL_    │
│                                      │                      │                      │  PRIMITIVES_IN_FRAME`         │
├──────────────────────────────────────┼──────────────────────┼──────────────────────┼───────────────────────────────┤
│ Dedicated Scene VRAM                 │ 220 – 350 MB         │ <= 750 MB (DEC-0033) │ Dual-Channel WDDM Performance │
│                                      │                      │                      │ Counters & Engine Telemetry   │
├──────────────────────────────────────┼──────────────────────┼──────────────────────┼───────────────────────────────┤
│ Target Render Resolution             │ 1280 x 720 (720p)    │ 1280 x 720           │ Fixed Project Viewport        │
├──────────────────────────────────────┼──────────────────────┼──────────────────────┼───────────────────────────────┤
│ Sustained Frame Rate                 │ 60.0 FPS             │ >= 60.0 FPS          │ Frame delta <= 16.66 ms       │
├──────────────────────────────────────┼──────────────────────┼──────────────────────┼───────────────────────────────┤
│ Max Directional Shadow Cascades      │ 2 splits (1024x1024) │ 2 splits (1024x1024) │ DirectionalLight3D inspector  │
├──────────────────────────────────────┼──────────────────────┼──────────────────────┼───────────────────────────────┤
│ Real-Time Point/Spot Light Shadows   │ Exactly 0 (DISABLED) │ 0 (DISABLED)         │ `shadow_enabled = false`      │
├──────────────────────────────────────┼──────────────────────┼──────────────────────┼───────────────────────────────┤
│ Max Active Sampler Slots per Material│ Exactly 1 (Packed ORM│ <= 8 hardware units  │ Material Shader Inspector     │
└──────────────────────────────────────┴──────────────────────┴──────────────────────┴───────────────────────────────┘
```

---

## 3. MILESTONE VERIFICATION COMMAND SEQUENCES

### 3.1 Milestone `v0.1.0-bible-lock` Verification Sequence
To certify that all five foundational production bibles are complete, synchronized, and defect-free:

```powershell
# Step 1: Execute pre-commit quality gate
python 04_AI_STUDIO/scripts/precommit_audit.py

# Step 2: Verify semantic AST hasher on critical pipeline scripts
python 04_AI_STUDIO/scripts/hash_ast.py 04_AI_STUDIO/06_GOVERNANCE_BOUNDARIES.md

# Step 3: Run synthetic unit tests on GLB inspector
python 07_ASSETS/scripts/inspect_glb.py --test-synthetic

# Step 4: Verify all five master bibles exist on disk
Get-ChildItem -Path "01_STORY_BIBLE/BOOK_01_STORY_BIBLE.md", `
                    "02_VISUAL_BIBLE/BOOK_02_VISUAL_PRODUCTION_BIBLE.md", `
                    "03_ENGINEERING_BIBLE/BOOK_03_GAME_ENGINEERING_BIBLE.md", `
                    "04_AI_STUDIO/BOOK_04_AUTONOMOUS_AI_STUDIO_BIBLE.md", `
                    "05_EXECUTION_MANUAL/BOOK_05_MASTER_EXECUTION_MANUAL.md" | Select-Object FullName, Length
```
- **Pass Gate:** All four steps exit with code 0. All five master bibles exist with $> 15,000$ bytes length.

### 3.2 Milestone `v0.2.0-vertical-slice-blockout` Verification Sequence
```powershell
# Step 1: Headless compilation of autoload singletons and core types
& "Godot_v4.7.2-stable_win64_console.exe" --headless --path "06_GAME_PROJECT" --editor --quit

# Step 2: Headless player controller test suite
& "Godot_v4.7.2-stable_win64_console.exe" --headless --path "06_GAME_PROJECT" -s "tests/test_player_controller.gd"

# Step 3: Headless camera rig test suite
& "Godot_v4.7.2-stable_win64_console.exe" --headless --path "06_GAME_PROJECT" -s "tests/test_camera_rig.gd"
```

### 3.3 Milestone `v0.3.0-vertical-slice-verified` Verification Sequence
```powershell
# Step 1: Headless forensic investigation & contradiction test suite
& "Godot_v4.7.2-stable_win64_console.exe" --headless --path "06_GAME_PROJECT" -s "tests/test_investigation_systems.gd"

# Step 2: Headless dialogue and mission progression test suite
& "Godot_v4.7.2-stable_win64_console.exe" --headless --path "06_GAME_PROJECT" -s "tests/test_dialogue_systems.gd"

# Step 3: Full District 01 benchmark probe (measuring FPS, draw calls, and VRAM)
& "Godot_v4.7.2-stable_win64_console.exe" --headless --path "06_GAME_PROJECT" -s "tests/benchmark_district_01.gd"
```
- **Pass Gate:** Exit code 0; reported draw calls $\le 220$; reported scene VRAM $\le 350\text{ MB}$; average FPS $\ge 60.0$.

---
*End of Chapter 04 Specification.*