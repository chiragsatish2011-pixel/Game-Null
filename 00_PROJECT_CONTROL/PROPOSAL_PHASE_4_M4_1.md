# PROJECT NULL — CONTROLLED PHASE 4 IMPLEMENTATION PROPOSAL
## MILESTONE M4.1: RENDERING & INTERACTION PROOF OF CONCEPT (PoC)

**Document ID:** PNL-PROP-M4-001  
**Document Version:** 2.2.0  
**Authority:** Production Director & Lead Production Agent (`5b37636f-8740-4597-a5e4-10a6478a347c`)  
**Recipients:** Creative Director & Technical Director  
**Status:** PROPOSAL ONLY — PENDING DIRECTORIAL AUTHORIZATION  
**Non-Implementation Gate:** **STRICTLY ACTIVE** (Zero production code written; execution blocked until explicit greenlight).  
**Governing Mandates:** Final Evidence Accuracy Corrections Directive, DEC-0001, DEC-0031, DEC-0038  
**Target Hardware Baseline:** Intel Core i5-12400F | 16 GB DDR4-3200 | NVIDIA GeForce G210 (1024 MB DDR3, 64-bit bus, 8.0 GB/s, OpenGL 3.3)  
**Target Engine Baseline:** Godot Engine 4.7.2 Stable (`gl_compatibility` / OpenGL 3.3 Core Profile)  

---

## 1. PURPOSE & STRATEGIC RATIONALE

Before committing resources to full vertical slice construction across Vesper District 01 (Platform 2, Shunting Cut, Flat 4B), this proposal defines a strictly bounded, non-destructive initial implementation milestone:

$$\mathbf{Milestone\ M4.1:\ Rendering\ and\ Interaction\ Proof\ of\ Concept\ (PoC)}$$

### Primary Objectives:
1. **Validate Real G210 Hardware Silicon:** Transition from mathematical simulation budgets to verified physical measurements on the NVIDIA GeForce G210 under an active display window.
2. **Validate Environmental Rendering:** Render a minimal 20-meter modular street corridor using CSG blockouts and Pillow-packed ORM PBR materials under `gl_compatibility`.
3. **Validate Locomotion & Mannequin Kinematics:** Test one playable character mannequin (`PROTO_HUMANOID_01`) with a minimal articulated rig and basic locomotion under G210 vertex processing limits.
4. **Validate Forensic Interaction:** Test one interactive clue prop diorama (Area3D trigger, highlight visual affordance, inspection camera handoff).
5. **Validate Dual Camera Architecture:** Test seamless, collision-aware switching between third-person exploration and first-person forensic inspection modes.
6. **Establish an Empirical Baseline:** Produce actual frame-time percentiles (P50, P95, P99), draw call counts, and WDDM VRAM telemetry to serve as the definitive benchmark before Phase 4 expansion.

---

## 2. STRICTLY BOUNDED SCOPE

To prevent scope creep and maintain total execution safety, M4.1 is constrained to the minimum vertical slice necessary to validate core technical hypotheses:

```text
┌────────────────────────────────────────────────────────────────────────────────────────┐
│                                MILESTONE M4.1 SCOPE BOUNDARY                           │
├───────────────────────────────────────────────────────────┬────────────────────────────┤
│ IN SCOPE (Permitted for M4.1)                             │ OUT OF SCOPE (Barred)      │
├───────────────────────────────────────────────────────────┼────────────────────────────┤
│ • 1 Project initialization in `06_GAME_PROJECT/`          │ • Full District 01 level   │
│   (`project.godot` configured with `gl_compatibility`).   │   (Platform 2, Flat 4B).   │
│ • 1 Minimal 20m street corridor slice (Shunting Cut).     │ • Secondary NPCs or AI.    │
│ • 1 CharacterBody3D: `PROTO_HUMANOID_01` test mannequin   │ • Full dialogue tree UI    │
│   (procedural/primitive rig, walk/idle state machine).    │   or branching voice audio.│
│ • 1 Dual-Camera Rig: Independent 1st/3rd anchors with     │ • Save/load serialization. │
│   SpringArm3D sphere collision & smooth transform lerp.   │ • Full Black Registry graph│
│ • 1 Interactive Clue Prop: Telegraph key on table         │ • High-poly final meshes   │
│   (Area3D trigger on Layer 2, prompt, SubViewport view).  │   or 2K/4K texture maps.   │
│ • 1 Performance HUD overlay (FPS, draw calls, VRAM).      │ • Third-party MCP servers. │
└───────────────────────────────────────────────────────────┴────────────────────────────┘
```

