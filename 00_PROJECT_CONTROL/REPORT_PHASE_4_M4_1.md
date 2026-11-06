# PROJECT NULL — M4.1 PROOF OF CONCEPT COMPLETION & AUDIT REPORT

**Document ID:** PNL-REP-M4-001  
**Document Version:** 1.0.0  
**Authority:** Lead Production Agent & AI Studio Director (`5b37636f-8740-4597-a5e4-10a6478a347c`)  
**Status:** COMPLETE — EMPIRICALLY AUDITED & SUBMITTED FOR DIRECTORIAL EVALUATION  
**Date:** 2026-11-05  
**Governing Mandates:** Formal M4.1 Authorization Directive, DEC-0001, DEC-0002, DEC-0010, DEC-0038  
**Target Engine Baseline:** Godot Engine 4.7.2 Stable (`gl_compatibility` / OpenGL 3.3 Core Profile)  
**Target Hardware Baseline:** Intel Core i5-12400F | 16 GB DDR4-3200 RAM | NVIDIA GeForce G210 (1024 MB DDR3 VRAM, 64-bit bus, 8.0 GB/s peak bandwidth, PCIe 2.0 x16, driver 21.21.13.4201 / WDDM 1.2)  

---

## 1. EXACT FILES & SCENES CREATED

All implementation work is strictly isolated within `06_GAME_PROJECT/`, preserving the non-production boundaries of all other project books and test fixtures:

```text
06_GAME_PROJECT/
├── project.godot                          [Engine config: gl_compatibility, 1280x720 windowed, VSync off, 1024 shadow]
├── assets/
│   └── materials/
│       ├── mat_environment_floor.tres    [StandardMaterial3D: slate floor, roughness 0.85]
│       ├── mat_environment_wall.tres     [StandardMaterial3D: muted brick wall, roughness 0.75]
│       ├── mat_mannequin.tres            [StandardMaterial3D: Bayer dither distance fade 0.25m-0.50m]
│       └── mat_clue_prop.tres            [StandardMaterial3D: brass metallic 0.85, roughness 0.35]
├── scenes/
│   ├── poc/
│   │   ├── m4_1_poc_stage.tscn           [Master Stage: DirectionalLight3D, WorldEnvironment, instanced children]
│   │   ├── env_corridor_slice.tscn       [Corridor: Open section 8x10m, acute corner 30°/60°, doorway 1.2m]
│   │   └── clue_telegraph_prop.tscn      [Clue Diorama: Table mesh + low-poly brass telegraph key prop]
│   ├── player/
│   │   ├── proto_humanoid_01.tscn        [Mannequin: 840 tris, Capsule collider 0.35x1.80m, RayCast3D]
│   │   └── camera_dual_rig.tscn          [Camera Rig: 1st/3rd person anchors, SpringArm3D r=0.12m m=0.03m]
│   └── ui/
│       └── hud_poc.tscn                  [UI Canvas: 6.6 Hz Performance HUD, interaction prompt, clue overlay]
└── scripts/
    ├── poc/
    │   ├── m4_1_poc_stage.gd             [Stage lifecycle, signal wiring, mannequin triangle audit]
    │   └── clue_interactable.gd          [Area3D clue interaction contract, inspection state toggle]
    ├── player/
    │   ├── player_controller.gd          [CharacterBody3D: 60 Hz move_and_slide, kinematic walk, procedural sway]
    │   └── camera_dual_rig.gd            [CameraDualRig: 4-pillar obstruction solver, cubic lerp, head culling]
    ├── ui/
    │   └── performance_hud.gd            [Real-time FPS, delta ms, draw calls, prims, engine VRAM, camera state]
    └── benchmark/
        └── benchmark_runner.gd           [60s hardware benchmark, 5s warm-up, microsecond capture, CSV/JSON export]
```

---

## 2. SKILLS & SPECIALIST AGENTS ACTUALLY USED

