# PROJECT NULL — BOOK 05: MASTER EXECUTION MANUAL
## CHAPTER 03: AUTONOMOUS OPERATIONAL RUNBOOKS

**Document ID:** PNL-B05-CH03  
**Document Version:** 1.0.0  
**Authority:** Production Director (Lead Production Agent)  
**Status:** Authored & Ratified  
**Target Engine:** Godot Engine 4.7.2 Stable (`gl_compatibility` / OpenGL 3.3 Core Profile)  
**Host Hardware:** Windows 11 Home 64-bit | Intel Core i5-12400F | 16 GB DDR4 RAM | NVIDIA GeForce G210 (1024 MB DDR3 VRAM)  

---

## 1. RUNBOOK 1: GENERATIVE 3D ASSET SOURCING & OPTIMIZATION

### 1.1 Objective
Transform a raw 3D prompt or Poly Haven source into an engine-ready, PBR-mapped, collision-baked Godot resource without opening or installing Blender (**DEC-0002**).

### 1.2 Step-by-Step Procedure
1. **Asset Intake:** Query Meshy API or Tripo AI API for period-accurate prop geometry (e.g., "1970s Eastern European Railway Signal Lantern"). Download binary `.glb` payload into `07_ASSETS/incoming/signal_lantern_raw.glb`.
2. **Binary Header & Topology Inspection:**
   Execute the automated GLB inspector:
   ```powershell
   python 07_ASSETS/scripts/inspect_glb.py 07_ASSETS/incoming/signal_lantern_raw.glb
   ```
   - **Verification:** Script must confirm `mode == 4` (TRIANGLES), single material slot ($M = 1$), and triangle count $\le 1,500$ for props ($\le 800$ for modules).
   - **Failure Action:** If triangles $> 1,500$, asset is moved to `07_ASSETS/quarantine/` and prompt is retried with explicit poly-count limits.
3. **PBR Texture Channel Packing:**
   Convert independent AO, Roughness, and Metallic textures into a unified 3-channel ORM map:
   ```powershell
   python 07_ASSETS/scripts/pack_orm.py --ao "07_ASSETS/textures/lantern_ao.png" --rough "07_ASSETS/textures/lantern_rough.png" --metal "07_ASSETS/textures/lantern_metal.png" --out "07_ASSETS/textures/lantern_orm.png" --resolution 512
   ```
   - **Verification:** Script outputs `lantern_orm.png` ($512\times 512$ RGB, 85% compression quality).
4. **Collision Shape Generation:**
   Generate primitive collision geometry:
   ```powershell
   python 07_ASSETS/scripts/generate_collision.py 07_ASSETS/incoming/signal_lantern_raw.glb --type cylinder
   ```
   - **Verification:** Emits `signal_lantern_col.tres` (`CylinderShape3D: radius=0.18m, height=0.45m`).
5. **Asset Promotion:**
   Move sanitized files to `06_GAME_PROJECT/assets/props/signal_lantern/`.

---

## 2. RUNBOOK 2: MODULAR CSG BLOCKOUT TO ARRAYMESH BAKING

### 2.1 Objective
Construct rapid architectural graybox scenes using Godot CSG primitives and bake them into static, high-performance `ArrayMesh` resources to eliminate runtime CSG evaluation penalties.

### 2.2 Step-by-Step Procedure
1. **Modular CSG Assembly:**
   Assemble the blockout in a temporary staging scene (`07_ASSETS/blockouts/district_01_blockout.tscn`) using `CSGBox3D`, `CSGCylinder3D`, and `CSGPolygon3D` nodes strictly snapped to the $0.5\text{m}$ grid.
2. **Headless ArrayMesh Baking:**
   Execute Godot's headless mesh baking utility:
   ```powershell
   & "Godot_v4.7.2-stable_win64_console.exe" --headless --path "06_GAME_PROJECT" -s "scripts/tools/bake_csg_to_arraymesh.gd" -- "res://staging/district_01_blockout.tscn" "res://assets/world/district_01_mesh.tres"
   ```