---

## 3. CHARACTER PROTOTYPE SPECIFICATION (`PROTO_HUMANOID_01`)

### 3.1 Canon Adherence & Prototype Identity
- **Canonical Protagonist:** The established narrative protagonist of PROJECT NULL is **Thomas Arthur Mercer** (governed exclusively by locked Book 01 Story Bible).
- **PoC Mannequin Identity:** To maintain absolute separation between engineering prototypes and canonical lore, the character prototype is designated **`PROTO_HUMANOID_01`**. It is an anonymous engineering test mannequin and does NOT introduce or represent a narrative character.
- **Blender-Free Invariant:** Sourcing external `.blend` character assets or manual DCC modeling is strictly prohibited (DEC-0002).

### 3.2 Minimal Prototype Rig Architecture
A complex 48-bone skeletal mesh with facial blend shapes is not required or justified merely to validate locomotion, CharacterBody3D physics, and camera switching. M4.1 implements a lightweight procedural mannequin:
- **Geometry Design Budget:** Proposed procedural CSG / primitive geometric mannequin (capsule torso, sphere head, jointed cylinder limbs) target budget of $\le 1,200$ triangles; actual triangle count pending M4.1 implementation.
- **Kinematic Hierarchy:** Minimal 5-part articulated node hierarchy (Root -> Hips -> Torso -> Head, with Left/Right Arm and Leg pivots) driven by lightweight procedural transform oscillations (sinusoidal walk bobbing and limb swings) or a minimal 15-bone humanoid skeleton.
- **Physics Collider:** CapsuleShape3D (radius $0.35\text{m}$, height $1.80\text{m}$, collision layer 3 = Player, mask = 1 World).

---

## 4. INDEPENDENT DUAL-CAMERA ARCHITECTURE

The dual-camera system does NOT treat `SpringArm3D` as the entire camera solution. It implements an independent dual-anchor architecture managed by an active Camera Controller:

```text
┌────────────────────────────────────────────────────────────────────────────────────────┐
│                        DUAL-CAMERA SYSTEM ARCHITECTURE                                 │
│                                                                                        │
│   Player (CharacterBody3D)                                                             │
│   ├── FirstPersonAnchor (Node3D, Y=1.65m, Z=0.05m)                                     │
│   │   └── FirstPersonCamera3D (FOV=75°, Near=0.05m, CullMask excludes Layer 2)         │
│   │                                                                                    │
│   ├── ThirdPersonPivot (Node3D, Y=1.45m, Shoulder Offset X=0.35m)                      │
│   │   └── ThirdPersonSpringArm (SpringArm3D, Shape=Sphere 0.15m, Margin=0.15m, L=2.8m) │
│   │       └── ThirdPersonCamera3D (FOV=70°, Near=0.15m)                                │
│   │                                                                                    │
│   └── CameraController (State Machine: 1st ↔ 3rd ↔ Inspection)                         │
└────────────────────────────────────────────────────────────────────────────────────────┘
```

### 4.1 Independent Camera Anchors & Visibility Policy
1. **First-Person Anchor (`FirstPersonAnchor`):**
   - Positioned at eye level ($Y = 1.65\text{m}$, forward offset $Z = 0.05\text{m}$).
   - Rotates directly with mouse pitch (clamped $[-85^\circ, +85^\circ]$) and player body yaw.
   - Contains `FirstPersonCamera3D` (`fov = 75.0^\circ`, `near = 0.05\text{m}`).
   - **Body-Visibility Policy:** The head and upper neck geometry of `PROTO_HUMANOID_01` are assigned to Visual Layer 2 (`HeadMesh`). `FirstPersonCamera3D.cull_mask` excludes Layer 2, preventing the camera from clipping inside the character's own skull, while the chest, arms, and legs remain on Layer 1 so the character's body remains visible when looking down.