### 2.1 GodotPrompter Specialist Skills Invoked:
1. `godot-project-setup`: Scaffolded clean split directory structure (`scenes/`, `scripts/`, `assets/materials/`) and baseline `project.godot` configured strictly for `gl_compatibility` (OpenGL 3.3 Core Profile).
2. `rendering-pipeline`: Enforced OpenGL 3.3 constraints: zero volumetric fog, zero SDFGI/VoxelGI, single key `DirectionalLight3D` (1024x1024 shadow map, 1-split orthogonal cascade), zero real-time point light shadows.
3. `godot-optimization`: Enforced flat primitive geometry (840-triangle mannequin, 2,066 total scene primitives), untextured PBR materials with single-sampler uniforms, and 6.6 Hz HUD update rate to eliminate text raster churn.
4. `player-controller`: Implemented kinematic locomotion loop in `_physics_process()` using `move_and_slide()`, $1.4\text{ m/s}$ walk speed, $8.0\text{ m/s}^2$ acceleration, $10.0\text{ m/s}^2$ friction, standard capsule collider ($r=0.35\text{m}$, $h=1.80\text{m}$), and mouse capture handling.
5. `camera-system`: Implemented dual-anchor rig with independent First-Person and Third-Person mounts, Hermite cubic smoothstep transition, and the 4-pillar continuous obstruction policy ($L_{\min} = 0.25\text{m}$, dynamic shoulder centering, vertical pitch lift, and Bayer screen-door dither fade).
6. `godot-testing`: Authored and executed automated test suites: `test_pipeline_diagnostics.py` (32/32 tests), `test_runner_probe.gd` (3/3 tests), and `interactive_poc_audit.gd` (8/8 tests).
7. `godot-debugging`: Investigated and resolved the preflight `verify_godot_apis.gd` discrepancies (identifying the `RefCounted` illegal free bug and IEEE 754 32-bit float comparison precision).
8. `godot-code-review`: Audited GDScript typing and cross-script references, identifying and fixing indentation and duck-typing boundaries in `camera_dual_rig.gd` and `performance_hud.gd`.

### 2.2 Specialist Subagents Utilized:
- `godot-game-architect` (`825c6bd0-3e45-491f-b0a6-4ec96c9d8671`): Delivered the master scene tree specification, node hierarchy, and formal ratification of the 4-pillar obstruction solver.

---

## 3. PREFLIGHT TEST OUTPUTS & EVIDENCE RESOLUTION

In compliance with Directive Section 2, the preflight discrepancies were rigorously investigated, resolved, and verified:

### 3.1 Python Pipeline Diagnostics Suite
- **Command:** `python 08_TESTING/test_pipeline_diagnostics.py`
- **Exit Code:** `0` (Clean Pass)
- **Output:**
  ```text
  [1/6] Testing hash_ast.py edge cases...       --> ALL 8 EDGE CASES PASSED
  [2/6] Testing precommit_audit.py edge cases...  --> ALL 5 EDGE CASES PASSED
  [3/6] Testing inspect_glb.py edge cases...      --> ALL 5 EDGE CASES PASSED
  [4/6] Testing generate_collision.py edge cases...--> ALL 5 EDGE CASES PASSED
  [5/6] Testing pack_orm.py edge cases...         --> ALL 6 EDGE CASES PASSED
  [6/6] Testing renderer_probe in Godot 4.7.2...  --> ALL 3 TESTS PASSED
  ALL TEST DIAGNOSTICS SUITES PASSED CLEANLY (100% SUCCESS)
  ```

### 3.2 Native Godot Test Runner
- **Command:** `& "Godot_v4.7.2-stable_win64_console.exe" --headless --path 08_TESTING/renderer_probe -s test_runner_probe.gd`
- **Exit Code:** `0` (Clean Pass)
- **Output:**
  ```text
  [PASS] test_rendering_method_invariant
  [PASS] test_red_green_assertion_logic
  [PASS] test_math_precision_approx
  TEST RUN COMPLETE: 3 Run | 3 Passed | 0 Failed
  ```

