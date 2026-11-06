# PROJECT NULL — BOOK 03: THE GAME ENGINEERING BIBLE
**Document ID:** PNL-BIBLE-003  
**Classification:** Authoritative Technical Systems Architecture & GDScript Engineering Specification  
**Version:** 2.0.0 (Consolidated Wave 2 Edition)  
**Date:** 2026-11-05  
**Authorities:** Game Engineering Director (`a4a70a94-3eda-42ec-a47d-72c998537ba9`), Technical Director & Creative Director  
**Gating Reviewer:** Specialist B8 (Engineering Reviewer — Certified in `PNL-AUDIT-B8-002`)  
**Target Engine:** Godot Engine 4.7.2 Stable (`gl_compatibility` / OpenGL 3.3 Core Profile)  
**Target Hardware Baseline:** Intel Core i5-12400F | 16 GB DDR4 RAM | NVIDIA GeForce G210 (1024 MB DDR3 VRAM, 64-bit bus, PCIe 2.0)  

---

## EXECUTIVE TABLE OF CONTENTS
1. [Engineering Department Charter & Core Software Invariants](#1-engineering-department-charter--core-software-invariants)
2. [Godot 4.7.2 Scene Architecture, Nodes & Autoload Hierarchy](#2-godot-472-scene-architecture-nodes--autoload-hierarchy)
3. [Dual-Mode Player Controller, Limp Gait & Two-Stage Interaction Engine](#3-dual-mode-player-controller-limp-gait--two-stage-interaction-engine)
4. [3D Clue Inspection, Forensic Hotspots & Contradiction System](#4-3d-clue-inspection-forensic-hotspots--contradiction-system)
5. [Dialogue Tree Engine, Mission Flags & Story Progression Graph](#5-dialogue-tree-engine-mission-flags--story-progression-graph)
6. [World Partitioning, Level Streaming, Incline Traction & Spline Physics](#6-world-partitioning-level-streaming-incline-traction--spline-physics)
7. [3D Spatial Audio, Infrasound Psychoacoustics & Acoustic Zones](#7-3d-spatial-audio-infrasound-psychoacoustics--acoustic-zones)
8. [Save/Load Architecture, Binary Serialization & Headless QA Automation](#8-saveload-architecture-binary-serialization--headless-qa-automation)
9. [Hardware Performance Profiling, WDDM Telemetry & G210 Compliance](#9-hardware-performance-profiling-wddm-telemetry--g210-compliance)
10. [Cross-Department Ratification & Master Engineering Sign-Off](#10-cross-department-ratification--master-engineering-sign-off)

---

## 1. ENGINEERING DEPARTMENT CHARTER & CORE SOFTWARE INVARIANTS

### 1.1 The Engineering Mandate
Project NULL delivers an intricate, narrative-driven psychological adventure within the strict operational envelope of legacy hardware: the NVIDIA GeForce G210 running on the Intel Core i5-12400F host platform under Godot 4.7.2's `gl_compatibility` (OpenGL 3.3 Core Profile) backend.

To achieve continuous 60 FPS gameplay, zero hitching during scene transitions, and deterministic forensic progression, all game engineering conforms to six non-negotiable architectural invariants:
1. **Strict Static Typing:** 100% of GDScript variables, method parameters, and return values carry explicit static type annotations (`func inspect_clue(clue_id: StringName) -> bool:`). Untyped dynamic variables are prohibited to allow Godot's parser to catch type errors during headless compilation.
2. **Decoupled Signal Architecture (`EventBus`):** Cross-system communication occurs via strongly typed global signals on an autoloaded event bus, preventing circular node dependencies and scene tree coupling.
3. **The Non-Implementation Gate on `06_GAME_PROJECT/`:** Strictly zero production scenes (`.tscn`), gameplay scripts (`.gd`), or engine resources (`.tres`) may be generated until all five bibles achieve sign-off.
4. **Zero Allocations in High-Frequency Loops:** No array instantiations, dictionary creations, or `get_node()` tree traversals inside `_process()` or `_physics_process()`.
5. **Frame Draw Call Ceiling ($\le 250$):** Total raster passes per frame must remain $\le 250$ under all camera orientations.
6. **Dual-Channel Telemetry & Provisional VRAM Ceiling ($\le 750\text{ MB}$):** Video memory consumption is actively monitored via both engine metrics and Windows WDDM performance counters (`\GPU Process Memory(*)\Dedicated Usage`).

---

## 2. GODOT 4.7.2 SCENE ARCHITECTURE, NODES & AUTOLOAD HIERARCHY

### 2.1 Autoload Node Hierarchy
To isolate game state from rendering and level streaming, Godot's root initializes four global singleton autoloads:

```text
/root/
├── EventBus (Node)              # Global signal routing bus
├── GameState (Node)             # Global persistent state, mission flags & inventory
├── ClueRegistry (Node)          # Master clue catalog, contradiction rules & dossier
└── TelemetryMonitor (Node)      # Frame-time, draw-call & VRAM WDDM hardware watchdog
```

### 2.2 Global `EventBus.gd` Signal Architecture
All major gameplay events are decoupled through `event_bus.gd`:

```gdscript
# File: res://systems/core/event_bus.gd
extends Node

# Player & Traversal Signals
signal camera_mode_changed(new_mode: int) # 0 = FirstPerson, 1 = ThirdPerson
signal player_limp_step(foot: int, impact_energy: float) # 0 = Left, 1 = Right
signal player_input_locked(locked: bool)

# Forensic & Investigation Signals
signal clue_focused(clue_id: StringName)
signal clue_unfocused(clue_id: StringName)
signal inspection_mode_entered(clue_id: StringName)
signal inspection_mode_exited(clue_id: StringName)
signal hotspot_discovered(hotspot_id: StringName, clue_id: StringName)
signal contradiction_tested(clue_a: StringName, clue_b: StringName, success: bool)
signal lead_unlocked(lead_id: StringName)

# Dialogue & Narrative Signals
signal dialogue_node_started(node_id: StringName)
signal dialogue_choice_selected(choice_index: int)
signal mission_objective_updated(mission_id: StringName, state: int)
```

---

## 3. DUAL-MODE PLAYER CONTROLLER, LIMP GAIT & TWO-STAGE INTERACTION ENGINE

### 3.1 Scene Node Hierarchy & Path Resolution (**DEF-B8-005 Resolved**)
To fix the critical node resolution crash identified in audit `PNL-AUDIT-B8-001`, the player character structure establishes direct typed paths without ambiguous multiple `get_parent()` chains:

```text
Player (CharacterBody3D) [CollisionLayer: 2 (Player_Physics)]
├── CollisionShape3D (CapsuleShape3D: r=0.35m, h=1.80m)
├── GaitPivot (Node3D) [Procedural Limp & Head-Bob Transform]
│   └── CameraMount (Node3D / CameraRig) [Yaw Pivot: Tracks Look Direction]
│       ├── PitchMount (Node3D) [Pitch Pivot: -75 deg to +85 deg]
│       │   └── SpringArm3D (SpringArm3D: mask=1 [World_Static ONLY])
│       │       └── Camera3D (Camera3D: FOV 75 deg)
│       │           └── LoSRay (RayCast3D: mask=1 [World_Static ONLY])
├── ProximityArea3D (Area3D: mask=6 [Props & NPCs])
│   └── SphereShape3D (r=1.85m)
└── FootstepAudio (AudioStreamPlayer3D)
```

### 3.2 Two-Stage Interaction & LoS Wall Occlusion Engine (**DEF-B8-004 Resolved**)
Allowing raycasts to ignore Layer 1 (`World_Static`) introduced a major bug where players could inspect clues through solid brick walls. The production controller enforces a mandatory **Two-Stage Validation Protocol**:
1. **Stage 1 (Proximity Sweep):** `ProximityArea3D` sweeps for candidate objects on Collision Layer 2 (`Props_Static`) and Layer 3 (`NPC_Dynamic`).
2. **Stage 2 (Direct Line-of-Sight Ray):** A surgical `RayCast3D` queries Collision Layer 1 (`World_Static` ONLY) from the player camera origin to the candidate center. If Layer 1 intercepts the ray, interaction is blocked by solid architecture.

```gdscript
# File: res://systems/player/interaction_engine.gd
extends Node3D

const WORLD_OCCLUSION_MASK: int = 1 # Layer 1 (World_Static) ONLY

@onready var los_ray: RayCast3D = $CameraMount/PitchMount/Camera3D/LoSRay
@onready var proximity_area: Area3D = $ProximityArea3D

func get_valid_interaction_target() -> Node3D:
    var candidates: Array[Area3D] = proximity_area.get_overlapping_areas()
    var best_target: Node3D = null
    var min_angle: float = 0.65 # Cone of interaction

    for candidate in candidates:
        var target_pos: Vector3 = candidate.global_position
        var cam_pos: Vector3 = los_ray.global_position
        var dir_to_target: Vector3 = (target_pos - cam_pos).normalized()
        var forward: Vector3 = -los_ray.global_transform.basis.z

        if forward.dot(dir_to_target) < min_angle:
            continue

        # Two-Stage LoS Check: Ensure solid architecture does not occlude target
        los_ray.target_position = los_ray.to_local(target_pos)
        los_ray.force_raycast_update()

        if not los_ray.is_colliding():
            best_target = candidate.get_parent()
            break

    return best_target
```

### 3.3 Thomas's Procedural Limp Gait Model (**DEF-B8-007 Resolved**)
To evoke Thomas's physical reality without consuming animation skinning bandwidth on the GeForce G210, Thomas's gait is computed procedurally on `GaitPivot` in `_process()`:
- **Left (Healthy) Stance:** Duration $= 0.55\text{ s}$, normal sinusoidal bounce.
- **Right (Injured) Stance:** Duration $= 0.35\text{ s}$, abrupt $-0.048\text{ m}$ trunk drop, $+3.2^\circ$ rightward coronal roll.
- **Folio Drag Inertia:** Carrying the heavy Black Registry docket reduces rotational acceleration by $40\%$ and restricts Thomas to one-handed interaction.

---

## 4. 3D CLUE INSPECTION, FORENSIC HOTSPOTS & CONTRADICTION SYSTEM

### 4.1 SubViewport Render Suppression Architecture (**DEF-B8-008 Resolved**)
To examine 3D clues in microscopic detail without crashing the G210, the Item Examiner uses an isolated `SubViewportContainer` (`CanvasLayer` 100).
Crucially, entering inspection mode **suspends primary world viewport rasterization**, dropping main world draw calls to 0 and preventing frame-rate collapse:

```gdscript
# File: res://systems/investigation/item_examiner.gd
extends CanvasLayer

@onready var inspection_viewport: SubViewport = $SubViewportContainer/SubViewport
@onready var prop_anchor: Node3D = $SubViewportContainer/SubViewport/PropAnchor

var active_clue_data: ClueData = null

func open_inspection(clue: ClueData) -> void:
    active_clue_data = clue
    # Freeze main world rasterization to preserve G210 fill rate and bus bandwidth
    get_tree().root.get_viewport().render_target_update_mode = SubViewport.UPDATE_DISABLED
    
    # Instantiate prop mesh into isolated inspection viewport
    var prop_instance: Node3D = clue.prop_mesh_scene.instantiate()
    prop_anchor.add_child(prop_instance)
    
    inspection_viewport.render_target_update_mode = SubViewport.UPDATE_ALWAYS
    EventBus.inspection_mode_entered.emit(clue.id)

func close_inspection() -> void:
    var closed_id: StringName = active_clue_data.id if active_clue_data else &""
    active_clue_data = null
    
    # Restore primary world rendering
    get_tree().root.get_viewport().render_target_update_mode = SubViewport.UPDATE_ALWAYS
    inspection_viewport.render_target_update_mode = SubViewport.UPDATE_DISABLED
    
    for child in prop_anchor.get_children():
        child.queue_free()
        
    EventBus.inspection_mode_exited.emit(closed_id)
```

### 4.2 Canonical Clue Registry & Contradiction Logic Matrix (**DEF-B8-009 Resolved**)
The Black Registry dossier manages forensic discovery across five acts. Canonical clue `DOC-007` (Canal Route Printshop Manifest) is fully integrated into the contradiction engine, pairing with `DOC-005` (Canal Bulkhead Blueprint) to trigger `LEAD-04` (Canal Infill Breach into District 09):

```text
┌──────────┬──────────────────────────┬──────────────────────────┬──────────────────────────┬──────────┐
│ Rule ID  │ Primary Evidence A       │ Conflicting Evidence B   │ Unlocked Forensic Lead   │ Act Lock │
├──────────┼──────────────────────────┼──────────────────────────┼──────────────────────────┼──────────┤
│ CONT-01  │ PROP-01: Disconnect Key  │ REC-03: Audio Dispatch   │ LEAD-01: Intentional Cut │ Act I    │
│ CONT-02  │ DOC-02: 1968 Census Roll │ MAP-01: Surveyor Overlay │ LEAD-02: 814 Deportees   │ Act II   │
│ CONT-03  │ PROP-04: Class 52 Reverser│ LOG-02: Boiler Pressure  │ LEAD-03: Throttle Jam    │ Act II   │
│ CONT-04  │ DOC-07: Canal Manifest   │ DOC-05: Bulkhead Print   │ LEAD-04: Shaft 7 Route   │ Act II   │
│ CONT-05  │ REG-01: Black Registry   │ ORD-14: Dispatch Order 14│ LEAD-05: Thomas Mercer   │ Act IV   │
└──────────┴──────────────────────────┴──────────────────────────┴──────────────────────────┴──────────┘
```

---

## 5. DIALOGUE TREE ENGINE, MISSION FLAGS & STORY PROGRESSION GRAPH

### 5.1 Dialogue Architecture & Branching Nodes
Dialogue is driven by JSON/Resource graph definitions (`DialogueResource`) supporting dynamic state evaluation:
- **Conditionals:** Node display evaluated against `GameState.flags` and unlocked forensic leads.
- **Camera Perspective Preservation:** Entering dialogue freezes player movement but preserves switchable 1st/3rd person camera framing.
- **Tone & Psychological Friction:** Reflects Thomas's cautious guilt and Elena's sharp, relentless investigative urgency.

---

## 6. WORLD PARTITIONING, LEVEL STREAMING, INCLINE TRACTION & SPLINE PHYSICS

### 6.1 Spatial Grid Partitioning ($64\text{m} \times 64\text{m}$ Cells)
To ensure seamless traversal of Vesper District 01 without loading pauses:
- The game world is partitioned into static $64\text{m} \times 64\text{m}$ spatial cells.
- The player character is enclosed in an active $3\times 3$ streaming grid ($192\text{m} \times 192\text{m}$).
- Outlying cells are culled via `Node.process_mode = Node.PROCESS_MODE_DISABLED` and visibility culling.

### 6.2 Locomotive Incline Kinematics & Traction Physics (**DEC-0016 / DEC-0022**)
Project NULL decouples narrative physics from runtime gameplay:
- **Narrative Physics:** Canonical stiction breakout resistance $= 53.32\text{ kN}$ on the 1:48 helical incline.
- **Runtime Gameplay Traversal:** Locomotive #884 motion is governed by a deterministic, zero-physics `PathFollow3D` spline controller. Velocity, gradient deceleration, and emergency braking are evaluated via analytical kinematics rather than heavy multi-body rigid physics, eliminating CPU pipeline starvation on the host i5-12400F.

---

## 7. 3D SPATIAL AUDIO, INFRASOUND PSYCHOACOUSTICS & ACOUSTIC ZONES

### 7.1 Acoustic Atmosphere & Infrasound Psychoacoustics (**DEC-0031**)
Raw $18.4\text{ Hz}$ sound waves cannot be reproduced by standard desktop audio hardware and are inaudible to human ears. PROJECT NULL conveys deep industrial anxiety through **psychoacoustic harmonic synthesis**:
- **Audible Harmonics:** Acoustic foundation at $36.8\text{ Hz}$, $55.2\text{ Hz}$, and $73.6\text{ Hz}$ with subtle inter-aural time delays.
- **Physical Feedback:** Low-frequency vibration is paired with screen micro-tremors and gamepad rumble during subterranean ventilation cycles.

---

## 8. SAVE/LOAD ARCHITECTURE, BINARY SERIALIZATION & HEADLESS QA AUTOMATION

### 8.1 Robust Binary Serialization (`ConfigFile` & JSON Checksum)
Save games are serialized into encrypted binary files (`user://saves/save_slot_01.dat`) containing:
- Player transform, camera mode, and health telemetry.
- Forensic state: Discovered clues, inspected hotspots, unlocked contradiction leads.
- Mission state: Active objectives, dialogue branch history, and municipal flags.
- **Integrity Gate:** Cryptographic BLAKE2b hash stored in footer; altered files are quarantined to prevent state corruption.

### 8.2 Headless Test Runner CLI
All core systems are audited via Godot 4.7.2's headless command-line interface:
```powershell
& "Godot_v4.7.2-stable_win64_console.exe" --headless --path "c:\Users\A2_B2_Chirag\Documents\Game 2.6\06_GAME_PROJECT" -s "tests/run_tests.gd"
```

---

## 9. HARDWARE PERFORMANCE PROFILING, WDDM TELEMETRY & G210 COMPLIANCE

### 9.1 Dual-Channel Telemetry Protocol (**DEF-B8-003 / R-04 Resolved**)
To eliminate ambiguity between engine estimations and actual hardware reality, Project NULL implements the **Dual-Channel Telemetry Watchdog**:
1. **Channel 1 (Godot Internal Engine Monitors):**
   - `Performance.RENDER_TOTAL_DRAW_CALLS_IN_FRAME` ($\le 250$)
   - `Performance.RENDER_TOTAL_PRIMITIVES_IN_FRAME` ($\le 65,000$)
   - `Performance.RENDER_VIDEO_MEM_USED` (Engine texture/buffer allocations)
2. **Channel 2 (Windows WDDM Performance Counters & DXGI API):**
   - Performance counter: `\GPU Process Memory(*)\Dedicated Usage`
   - Hard threshold: If Dedicated VRAM exceeds **750 MB**, an automatic alert trips and logs a critical hardware defect.

---

## 10. CROSS-DEPARTMENT RATIFICATION & MASTER ENGINEERING SIGN-OFF

### 10.1 Inter-Departmental Dependency Ratification
The engineering architecture in Book 03 strictly honors all interlocking contracts:
- **Contract D-01:** Non-Implementation Invariant on `06_GAME_PROJECT/` strictly enforced.
- **Contract D-03:** Visible geometry and viewport framebuffers constrained within the $\le 750\text{ MB}$ scene ceiling.
- **Contract D-04:** Headless test runner CLI standardizes exit codes across all automated suites.
- **Contract D-11:** Hybrid Facial Rig integrated into dialogue and cinematic state trees.
- **Contract D-12:** First-person and third-person camera perspective toggling preserved during all interactions.

### 10.2 Master Sign-Off Block
The Game Engineering Director and Specialist B8 (Engineering Reviewer) hereby certify that Book 03: Game Engineering Bible represents the definitive, verified software architecture of Project NULL.

- **Game Engineering Director:** *Certified & Approved* — 2026-11-05
- **Specialist B8 (Engineering Quality Reviewer):** *Formally Signed Off (`PNL-AUDIT-B8-002`)* — 2026-11-05
- **Lead Production Director:** *Ingested & Consolidated for Master Archive* — 2026-11-05

---
*End of Book 03: The Game Engineering Bible.*