2. **Third-Person Spring Arm (`ThirdPersonSpringArm`):**
   - Mounted to a shoulder pivot at $Y = 1.45\text{m}$ with an over-the-shoulder offset ($X = 0.35\text{m}$).
   - `spring_length = 2.8\text{m}`.
   - **Collision Handling:**
     * `collision_mask = 1` (collides with World static geometry).
     * `margin = 0.15\text{m}` (prevents near-plane wall clipping).
     * `shape = SphereShape3D` with radius $0.15\text{m}$ (smooth sphere-casting prevents the camera arm from snagging on sharp geometric corners or doorframes).
   - Contains `ThirdPersonCamera3D` (`fov = 70.0^\circ`, `near = 0.15\text{m}`).

### 4.2 Camera Ownership & State Machine
The system is managed by `camera_controller.gd` governing discrete states:
- `FIRST_PERSON`: `FirstPersonCamera3D.current = true`. Mouse rotates body yaw and head pitch.
- `THIRD_PERSON`: `ThirdPersonCamera3D.current = true`. Mouse rotates spring arm orbit; movement rotates character mesh toward movement vector.
- `TRANSITIONING_TO_THIRD` / `TRANSITIONING_TO_FIRST`: When the toggle key (`V` or Middle Mouse) is pressed, a 250ms smooth transform lerp interpolates position and FOV between the two cameras before handing off `make_current()`. Input is preserved for player locomotion during the transition; camera toggle input is debounced.
- `INSPECTION`: Triggered when interacting with a clue prop. The camera smoothly blends to a fixed `InspectionAnchor` focused on the diorama. The previous camera mode (`FIRST_PERSON` or `THIRD_PERSON`) is stored in `_pre_inspection_mode`. Upon exiting inspection (`E` or `ESC`), the camera smoothly returns to the stored exploration mode.
- **Freely Switchable Invariant:** Camera switching is **NEVER** arbitrarily locked during exploration.

### 4.3 Defined Third-Person Obstruction Policy (Zero Silent Perspective Changes)
In strict compliance with directorial mandate and reviewed by `godot-game-architect`, automatic perspective switching is **completely barred**:
- **Preserve Selected Mode:** The player's active camera selection (`THIRD_PERSON`) is preserved unconditionally. The system never silently or automatically snaps the camera to first-person view during navigation, wall compression, or corner collisions.
- **Smooth Spring Arm Compression:** As geometry encroaches, the `ThirdPersonSpringArm` compresses smoothly along its vector toward a safe minimum clearance floor (`min_spring_length = 0.25m`).
- **Proposed Collision Probe Configuration:** The probe is configured with `SphereShape3D.radius = 0.12m` and `SpringArm3D.margin = 0.03m` as baseline setup values (0.15m nominal clearance along contact normals). Actual clearance, wall clipping, and near-plane behavior must be empirically verified in the interactive PoC across varying wall angles, acute corner orientations, and corridor geometries, as a calculated configuration does not guarantee protection in every arbitrary orientation. `collision_mask` strictly targets Layer 1 (World Static) and Layer 3 (Heavy Props), explicitly excluding Layer 2 (Player) to prevent self-collision.
- **Dynamic Shoulder-Offset Centering:** At full extension ($2.8\text{m}$ down to $0.80\text{m}$), the camera maintains an over-the-shoulder offset ($X = 0.35\text{m}$). As the spring arm compresses from $0.80\text{m}$ down to $0.25\text{m}$, the controller dynamically lerps the lateral shoulder offset:
  $$u_{\text{compress}} = \text{clamp}\left(\frac{0.80 - L}{0.80 - 0.25}, 0.0, 1.0\right)$$
  $$X_{\text{offset}}(L) = \text{lerp}(0.35\text{m}, 0.05\text{m}, u_{\text{compress}})$$
  Shifting the camera toward the character midline prevents the camera from penetrating adjacent side walls when backing into $90^\circ$ corners.