3. **Scene Tree Replacement:**
   Replace the runtime CSG tree with a standard `MeshInstance3D` referencing `district_01_mesh.tres` and assign static `ConcavePolygonShape3D` on Collision Layer 1 (`World_Static`).
4. **Draw-Call Verification:**
   Verify that total draw calls for the blockout mesh do not exceed 64 passes.

---

## 3. RUNBOOK 3: AUTONOMOUS GDSCRIPT ENGINEERING WITH HEADLESS TDD

### 3.1 Objective
Implement gameplay, forensic, and camera features with 100% test-driven development, static type safety, and zero regression drift.

### 3.2 Step-by-Step Procedure
1. **Red Step (Failing Test First):**
   Create test file `06_GAME_PROJECT/tests/test_camera_rig.gd`:
   ```gdscript
   extends SceneTree

   func _init() -> void:
       var rig: Node = load("res://systems/camera/camera_rig.gd").new()
       rig.set_camera_mode(1) # Third person
       assert(rig.spring_arm.spring_length == 2.4, "Spring length mismatch")
       rig.set_camera_mode(0) # First person
       assert(rig.spring_arm.spring_length == 0.0, "First person length must be 0")
       print("TEST PASSED")
       quit(0)
   ```
   Execute the test runner and verify deterministic failure:
   ```powershell
   & "Godot_v4.7.2-stable_win64_console.exe" --headless --path "06_GAME_PROJECT" -s "tests/test_camera_rig.gd"
   ```
2. **Green Step (Minimum Implementation):**
   Implement `06_GAME_PROJECT/systems/camera/camera_rig.gd` with strict static types.
   Re-run test; verify clean exit with code 0.
3. **Refactor & Pre-Commit Audit:**
   Execute pre-commit compliance:
   ```powershell
   python 04_AI_STUDIO/scripts/precommit_audit.py
   python 04_AI_STUDIO/scripts/hash_ast.py "06_GAME_PROJECT/systems/camera/camera_rig.gd"
   ```
4. **Git Commit:**
   Commit using conventional commit syntax:
   ```text
   feat(camera): implement dual-mode camera rig with springarm toggling
   ```

---

## 4. RUNBOOK 4: TWO-STAGE INTERACTION & OCCLUSION AUDIT

### 4.1 Objective
Verify that interaction raycasts strictly obey physical architecture and cannot pierce solid walls (**DEF-B8-004**).

### 4.2 Step-by-Step Procedure
1. Place a target clue (`ClueArea3D`) on Layer 2 inside Room B.
2. Place the player character in adjacent Room A separated by a solid brick wall on Layer 1 (`World_Static`).
3. Orient camera directly at the clue position through the wall.
4. Execute `interaction_engine.get_valid_interaction_target()`.
5. **Pass Criteria:** Function must return `null`. The LoS raycast testing Layer 1 must intercept the wall and suppress the interaction prompt.

---

## 5. RUNBOOK 5: SUBVIEWPORT INSPECTION & RENDER SUPPRESSION AUDIT

### 5.1 Objective
Verify that entering 3D clue inspection suspends primary world rasterization, preserving G210 fill-rate and memory bus bandwidth (**DEF-B8-008**).

### 5.2 Step-by-Step Procedure
1. Launch test scene with animated environment geometry.
2. Trigger `item_examiner.open_inspection(clue_dispatch_order_14)`.
3. Query `get_tree().root.get_viewport().render_target_update_mode`.
   - **Pass Criteria:** Must equal `SubViewport.UPDATE_DISABLED` (Value 0).
4. Verify inspection SubViewport update mode equals `SubViewport.UPDATE_ALWAYS` (Value 3).
5. Trigger `item_examiner.close_inspection()`.
   - **Pass Criteria:** Root viewport update mode restores to `UPDATE_ALWAYS`.
   - **Pass Criteria:** `inspection_mode_exited` signal emits valid non-empty clue ID (`"PROP-HERO-01"`).

---
*End of Chapter 03 Operational Runbooks.*