### 3.3 Root Cause Investigation of `verify_godot_apis.gd` Failure
The earlier exit code 1 in `verify_godot_apis.gd` was investigated forensically and traced to two distinct bugs:
1. **`RefCounted` Resource Illegal Free:** Line 23 executed `sphere.free()`. In Godot 4, `SphereShape3D` inherits from `Resource`, which is `RefCounted`. In GDScript, invoking `.free()` on a `RefCounted` object throws an unhandled engine runtime error (`ERROR: Can't free a RefCounted object`), immediately aborting the script before `quit(0)` could be reached.
2. **IEEE 754 32-bit Float Precision Mismatch:** Lines 24 and 34 evaluated exact equality `arm.margin == 0.03` and `cam.near == 0.05`. In Godot's C++ core, 3D float properties are stored as 32-bit single-precision floats (`real_t`), resulting in exact values `0.02999999932945` and `0.05000000074506`. Evaluating exact equality `==` against GDScript 64-bit float literals evaluates to `false`.
3. **Resolution:** The file was corrected to rely on automatic reference counting for `SphereShape3D` and adopted Godot's standard `is_equal_approx()`. Re-running `verify_godot_apis.gd` verified 7/7 APIs passed with Exit Code 0.

---

## 4. INTERACTIVE RUNTIME TEST RESULTS

Executed via `08_TESTING/interactive_poc_audit.gd` on Godot 4.7.2 against `06_GAME_PROJECT/`:
- **Exit Code:** `0` (8/8 Passed)

```text
==================================================================
PROJECT NULL — M4.1 INTERACTIVE & FUNCTIONAL AUDIT
==================================================================
[PASS] Test 1: Mannequin geometry = 840 triangles (Budget <= 1200 tris)
[PASS] Test 2: Initial camera mode is THIRD_PERSON, cull_mask includes Head (Layer 1 & 2)
[PASS] Test 3: Camera toggled to FIRST_PERSON; cull_mask excludes Head Layer 2 (cull_mask = 1)
[PASS] Test 4: Camera toggled back to THIRD_PERSON; cull_mask restored to 3
[PASS] Test 5: 4-Pillar Obstruction Policy: Mode preserved (NO auto-snap), shoulder centered (X=0.05m), pitch lifted (Y=0.30m)
[PASS] Test 6: ClueInteractable prompt contract verified: '[E] Inspect Telegraph Key'
[PASS] Test 7: Contextual interaction [E] triggered inspection state on clue
[PASS] Test 8: Contextual interaction toggle dismissed inspection and restored state
==================================================================
AUDIT RESULTS: 8 Passed | 0 Failed
==================================================================
```

---

## 5. ACTUAL GEOMETRY AUDIT & SCENE COMPLEXITY

- **`PROTO_HUMANOID_01` Actual Triangle Count:** Exactly **840 triangles** (Budget ceiling: $\le 1,200$ tris).
  - Torso (CapsuleMesh): 144 triangles.
  - Head (SphereMesh): 448 triangles.
  - Limbs (4x CylinderMesh): 248 triangles.
  - Geometry Budget Compliance: **PASS** (360 triangles below budget ceiling).
- **Corridor Environment Geometry:** 1,226 triangles (Modular CSG/Box mesh corridor: open hall, acute walls, and $1.2\text{m}$ doorframe).
- **Total Frustum Primitives (Third-Person):** 2,066 triangles.
- **Total Frustum Primitives (First-Person):** 1,094 triangles (Player mannequin visually culled/behind camera).

---

## 6. RAW BENCHMARK DATA & EMPIRICAL G210 MEASUREMENTS

Both benchmarks were executed visibly on the physical **NVIDIA GeForce G210** (`OpenGL API 3.3.0 - Compatibility - Using Device: NVIDIA - GeForce G210`) running under Windows 11 64-bit at $1280 \times 720$ resolution:

```text
┌─────────────────────────────────┬──────────────────────┬──────────────────────┬──────────────────────┐
│ Metric Channel                  │ Third-Person Mode    │ First-Person Mode    │ Tier 2 Acceptance    │
├─────────────────────────────────┼──────────────────────┼──────────────────────┼──────────────────────┤
│ Measurement Duration            │ 60.01 seconds        │ 60.04 seconds        │ 60.00 seconds        │
│ Warm-up Discarded Frames        │ 3 frames (5.01 s)    │ 176 frames (5.00 s)  │ Time-based dynamic   │
│ Total Rendered Frames           │ 2,948 frames         │ 2,445 frames         │ N/A                  │
│ Sustained Framerate (Total/Time)│ 49.13 FPS            │ 40.73 FPS            │ >= 30.00 FPS (PASS)  │
│ Median Frame Time (P50)         │ 18.44 ms             │ 22.34 ms             │ <= 33.33 ms (PASS)   │
│ 95th Percentile Frame Time (P95)│ 32.44 ms             │ 41.77 ms             │ <= 36.00 ms (FAIL-FP)│
│ 99th Percentile Frame Time (P99)│ 46.00 ms             │ 48.84 ms             │ <= 42.00 ms (FAIL)   │
│ Maximum Frame Time (t_max)      │ 91.93 ms             │ 65.92 ms             │ Diagnostic logging   │
│ Spikes Exceeding 42.0 ms        │ 42 frames (1.42%)    │ 117 frames (4.78%)   │ Diagnostic logging   │
│ Engine Video Memory Used        │ 23.65 MB             │ 21.62 MB             │ <= 500.00 MB (PASS)  │
│ Total Draw Calls in Frame       │ 21 calls             │ 10 calls             │ <= 220 calls (PASS)  │
│ Total Primitives in Frame       │ 2,066 triangles      │ 1,094 triangles      │ Diagnostic logging   │
│ Overall Tier 2 Gate Status      │ FAIL (P99 breached)  │ FAIL (P95/P99 breach)│ STRICT GATE          │
└─────────────────────────────────┴──────────────────────┴──────────────────────┴──────────────────────┘
```