- **Controlled Camera Elevation (Pitch Lift):** When the arm compresses below $0.80\text{m}$, an upward vertical offset ($+0.15\text{m}$) and subtle downward pitch bias are smoothly applied, peeking over the mannequin's head to preserve forward sightlines. In low-ceiling environments (e.g. $1.2\text{m}$ ducts), elevation is clamped against upward raycast collision.
- **Proposed Character Dither Fade Strategy:** To avoid conventional transparent alpha blending (`BLEND_MODE_MIX`) and its associated depth-sorting anomalies on OpenGL 3.3, character mesh fading is proposed via screen-space Bayer matrix pixel dithering:
  `StandardMaterial3D.distance_fade_mode = StandardMaterial3D.DISTANCE_FADE_PIXEL_DITHER` (Enum value 2)  
  `StandardMaterial3D.distance_fade_min_distance = 0.25m`  
  `StandardMaterial3D.distance_fade_max_distance = 0.50m`  
  This configuration is applied exclusively to the character mannequin material (not environmental surfaces). While pixel dithering avoids transparent blend read-modify-write passes and sorting bugs, fragment shader execution and discard instructions still carry processing cost; this proposed strategy is subject to visual and performance validation on the target GPU during M4.1.
- **Optional Accessibility / Comfort Setting:** A dedicated accessibility toggle (`settings/comfort/auto_first_person_in_corners: bool = false`) is provided in user settings (disabled by default) for players who experience motion sickness in tight corners, ensuring comfort without altering default core architecture.

---

## 5. RECONCILED PERFORMANCE CRITERIA & MEASURABLE ACCEPTANCE

### 5.1 Reconciliation with Benchmark Floor & Rigorous Metric Formulation
In compliance with directorial directives, M4.1 performance acceptance criteria are reconciled with the established **30 FPS Tier 2 Benchmark Floor**:

```text
┌──────────────────────────────────────┬──────────────────────┬──────────────────────────────────────────┐
│ Performance Metric                   │ Acceptance Floor     │ Optimization Target (Tier 1)             │
├──────────────────────────────────────┼──────────────────────┼──────────────────────────────────────────┤
│ • Sustained Framerate (Total/Elapsed)│ >= 30.0 FPS          │ >= 60.0 FPS                              │
│ • Median Frame Time (P50)            │ <= 33.33 ms          │ <= 16.67 ms                              │
│ • 95th Percentile Frame Time (P95)   │ <= 36.00 ms          │ <= 18.00 ms                              │
│ • 99th Percentile Frame Time (P99)   │ <= 42.00 ms          │ <= 22.00 ms                              │
│ • Maximum Observed Frame Time (t_max)│ Recorded & Reported  │ <= 33.33 ms                              │
│ • Total WDDM Dedicated Video Memory  │ <= 750 MB (provis.)  │ <= 650 MB                                │
│ • Internal Engine Video Memory (VRAM)│ <= 500 MB (verified) │ <= 350 MB                                │
│ • Total Draw Calls                   │ <= 120 passes        │ <= 80 passes                             │
└──────────────────────────────────────┴──────────────────────┴──────────────────────────────────────────┘
```

> [!IMPORTANT]
> **Sustained FPS Methodology:**
> Sustained FPS is strictly calculated using:
> $$\text{Sustained FPS} = \frac{\text{Total Rendered Frames}}{\text{Total Measurement Elapsed Time (seconds)}}$$
> Calculating sustained FPS by taking the arithmetic mean of instantaneous FPS samples is **strictly prohibited**, as instantaneous sampling overweights hitch frames and yields statistically invalid throughput data.
>
> **Complete Frame-Time Report Schema:**
> Every benchmark and PoC telemetry report must output:
> 1. Median Frame Time (P50)
> 2. 95th Percentile Frame Time (P95)
> 3. 99th Percentile Frame Time (P99)
> 4. Maximum Observed Frame Time ($t_{\max}$)
> 5. Total Rendered Frames ($N_{\text{total}}$)
> 6. Actual Measurement Duration ($T_{\text{elapsed}}$ in seconds)
> 7. Sustained FPS ($N_{\text{total}} / T_{\text{elapsed}}$)

### 5.2 Camera-Transition Test Matrix Across Discrete Environments
Camera switching is tested across three independent test environments rather than a combined aggregate:

```text
┌────────────────────────────┬───────────────────────┬─────────────────────────────────────────────────┐
│ Test Environment           │ Spatial Configuration │ Evaluated Camera Dynamics                       │
├────────────────────────────┼───────────────────────┼─────────────────────────────────────────────────┤
│ 1. Open Street             │ Unconstrained frustum │ Baseline 250ms lerp, wide-area LOD transitions  │
│ 2. Building Corner / Wall  │ Wedged against corner │ SpringArm compressed to min length (0.25m),     │
│                            │                       │ shoulder-centering lerp, dither fade            │
│ 3. Narrow Corridor         │ 2.0m bilateral walls  │ Lateral clearance, wall contact avoidance       │
└────────────────────────────┴───────────────────────┴─────────────────────────────────────────────────┘
```

**Per-Environment Test Protocol:**
1. **Transition Cycle Count:** At least **20 complete first-person ↔ third-person round trips** (40 individual one-way transitions) executed per environment.
2. **Transition Duration:** Each transition target is $250\text{–}300\text{ ms}$.
3. **Pacing Thresholds:**
   - Report P95, P99, and maximum frame time ($t_{\max}$) during transitions for each environment independently.
   - P99 threshold remains $\le 42.00\text{ ms}$ (the 30 FPS floor).
   - Any isolated spikes above $42.00\text{ ms}$ must be explicitly logged and documented with timestamp, collision hit length, and frame index; **zero samples may be silently discarded**.
4. **Collision & Distance Telemetry:** Log camera distance, spring arm hit length (`get_hit_length()`), and active mode for every frame.
5. **Inspection Mode Handoff Verification:**
   - Test entering and leaving clue inspection mode separately:
     * Test A: `FIRST_PERSON` $\rightarrow$ `INSPECTION` $\rightarrow$ verify exit restores `FIRST_PERSON` in 100% of runs.
     * Test B: `THIRD_PERSON` $\rightarrow$ `INSPECTION` $\rightarrow$ verify exit restores `THIRD_PERSON` in 100% of runs.

---

## 6. NON-DESTRUCTIVE ROLLBACK & RECOVERY PROCEDURE

The previously proposed destructive cleanup (`Remove-Item -Recurse -Force`) is permanently removed and replaced with a multi-stage non-destructive recovery workflow:

```text
┌────────────────────────────────────────────────────────────────────────────────────────┐
│                        NON-DESTRUCTIVE ROLLBACK & RECOVERY WORKFLOW                    │
│                                                                                        │
│   [Hardware Failure / Performance Breach Triggered]                                    │
│                           │                                                            │
│                           ▼                                                            │
│   Step 1: Terminate active Godot process safely (`Stop-Process -Name Godot*`).         │
│                           │                                                            │
│                           ▼                                                            │
│   Step 2: Preserve logs, telemetry CSVs, and crash dumps to:                           │
│           `08_TESTING/telemetry_archive/m4_1_failure_<timestamp>/`                     │
│                           │                                                            │
│                           ▼                                                            │
│   Step 3: Move PoC directory into non-destructive quarantine archive:                  │
│           `08_TESTING/quarantine_poc/m4_1_quarantine_<timestamp>/`                     │
│                           │                                                            │
│                           ▼                                                            │
│   Step 4: Verify that `06_GAME_PROJECT/` is clean and reset to empty state.            │
│                           │                                                            │
│                           ▼                                                            │
│   Step 5: Record defect in `00_PROJECT_CONTROL/REVIEW_DEFECT_REGISTER.md`              │
│           for directorial review. Zero destructive deletion without authorization.     │
└────────────────────────────────────────────────────────────────────────────────────────┘
```

---

## 7. M4.1 RISK & ACCEPTANCE MATRIX

| Requirement | Measurement Method | Pass Threshold | Failure Threshold | Evidence Artifact | Fallback Action |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **REQ-01: Runtime Stability** | 15-minute continuous interactive run on physical G210 | 15 mins without crash or driver reset | Any crash, hang, or driver TDR | Engine log & Windows Event Log | Quarantine PoC, analyze crash dump, log defect |
| **REQ-02: Frame Pacing Floor** | Engine-observed frame time array via `Time.get_ticks_usec()` | P50 $\le 33.33\text{ ms}$, P95 $\le 36\text{ ms}$, P99 $\le 42\text{ ms}$, $t_{\max}$ reported | P50 $> 33.33\text{ ms}$ or P99 $> 42\text{ ms}$ | `m4_1_frametimes.csv` | Activate Level 1 Fallbacks (downscale shadow map, cap omni lights) |
| **REQ-03: Sustained Framerate** | Total Frames / Elapsed Seconds (NOT mean of instantaneous FPS) | Sustained FPS $\ge 30.0\text{ FPS}$ | Sustained FPS $< 30.0\text{ FPS}$ | Telemetry summary log | Clamp internal 3D render scale to 0.75 |
| **REQ-04: Video Memory** | Internal `RENDER_VIDEO_MEM_USED` + GPU-Z hardware sensor log | Internal $\le 500\text{ MB}$; WDDM dedicated $\le 750\text{ MB}$ | Internal $> 500\text{ MB}$ or dedicated $> 750\text{ MB}$ | Engine monitor log & GPU-Z sensor log | Downscale secondary props to 256x256, reduce shadow cascade |
| **REQ-05: Draw Call Budget** | `Performance.RENDER_TOTAL_DRAW_CALLS_IN_FRAME` | $\le 120$ draw calls | $> 120$ draw calls | Godot performance monitor log | Merge static meshes, enforce MultiMesh batching |
| **REQ-06: Camera Switching** | 20 round-trip transitions across 3 discrete environments | Duration $\le 300\text{ ms}$; P99 $\le 42\text{ ms}$; all spikes logged | P99 $> 42\text{ ms}$ or duration $> 300\text{ ms}$ | `camera_transition_test.csv` (per-env tables) | Simplify spring arm collision shape, tune shoulder centering |
| **REQ-07: Forensic Interaction** | Raycast collision on Layer 2; prompt & diorama handoff | Prompt appears on aim; smooth transition to diorama | Raycast fails, prompt glitches, or input drops | Interactive test capture | Re-tune Area3D collision extents and input routing |
| **REQ-08: Directory Hygiene** | File audit distinguishing code from documentation | Code in `06_GAME_PROJECT/`, reports in `00_PROJECT_CONTROL/` | Runtime code in docs or docs in `06_GAME_PROJECT/` | `git status` verification | Relocate misplaced files prior to review |

---

## 8. CONCRETE DELIVERABLES & ARTIFACT SEPARATION

```text
06_GAME_PROJECT/ (Runtime Implementation Only)
├── project.godot                          # [D1] Godot 4.7.2 config (gl_compatibility, 60Hz physics)
├── scenes/
│   ├── poc/
│   │   ├── m4_1_poc_stage.tscn            # [D2] Master playable PoC test stage
│   │   ├── env_corridor_slice.tscn        # CSG modular street corridor (20m)
│   │   └── clue_telegraph_prop.tscn       # [D4] Interactive forensic clue diorama
│   └── player/
│       ├── proto_humanoid_01.tscn         # [D3] CharacterBody3D + procedural mannequin
│       └── camera_dual_rig.tscn           # Independent 1st/3rd person dual camera rig
├── scripts/
│   ├── player/
│   │   ├── player_controller.gd           # Mannequin locomotion state machine
│   │   └── camera_dual_rig.gd             # Dual-camera controller & state machine
│   ├── interactable/
│   │   └── clue_interactable.gd           # Area3D Layer 2 forensic interaction
│   └── telemetry/
│       └── performance_hud.gd             # Runtime Performance singleton monitor HUD
└── assets/
    ├── materials/ (6 StandardMaterial3D instances using 512x512 ORM maps)
    └── models/ (CSG blockouts and procedural mannequin meshes)

00_PROJECT_CONTROL/ (Project Control & Verification Documentation Only)
└── M4_1_TELEMETRY_BENCHMARK_REPORT.md     # [D5] Empirical G210 measurement report
```

---

## 9. RECOMMENDATION & GATING SIGN-OFF

The Production Director submits this revised proposal for directorial review.

**Current Operational Status:**
- `06_GAME_PROJECT/` remains completely empty and unpopulated.
- Non-Implementation Gate remains **ACTIVE**.
- Execution of Milestone M4.1 will begin **ONLY** upon receipt of the separate explicit **Phase 4 Authorization Directive**.

---
*End of Controlled Phase 4 Implementation Proposal.*