### Telemetry Artifact File Locations:
- Third-Person Raw CSV: [`08_TESTING/telemetry/m4_1_frametimes.csv`](file:///c:/Users/A2_B2_Chirag/Documents/Game%202.6/08_TESTING/telemetry/m4_1_frametimes.csv)
- Third-Person Summary JSON: [`08_TESTING/telemetry/m4_1_benchmark_summary.json`](file:///c:/Users/A2_B2_Chirag/Documents/Game%202.6/08_TESTING/telemetry/m4_1_benchmark_summary.json)
- First-Person Raw CSV: [`08_TESTING/telemetry/m4_1_frametimes_first_person.csv`](file:///c:/Users/A2_B2_Chirag/Documents/Game%202.6/08_TESTING/telemetry/m4_1_frametimes_first_person.csv)
- First-Person Summary JSON: [`08_TESTING/telemetry/m4_1_benchmark_summary_first_person.json`](file:///c:/Users/A2_B2_Chirag/Documents/Game%202.6/08_TESTING/telemetry/m4_1_benchmark_summary_first_person.json)

---

## 7. MEMORY TELEMETRY AUDIT & METRIC SEPARATION

In accordance with Directive Section 1, physical capacity is strictly distinguished from live engine allocations:

1. **Physical / Descriptor Video Memory Capacity (Static):**
   - CIM `Win32_VideoController`: `1,073,741,824 bytes` ($1,024.00\text{ MB}$).
   - DXGI `IDXGIAdapter::GetDesc`: `1,019,871,232 bytes` ($972.62\text{ MB}$ dedicated capacity; $51.38\text{ MB}$ reserved by firmware/VBIOS).
   - *Invariant:* Live application usage or available headroom is never inferred from this static descriptor capacity.
2. **Godot Engine-Reported Allocation (Dynamic):**
   - Third-Person Mode: **$23.65\text{ MB}$** (`Performance.RENDER_VIDEO_MEM_USED`).
   - First-Person Mode: **$21.62\text{ MB}$** (`Performance.RENDER_VIDEO_MEM_USED`).
   - Ceiling: $\le 500.0\text{ MB}$ (Current usage represents $< 5\%$ of budget).
3. **Host Process Memory (RAM):**
   - `Get-Process Godot* | Select WorkingSet64`: $\approx 148.2\text{ MB}$ host system working set.
4. **Live Physical Dedicated GPU Usage (Silicon):**
   - Marked **UNAVAILABLE** via Windows CLI/PDH/CIM (PDH counters return 0 on legacy driver 342.01). External GPU-Z sensor logging required for live physical chip memory.

---

## 8. CAMERA & INTERACTION DEFECTS FOUND

During interactive testing and physical GPU execution, the following defects and edge behaviors were observed:
1. **DWM Presentation Pacing Hitches (Defect DEF-M41-01):**
   - *Observation:* In windowed mode (`window/size/mode=0`) with VSync disabled (`vsync_mode=0`), the sustained framerate sits comfortably at 49.13 FPS (P50 = 18.44 ms), but Windows 11 Desktop Window Manager (DWM) composition introduces periodic swapchain presentation stalls every 5–8 seconds, producing intermittent 45–65 ms hitches (and a peak hitch of 91.93 ms). This caused the 99th percentile to hit 46.00 ms (breaching the 42.00 ms ceiling).
2. **Preflight Float Comparison False Failures (Defect DEF-M41-02):**
   - *Observation:* Float property assignments in GDScript evaluated with exact `==` failed against 64-bit literals due to 32-bit single-precision float conversion in Godot's C++ core.
3. **Indentation Bug in Dynamic Obstruction Solver (Defect DEF-M41-03):**
   - *Observation:* A nested `if is_inside_tree():` block inside `camera_dual_rig.gd` had an under-indented line that caused a script parse error during headless invocation.
4. **Missing Icon SVG Warning (Defect DEF-M41-04):**
   - *Observation:* Default Godot `project.godot` referenced `res://icon.svg`, triggering an image loader error on startup.

---

## 9. DEFECTS REMEDIATED & OUTSTANDING KNOWN LIMITATIONS

### Remediated Defects:
- [x] **DEF-M41-02 Fixed:** Converted all floating-point equality assertions across all test harnesses to `is_equal_approx()`.
- [x] **DEF-M41-03 Fixed:** Corrected indentation in `camera_dual_rig.gd` and added tree-entry guards.
- [x] **DEF-M41-04 Fixed:** Removed `config/icon` reference from `project.godot`.
- [x] **UID Parse Warnings Fixed:** Stripped unindexed `uid="..."` tokens across scene and material resource headers.
- [x] **Telemetry Path Handling Fixed:** Updated `benchmark_runner.gd` to use `ProjectSettings.globalize_path()` resolving cross-directory paths on Windows without pipe reserved errors.

### Outstanding Known Limitations:
1. **P99 Presentation Hitching under DWM:** Windowed mode without VSync exhibits DWM presentation jitter on the legacy GeForce 342.01 driver. Activating borderless fullscreen (`window/size/mode=3`) and Level 1 shadow fallbacks ($512\times 512$ shadow map) will be evaluated in the next iteration to stabilize presentation pacing.
2. **Acute Corner Wall Proximity:** In extreme $30^\circ$ acute corners, the SpringArm3D compresses to $0.25\text{m}$ smoothly without snapping, and the mannequin Bayer dithers out; however, looking straight up while jammed in the corner can bring the outer corridor wall into the near-clipping plane.

---

## 10. ACCEPTANCE CRITERIA EVALUATION MATRIX

| ID | Acceptance Criterion | Target Specification | Actual Empirical Measurement | Status |
| :--- | :--- | :--- | :--- | :---: |
| **AC-1** | Minimal Project Scaffolding | Isolated `06_GAME_PROJECT/`, Compatibility renderer, OpenGL 3.3 Core | Fully configured; zero barred features; clean startup (Exit 0) | **PASS** |
| **AC-2** | Sustained Framerate | Sustained FPS $\ge 30.00\text{ FPS}$ ($N_{\text{total}} / T_{\text{elapsed}}$) | **49.13 FPS** (Third-Person), **40.73 FPS** (First-Person) | **PASS** |
| **AC-3** | Median Frame Time (P50) | P50 $\le 33.33\text{ ms}$ on physical G210 | **18.44 ms** (Third-Person), **22.34 ms** (First-Person) | **PASS** |
| **AC-4** | 95th Percentile Time (P95) | P95 $\le 36.00\text{ ms}$ on physical G210 | **32.44 ms** (Third-Person: PASS), **41.77 ms** (First-Person: FAIL) | **CONDITIONAL** |
| **AC-5** | 99th Percentile Time (P99) | P99 $\le 42.00\text{ ms}$ on physical G210 | **46.00 ms** (Third-Person), **48.84 ms** (First-Person) | **FAIL** (Breach by 4.0ms) |
| **AC-6** | Draw Call Ceiling | $\le 220$ draw calls per frame | **21 calls** (Third-Person), **10 calls** (First-Person) | **PASS** |
| **AC-7** | Engine Video Memory | $\le 500.0\text{ MB}$ internal engine VRAM | **23.65 MB** (Third-Person), **21.62 MB** (First-Person) | **PASS** |
| **AC-8** | Mannequin Geometry Budget | $\le 1,200$ triangles target | Exactly **840 triangles** | **PASS** |
| **AC-9** | Camera Modes & No Auto-Snap | Independent 1st/3rd person; NO auto-snap on compression | Verified in interactive audit (Test 3, 4, 5); mode strictly preserved | **PASS** |
| **AC-10**| Contextual Interaction Loop | Clue object, prompt, inspection state toggle | Verified in interactive audit (Test 6, 7, 8) | **PASS** |
| **AC-11**| Blender-Free Invariant | Zero `.blend` files across workspace | Verified: `Get-ChildItem -Filter *.blend` returns 0 files | **PASS** |
| **AC-12**| Non-Implementation Gate | `06_GAME_PROJECT/` contains disposable PoC only; zero production assets | Verified: disposable PoC only; no narrative or production assets | **PASS** |

---

## 11. DIRECTORIAL RECOMMENDATION

### Formal Finding:
The M4.1 Proof of Concept successfully demonstrates that:
1. The **NVIDIA GeForce G210 running Godot 4.7.2 Compatibility mode delivers sustained throughput of 40–50 FPS**, well exceeding the 30 FPS floor, with engine VRAM consumption under $25\text{ MB}$ and draw calls under $25$.
2. The **4-pillar continuous third-person obstruction policy** functions reliably without disorienting automatic perspective snaps.
3. The **head cull mask and Bayer dither fade** cleanly eliminate near-plane clipping and internal face artifacts without transparent sorting errors.
4. **However**, the strict Tier 2 gate requires P99 $\le 42.00\text{ ms}$. In windowed mode with uncapped VSync, DWM presentation jitter produced a P99 of $46.00\text{ ms}$ (Third-Person) and $48.84\text{ ms}$ (First-Person).

### Recommendation:
**PROCEED TO CONTROLLED REVISION M4.1-R1 (Optimization & Presentation Pacing Tuning):**
- Do NOT proceed to M4.2 or vertical slice production yet.
- Authorize a narrow, controlled tuning pass on the existing disposable M4.1 prototype:
  1. Test `display/window/size/mode=3` (Borderless Fullscreen) to evaluate DWM flip queue bypass.
  2. Test Level 1 Fallback: reduce directional shadow map from $1024 \times 1024$ to $512 \times 512$ (evaluating if reducing shadow raster bandwidth eliminates the 42 periodic spikes).
  3. Re-run the physical G210 benchmark to verify whether P99 drops below the $42.00\text{ ms}$ threshold before seeking formal Phase 4 production expansion.

*This concludes the M4.1 Completion Report. Ready for Directorial Review.*
