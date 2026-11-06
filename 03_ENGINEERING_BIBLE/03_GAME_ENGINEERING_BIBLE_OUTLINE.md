# BOOK 03: GAME ENGINEERING BIBLE — MASTER OUTLINE
**Document ID:** PNL-ENG-OUT-001  
**Classification:** Definitive Technical Specification & Structural Architecture  
**Version:** 1.0.0  
**Date:** 2026-11-05  
**Author:** Game Engineering Director  
**Engine Target:** Godot Engine 4.7.2 Stable (`gl_compatibility` / OpenGL 3.3)  
**Hardware Baseline:** Intel Core i5-12400F | 16 GB DDR4 | NVIDIA GeForce G210 (1024 MB DDR3 VRAM, Driver 21.21.13.4201, DX10.1, OpenGL 3.3)

---

## 1. EXECUTIVE SUMMARY & ARCHITECTURAL FOUNDATION

The **Game Engineering Bible (Book 03)** is the authoritative, comprehensive technical blueprint governing the implementation, systems architecture, optimization, and testing of **PROJECT NULL**. It establishes the complete software specification required to build the game within **Godot Engine 4.7.2 Stable**, operating strictly under the **OpenGL 3.3 Compatibility Renderer** on an ultra-constrained hardware baseline: the **NVIDIA GeForce G210 (1024 MB DDR3 VRAM)**.

This document codifies the 12-chapter structural architecture of Book 03, defining the exact scope, technical formulas, GDScript class interfaces, performance budgets, data schemas, and specialist assignments required for full production execution.

---

## 2. MASTER CHAPTER OUTLINE FOR BOOK 03

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                   BOOK 03: GAME ENGINEERING BIBLE STRUCTURE                 │
├─────────┬────────────────────────────────────────────┬──────────────────────┤
│ Chapter │ Title                                      │ Primary Specialist   │
├─────────┼────────────────────────────────────────────┼──────────────────────┤
│ CH 01   │ Engine Architecture, Node Composition & Stds│ B1. Godot Arch.      │
│ CH 02   │ Autoload Architecture & Global EventBus     │ B1. Godot Arch.      │
│ CH 03   │ Player Character & Dual-Mode Camera Rig    │ B2. Controller Spec. │
│ CH 04   │ Investigation, Tactile 3D Props & Folio    │ B3. Investigation    │
│ CH 05   │ Narrative Systems, Dialogue & State Machine│ B4. Narrative Spec.  │
│ CH 06   │ World Streaming, Physics & Spatial Anomaly │ B5. World & Physics  │
│ CH 07   │ Audio Engineering & Atmospheric Acoustics  │ B6. Audio Spec.      │
│ CH 08   │ Memory Budgets & G210 Hardware Optimization│ B7/B8. QA & Reviewer │
│ CH 09   │ Persistence, Serialization & Atomic Saves  │ B7. Save & QA Spec.  │
│ CH 10   │ Headless Automated Testing & Verification  │ B7. Save & QA Spec.  │
│ CH 11   │ Compatibility Renderer Strict Compliance   │ B8. Engineering Rev. │
│ CH 12   │ Cross-Department Technical Contracts & APIs│ All Specialists      │
└─────────┴────────────────────────────────────────────┴──────────────────────┘
```

---

### CHAPTER 01: ENGINE ARCHITECTURE, NODE COMPOSITION & CODING STANDARDS
*Owner: Specialist B1 (Godot Architecture Specialist)*

#### 1.1 Godot 4.7.2 Compatibility Renderer Foundation
- Rationale and verification of `gl_compatibility` (OpenGL 3.3 Core profile).
- Project settings (`project.godot`) definition:
  - `rendering/renderer/rendering_method="gl_compatibility"`
  - `rendering/textures/vram_compression/import_s3tc_bptc=true`
  - `rendering/textures/vram_compression/import_etc2_astc=false`
  - `rendering/limits/draw_calls=250`
  - `rendering/environment/defaults/default_clear_color=Color(0.04, 0.04, 0.05, 1.0)`
- Target display resolutions: Native $1280 \times 720$ (default), $1920 \times 1080$ (with internal viewport scaling buffer).

#### 1.2 Canonical Repository & Project Directory Architecture
- Standardized file system structure for `res://`:
  ```
  res://
  ├── core/                 # Engine singletons, global event bus, game state, save system
  ├── systems/              # Modular subsystems (camera, player, interaction, narrative)
  │   ├── player/           # Kinematic character controller and input handlers
  │   ├── camera/           # Dual-mode camera rig, spring arm, contextual focus
  │   ├── interaction/      # Raycasting, interactable components, highlight shaders
  │   ├── investigation/    # 3D prop inspection, folio UI, evidence graph
  │   ├── narrative/        # Dialogue tree parser, typewriter, mission state machine
  │   ├── world/            # Chunk streamer, occlusion manager, sector triggers
  │   ├── physics/          # Train physics on 1:48 grade, stiction, wheel-slip
  │   └── audio/            # 16-voice manager, spatial listener, 18.4 Hz generator
  ├── scenes/               # Concrete assembled scenes
  │   ├── characters/       # Player, NPC prefabs, ragdolls
  │   ├── environments/     # District 01, Signal Tower, Platform 0, The Outside
  │   └── ui/               # HUD, Folio, Dialogue Box, Inspection Overlay
  ├── assets/               # Sourced and validated game assets
  │   ├── models/           # GLB binary meshes (modular kits, hero props)
  │   ├── textures/         # DXT-compressed albedo and ORM packed maps
  │   ├── audio/            # OGG/WAV streams (compressed mono/stereo)
  │   └── fonts/            # Monospace and serif typefaces for typewriter/folio
  └── tests/                # Automated headless verification test suites
      ├── unit/             # Core math, state, and serialization tests
      └── integration/      # Mission transitions, camera switches, train physics
  ```

#### 1.3 Node Composition vs. Deep Inheritance Patterns
- Composition-over-inheritance mandate: using specialized component nodes (`InteractableComponent`, `HotspotComponent`, `ClueDataComponent`) rather than monolithic subclass trees.
- Explicit lifecycle and signal wiring in `_ready()` and `_exit_tree()`.

#### 1.4 Strict GDScript Typing Standards & Static Analysis
- Mandatory static typing across all scripts (`@export var speed: float = 4.0`, typed return parameters, explicit enum typing).
- Prohibition of untyped `Variant` arrays and dictionaries in performance-critical loops.
- Naming conventions: `PascalCase` for classes and nodes, `snake_case` for files, variables, and methods, `UPPER_SNAKE_CASE` for constants and enums.

#### 1.5 Resource Lifecycle, Preloading & Asynchronous Cache
- Asynchronous resource loading using `ResourceLoader.load_threaded_request()` to prevent main thread hitches.
- Resource unloading and cache purge protocols to enforce the 850 MB VRAM ceiling.

---

### CHAPTER 02: AUTOLOAD ARCHITECTURE & GLOBAL EVENTBUS
*Owner: Specialist B1 (Godot Architecture Specialist)*

#### 2.1 The Global EventBus (`core/event_bus.gd`)
- Decoupling architecture: systems communicate across boundaries strictly via EventBus signals.
- Complete signal catalog:
  - `gameplay_state_changed(new_state: int, old_state: int)`
  - `camera_mode_toggled(new_mode: int)`
  - `item_inspection_started(item_data: EvidenceItem)`
  - `item_inspection_ended()`
  - `evidence_collected(evidence_id: StringName)`
  - `dialogue_started(speaker_id: StringName, line_id: StringName)`
  - `dialogue_ended()`
  - `mission_state_advanced(mission_id: StringName, new_status: int)`
  - `anomaly_boundary_crossed(anomaly_type: int, parameter: float)`
  - `audio_ambient_cue_triggered(bus_name: StringName, cue_id: StringName)`

#### 2.2 Live Game State Service (`core/game_state.gd`)
- Single source of truth for runtime transient data:
  - Active player position, orientation, and movement velocity.
  - Current mission index (`M01` through `M12`) and sub-objective checklist.
  - Active inventory items and lead-bound folio evidence nodes.
  - Character relationship disposition variables (e.g., `JanosVance_Disposition`, `Elena_Trust`).
  - Environmental clock: Canonical story time (`03:14:00 AM, Oct 19, 2004`).

#### 2.3 Persistence Service (`core/save_system.gd`)
- Autoload contract coordinating serialization, disk writes, atomic renaming, and save validation.

#### 2.4 Scene Management & Transition Manager (`core/scene_manager.gd`)
- Seamless sector transitions with black-out fades, audio ducking, and garbage collection sweeps.

---

### CHAPTER 03: PLAYER CHARACTER & DUAL-MODE CAMERA RIG
*Owner: Specialist B2 (Player Controller Specialist)*

#### 3.1 Kinematic Character Controller (`CharacterBody3D`)
- Grounded motion mathematics:
  - Walk speed ($2.2\text{ m/s}$), brisk walking/sprint ($4.2\text{ m/s}$), crouching ($1.2\text{ m/s}$).
  - Smooth acceleration curves and deceleration braking with inertial decay.
  - Step-climbing algorithm on stair geometry using raycast probes and vertical separation (up to $0.25\text{ m}$ rise) without physics jitter.
  - Gravity application and ground snapping via `floor_snap_length`.

#### 3.2 Dual-Mode Camera Rig Architecture
- Scene tree composition:
  ```
  CameraRig (Node3D)
  └── SpringArm3D (CollisionMask: Environment Layer 1)
      └── Camera3D (Fov: 70°, Near: 0.05m, Far: 100.0m)
  ```
- Instant or smooth interpolated toggling between:
  - **First-Person Mode:** `spring_arm.spring_length = 0.0\text{ m}`, camera positioned at player eye-height ($y = 1.72\text{ m}$).
  - **Third-Person Mode:** `spring_arm.spring_length = 2.4\text{ m}`, offset over player right shoulder ($x = 0.35\text{ m}$, $y = 1.65\text{ m}$).

#### 3.3 Zero-Clipping Geometry Collision Avoidance
- Tuning of `SpringArm3D.margin` ($0.15\text{ m}$) with spherical collision shape (`SeparationRayShape3D` or `SphereShape3D`) to prevent near-plane camera clipping through narrow corridor walls or doorways.

#### 3.4 Mouse Sensitivity Curves & View Angle Limiting
- Dual-axis input handling with configurable sensitivity and exponential curve dampening.
- Pitch limits clamped strictly between $-75.0^\circ$ (downward floor inspection) and $+75.0^\circ$ (upward ceiling inspection).

#### 3.5 Contextual Zoom & Dynamic Focus Framing
- Smooth Field-of-View interpolation (from $70^\circ$ down to $38^\circ$) upon engaging interactive 3D items or mechanical controls.
- Camera focal target repositioning via cubic Hermite splines.

#### 3.6 Active Camera Interaction Raycast Pipeline
- Single `RayCast3D` originating from the active `Camera3D` center point ($length = 2.2\text{ m}$).
- Crosshair UI states: Hidden, Neutral Dot, Interactive Hand, Mechanical Tool, Magnifying Glass.
- Detection of `InteractableComponent` nodes with input filtering (`E` / Primary Action key).

---

### CHAPTER 04: INVESTIGATION, TACTILE 3D PROPS & EVIDENCE SYSTEMS
*Owner: Specialist B3 (Investigation Systems Specialist)*

#### 4.1 Physical Investigation Loop & Tactile Philosophy
- Alignment with Canonical Inscriptional Materialism: clues are dense, physical, unyielding artifacts (rolled sheet lead, brass keys, carbon duplicate slips, mechanical clock escapements).

#### 4.2 3D Item Inspection Viewport Subsystem
- Architecture of isolated sub-viewport (`res://systems/investigation/item_examiner.tscn`):
  - Secondary dedicated camera with orthographic or tight perspective projection.
  - Uncoupled mouse drag rotation around X and Y axes.
  - Continuous mouse-wheel zoom (clamped inspection range).
  - Virtual rotational directional light source allowing the player to cast grazing raking light across stamped serial numbers, file marks, and indented signatures.

#### 4.3 Interactive Clue Hotspot Discovery & Examination Callbacks
- Spatial hotspot markers (`Area3D` components placed on prop geometry) that activate when aligned within camera angle thresholds.
- Discovery callbacks triggering text inspection banners, diary entries, or unlocking folio cross-references.

#### 4.4 The Lead-Bound Folio UI Architecture
- Visual presentation of *The Black Registry*:
  - Pagination system with animated page turns.
  - Split-pane layout: High-resolution document viewer (carbon slips, architectural blueprints) on left; metadata, transcribed text, and cross-reference notes on right.
  - Architectural blueprint layer: Panning and zooming across District 09 and Platform 0 engineering schematics.

#### 4.5 Timeline Reconstruction Engine & Evidence Cross-Referencing
- Evidence data contract (`evidence_item.gd`):
  - `evidence_id: StringName` (e.g., `DOC-002`, `KEY-MERC-04`, `REC-001`).
  - `title: String`
  - `category: int` (DOCUMENT, PHYSICAL_PROP, AUDIO_RECORDING, BLUEPRINT).
  - `historical_date: String` (e.g., `1968-11-20`).
  - `description: String`
  - `associated_missions: Array[StringName]`
  - `is_contradiction_trigger: bool`
- Contradiction deduction board: Player connects two conflicting pieces of physical evidence (e.g., official municipal map vs. 1968 subterranean track survey) to open new investigative paths.

---

### CHAPTER 05: NARRATIVE SYSTEMS, DIALOGUE & MISSION PROGRESSION
*Owner: Specialist B4 (Narrative Systems Specialist)*

#### 5.1 Graph-Based Branching Dialogue Engine
- JSON/Resource-driven dialogue node structure:
  - `node_id: StringName`
  - `speaker_id: StringName` (`THOMAS`, `ELENA`, `JANOS_VANCE`, `ALDOUS_VANE`, `KONRAD_HESS`)
  - `text_raw: String`
  - `voice_audio_cue: String`
  - `prerequisite_flags: Dictionary`
  - `response_choices: Array[DialogueChoice]`
  - `state_mutations: Dictionary` (sets flags, grants items, advances missions)

#### 5.2 Accessible Typewriter Text Display
- Smooth character streaming label (`typewriter_label.gd`):
  - Base typing speed: 35 characters/second.
  - Punctuation cadence delays: commas (0.15s), periods/semicolons (0.35s), paragraph breaks (0.50s).
  - Subtle audio pip feedback per character with pitch variation ($\pm 5\%$) to avoid auditory fatigue.
  - Instant complete on input press; full accessibility skip support.

#### 5.3 Character Relationship & Agency Tracking
- Persistent tracking of character trust, suspicion, and psychological compliance variables:
  - `JanosVance_Hesitation`: Determines whether Vance orders gunfire or holds back in Mission 08.
  - `Elena_TraumaLevel`: Affects dialogue delivery in Vault 04 (Mission 10).
  - `Thomas_GuiltAcknowledged`: Set upon inspecting Dispatch Order #14.

#### 5.4 Master Mission State Machine (M-01 through M-12)
- State transitions, entry conditions, required clue acquisitions, and persistent world state changes:
  - `M-01 (The Empty Address)`: Krupp St flat 4B lock failure; discovery of `DOC-003`.
  - `M-02 (West Junction Night Shift)`: Signal tower; `REC-001` wire recorder spool; 03:14 AM phantom relay.
  - `M-03 (Elena's Locker)`: Plum coat seam; discovery of `KEY-MERC-04`.
  - `M-04 (The Old Canal Printshop)`: Konrad Hess interview; lead binding provenance.
  - `M-05 (The Split House - Greyhaven)`: Retrieval of *The Black Registry* Volume I (`DOC-005`).
  - `M-06 (Platform Zero)`: Subway Line 2 emergency brake; false wall breach.
  - `M-07 (The Sunken Ward)`: Crushed District 09 ruins; wagon inspection; guilt seeds.
  - `M-08 (The Turbine Confrontation)`: Vance philosophical confrontation; 18.4 Hz drone.
  - `M-09 (Threshold of Vault 04)`: Escapement lock sequence using `KEY-MERC-04`.
  - `M-10 (The Crushing Truth)`: Vault 04 interior; *The Black Registry* Volume II (`DOC-006`); Dispatch Order #14 (`DOC-002`) bearing Thomas's signature.
  - `M-11 (Escape to the Surface)`: Boiler ignition of Locomotive #884; rising floodwaters.
  - `M-12 (The Final Arbitration)`: Three-way rail switch at Spur 04.

#### 5.5 Tripartite Ending Trigger Arbitration Engine
- Dedicated arbitration logic for Mission 12:
  - **Ending A (Preservation):** Left switch thrown; surrender of both Registry volumes to Aldous Vane; Elena hospitalized at St. Jude's ICU; Thomas signs perpetual cadastral affidavit.
  - **Ending B (Recognition):** Center switch thrown; Locomotive #884 ascends 1:48 grade; 42 km/h crash through Shaft 7 into Platform 2; evidence scattered across concourse; public trials.
  - **Ending C (Release):** Right switch thrown; northern coal spur into The Outside; train sinks at Km 20; 2,800L emergency oxygen accounting; 14 km forced march to North Quay; timely rescue by Dr. Klaus at 11:15 AM (34 bar / 239L positive reserve); permanent exertional asthma.

---

### CHAPTER 06: WORLD STREAMING, PHYSICS & SPATIAL ANOMALIES
*Owner: Specialist B5 (World and Physics Specialist)*

#### 6.1 Level Streaming & Sector Chunk Management
- Sector streaming engine (`chunk_loader.gd`) enforcing the 850 MB VRAM ceiling:
  - World divided into discrete sectors: District 01 Surface, West Junction Rail Yard, Canal District, Greyhaven, Platform 0 / Tier 1, The Sunken Ward / Tier 3, The Outside.
  - Dynamic loading/unloading based on trigger volumes, airlocks, and occlusion thresholds.
  - Asynchronous background loading with worker threads (`Thread` / `WorkerThreadPool`).

#### 6.2 CSG Geometry to Static Collision Conversion Pipeline
- Rule: Godot CSG nodes (`CSGBox3D`, `CSGCombiner3D`) are strictly limited to prototyping.
- Production pipeline: CSG blocks baked into static `ArrayMesh` with simplified convex collision shapes (`CollisionShape3D`) to minimize physics CPU overhead.

#### 6.3 Mechanical Railway Simulation: Locomotive #884 on 1:48 Grade
- Mathematical simulation model of Class 52 2-10-0 engine (140-tonne consist, 75-tonne adhesive wheelbase):
  - **Starting Breakout Resistance ($v = 0$):**
    $$F_{\text{breakout}} = F_{\text{static\_friction}} + F_{\text{grade}} = (18\text{ N/kN} \times 1,373\text{ kN}) + \left(\frac{1}{48} \times 1,373\text{ kN}\right) = 24.71\text{ kN} + 28.61\text{ kN} = \mathbf{53.32\text{ kN}}$$
  - **Available Damp Rail Adhesion:**
    $$F_{\text{adhesion\_damp}} = \mu_{\text{damp}} \times W_{\text{adhesive}} = 0.15 \times 735.5\text{ kN} = \mathbf{110.4\text{ kN}}$$
  - **Calculated Adhesion Margin:**
    $$\text{Margin} = \frac{110.4\text{ kN}}{53.32\text{ kN}} = \mathbf{2.07}$$
  - **Dynamic Wheel-Slip Simulation:** Tractive effort vs. wheel angular velocity curve; rail dampness modifier ($0.15$ to $0.25$); dynamic sanding activation providing $+40\%$ tractive grip.
  - **Steady Running Resistance at $42\text{ km/h}$:** Grade ($28.61\text{ kN}$) + rolling friction ($4.90\text{ kN}$) + curve ($0.40\text{ kN}$) + air drag ($1.25\text{ kN}$) = $\mathbf{35.16\text{ kN}}$.
  - **Acceleration Demand:** Inertial demand for $a \approx 0.0145\text{ m/s}^2$ = $\mathbf{2.04\text{ kN}}$. Maximum operating demand = $\mathbf{37.20\text{ kN}}$.
  - **Platform 2 Collision Crushing Model:**
    - Kinetic energy at $42\text{ km/h}$ ($11.7\text{ m/s}$): $E_k = \frac{1}{2} m v^2 = \frac{1}{2} (140,000\text{ kg}) (11.67\text{ m/s})^2 = \mathbf{9.53\text{ MJ}}$.
    - Structural crushing deceleration over $40 - 50\text{ meters}$: Mean retarding force of $190 - 238\text{ kN}$; deformation physics and rigid body debris impulse.

#### 6.4 Non-Euclidean Spatial Anomaly Runtime Implementation
- Programming phenomenological anomalies in The Outside without visual tearing or physics instability:
  - **The 6.4 km Azimuth Deflection Loop:**
    - Implementation: Cylindrical space-warp coordinate mapping or silent trigger-based world re-basing.
    - When the player travels along the dead-reckoning trajectory, the engine applies imperceptible rotational coordinate transformations ($\Delta \theta = \frac{2\pi}{6400} \cdot \Delta d$), smoothly returning the player transform to the initial stake coordinate without camera jerk or orientation discontinuity.
  - **Metric Non-Additivity (SM-14 to SM-18):**
    - Runtime implementation: Dual-coordinate metric evaluator.
    - Rail track odometer component records physical curved travel distance of $4.30\text{ km}$.
    - Direct line-of-sight raycast/chaining system samples non-linear spatial scalar field, returning $6.00\text{ km}$ across the flat peat marsh between identical anchor discs.
    - Triangulation calculation directly reproduces the metric axiom violation ($d(A,C) = 6.40\text{ km} > 3.20\text{ km} + 1.80\text{ km}$).

---

### CHAPTER 07: AUDIO ENGINEERING & ATMOSPHERIC ACOUSTICS
*Owner: Specialist B6 (Audio and Atmosphere Specialist)*

#### 7.1 Audio Bus Architecture & Routing
- Audio bus layout (`default_bus_layout.tres`):
  ```
  Master (0 dB)
  ├── Music (-6 dB) -> Dynamic Ducking Send
  ├── Ambience (-3 dB) -> Low-Pass Filter (Cutoff: 12 kHz)
  ├── SFX (0 dB) -> Reverb Send
  ├── Dialogue (+2 dB) -> High-Pass Filter (Cutoff: 100 Hz)
  └── Infrasound (+3 dB) -> Sub-Bass Peaking EQ (18.4 Hz resonance)
  ```

#### 7.2 Strict 16-Voice Concurrency Management
- Real-time voice limiter preventing hardware/driver audio queue stalls on the G210 platform:
  - Global voice allocator with priority ranking:
    1. Active Dialogue / Typewriter Pips (Priority 100)
    2. Player Footsteps & Interaction Feedback (Priority 90)
    3. Mechanical Trains & Critical Machinery (Priority 80)
    4. Environmental Spot Sound Effects (Priority 50)
    5. Ambient Wind / Drips / Low Drone (Priority 20)
  - Hard limit: Exactly **16 active audio streams** playing simultaneously. Lowest-priority voices softly stolen with $25\text{ ms}$ crossfade.

#### 7.3 3D Spatial Audio Listener Rig & Distance Attenuation
- `AudioListener3D` bound to player camera rig with head-shadow filtering.
- Distance attenuation curves: Inverse distance models with customized max distance clamps ($15\text{ m}$ for footsteps, $60\text{ m}$ for steam valves, $250\text{ m}$ for locomotive horns).

#### 7.4 Low-Frequency Infrasound Acoustics: 18.4 Hz Turbine Resonance
- Continuous low-frequency synthesizer generator / calibrated looped WAV sample:
  - Fundamental resonance at $18.4\text{ Hz}$ with sub-harmonic overtones.
  - Dynamic low-pass attenuation based on structural rock depth: Tier 1 ($Cutoff = 80\text{ Hz}$), Tier 2 ($Cutoff = 250\text{ Hz}$), Tier 3 ($Cutoff = 1200\text{ Hz}$, high amplitude).
  - Subtle camera micro-shake effect (amplitude $0.002\text{ m}$) synchronized to the waveform peak.

#### 7.5 The Outside Acoustic Phenomenon: 18-Minute Atmospheric Echo Recurrence
- Acoustic delay memory buffer tracking impulsive audio events (gunshots, signal flares, metallic impacts).
- Timer-based scheduler queuing replica playback:
  - Initial direct sound + $7 - 10\text{ second}$ basalt cliff echo.
  - Replica 1 at $t + 18\text{ minutes}$ (attenuation $-6\text{ dB}$, high-frequency damping).
  - Replica 2 at $t + 36\text{ minutes}$ (attenuation $-14\text{ dB}$).
  - Replica 3 at $t + 54\text{ minutes}$ (attenuation $-22\text{ dB}$, near ambient noise floor).

---

### CHAPTER 08: MEMORY BUDGETS & G210 HARDWARE OPTIMIZATION
*Owners: Specialist B7 (Save/QA) & Specialist B8 (Engineering Reviewer)*

#### 8.1 Hardware Resource Budgets (Target GeForce G210)
- System RAM: Allocated $\le 1.2\text{ GB}$ (Total system 16 GB).
- Dedicated Video RAM: Allocated $\le 850\text{ MB}$ (Total VRAM 1024 MB; 174 MB reserved for OS/DWM and framebuffers).
- Draw Call Budget: Hard cap $\le 250$ draw calls/frame (Standard operational target: $150 - 180$).
- Frame Budget: $33.3\text{ ms}$ (30 FPS rock-solid minimum), target $16.6\text{ ms}$ (60 FPS).

#### 8.2 Geometry Optimization: MultiMeshInstance3D & Occlusion Culling
- Modular architectural kit assembly using `MultiMeshInstance3D`:
  - Subway track ties, tunnel rib arches, cobblestone street sections, and streetlamps batched into single draw call instances.
- Occlusion culling:
  - Baking static `OccluderInstance3D` polygon occluders for all tenement building facades and subterranean tunnel bulkheads.
  - Camera far-plane set strictly to $60 - 90\text{ meters}$ in fog-shrouded districts.

#### 8.3 Texture Streaming, DXT Compression & ORM Texture Packing
- Texture compression mandate: All textures imported with S3TC/DXT1 (Albedo) or DXT5/BC3/BC5 (Normals/ORM).
- ORM Channel Packing Standard:
  - **Red Channel:** Ambient Occlusion (AO).
  - **Green Channel:** Roughness.
  - **Blue Channel:** Metallic.
  - Consolidates three separate texture samplers into a single VRAM fetch pass.
- Maximum texture resolution: Hero inspection props $\le 512 \times 512$; structural environment kits $\le 1024 \times 1024$.

#### 8.4 G210 Fill-Rate Bottlenecks & Overdraw Elimination
- Mitigating the G210's narrow 64-bit memory bus ($\approx 8.0\text{ GB/s}$ bandwidth):
  - Strictly prohibit overlapping alpha-blended transparent surfaces.
  - Steam and smoke particles rendered using small, opaque or alpha-scissor quad clusters rather than large screen-filling semi-transparent cards.
  - Early-Z depth pre-pass optimization.

#### 8.5 Shading & Lighting Rules
- Exactly **one** real-time `DirectionalLight3D` with shadow casting enabled ($1024 \times 1024$ shadow map resolution, 2-split PSSM).
- All `OmniLight3D` and `SpotLight3D` nodes must have `shadow_enabled = false`.
- Ambient lighting achieved via `WorldEnvironment` clear color and baked vertex color modulation.

---

### CHAPTER 09: PERSISTENCE, SERIALIZATION & ATOMIC SAVE ARCHITECTURE
*Owner: Specialist B7 (Save, Performance and QA Specialist)*

#### 9.1 JSON Save State Schema Specification
- Schema versioning (`"schema_version": "1.0.0"`).
- Top-level schema structure:
  ```json
  {
    "schema_version": "1.0.0",
    "timestamp_utc": "2026-11-05T12:00:00Z",
    "story_time": "03:14:00 AM, Oct 19, 2004",
    "player": {
      "transform": { "x": 0.0, "y": 1.72, "z": 0.0, "rot_y": 0.0 },
      "camera_mode": 1,
      "stamina": 1.0
    },
    "missions": {
      "active_mission": "M-01",
      "completed_missions": [],
      "mission_flags": {
        "krupp_st_lock_inspected": true,
        "eviction_warrant_found": true
      }
    },
    "inventory": {
      "items": ["DOC-003", "KEY-MERC-04"],
      "active_slot": 0
    },
    "folio": {
      "unlocked_blueprints": ["BP-D09-01"],
      "active_page": 2,
      "discovered_clues": ["CLUE-001", "CLUE-002"]
    },
    "world_state": {
      "current_sector": "DISTRICT_01",
      "switches": { "switch_14": false },
      "doors": { "flat_4b_deadbolt": true }
    },
    "checksum_crc32": "D4F8A1C2"
  }
  ```

#### 9.2 Atomic File Replacement Protocol
- Step 1: Serialize game state into in-memory JSON string.
- Step 2: Calculate CRC32 checksum of JSON payload.
- Step 3: Write payload to temporary file (`user://save_game.tmp`).
- Step 4: Flush file buffers to disk via `FileAccess.flush()`.
- Step 5: Atomically rename `user://save_game.tmp` to `user://save_game.sav` via `DirAccess.rename_absolute()`.
- Eliminates file corruption caused by crashes or system power loss during write operations.

#### 9.3 Partial State Serialization & World Delta Tracking
- Storing only mutated state objects (doors opened, items collected, levers thrown) rather than serializing static scene trees.

#### 9.4 Corruption Recovery & Save Migration Safeguards
- Fallback backup mechanism (`user://save_game.bak`).
- Automated schema migration scripts updating legacy save formats to current versions.

---

### CHAPTER 10: HEADLESS AUTOMATED TESTING & CONTINUOUS VERIFICATION
*Owner: Specialist B7 (Save, Performance and QA Specialist)*

#### 10.1 Command-Line Headless Godot Test Harness
- Execution protocol using Godot 4.7.2 console binary:
  ```powershell
  & "Godot_v4.7.2-stable_win64_console.exe" --headless --path "res://" -s "res://tests/test_runner.gd"
  ```
- Standardized exit codes: `0` = All tests passed; `1` = Assertion failure; `2` = Runtime crash/exception.

#### 10.2 Unit Testing Framework Architecture
- Lightweight, self-contained test assertion runner (`tests/test_runner.gd`):
  - `assert_true(condition: bool, message: String)`
  - `assert_equal(actual: Variant, expected: Variant, message: String)`
  - `assert_almost_equal(actual: float, expected: float, tolerance: float, message: String)`
  - `assert_signal_emitted(emitter: Object, signal_name: StringName)`

#### 10.3 Integration Test Suites
- `test_save_load_cycle.gd`: Serializes full state, modifies memory, reloads from disk, verifies exact field parity and CRC32 validity.
- `test_mission_progression.gd`: Simulates mission advancement from M-01 to M-12, testing prerequisite validations and state flag locks.
- `test_dialogue_graph.gd`: Parses all dialogue JSON files, verifying zero dead-end nodes, valid speaker IDs, and reachable branch endpoints.
- `test_train_physics_equations.gd`: Validates starting breakout resistance ($53.32\text{ kN}$), damp adhesion margin ($2.07$), and kinetic energy dissipation ($9.53\text{ MJ}$).

#### 10.4 Automated Physics & Camera Verification Scripts
- Automated camera ray collision test confirming that sweeping camera 360 degrees inside narrow test geometry produces zero near-plane clipping.

#### 10.5 CI/CD Quality Gates & Automated Exit Code Handling
- Continuous integration scripts returning exit codes directly to the production coordinator for automated build gate validation.

---

### CHAPTER 11: COMPATIBILITY RENDERER STRICT COMPLIANCE & SHADING STANDARDS
*Owner: Specialist B8 (Engineering Reviewer)*

#### 11.1 Prohibited Engine Features Checklist & Static Auditor
- Static script auditing all `.tscn` and `.tres` resource files for prohibited class tokens:
  - Reject `VoxelGI`, `SDFGI3D`, `VolumetricFog`, `ReflectionProbe`, `GPUParticles3D` (when configured with compute paths).
- Build error thrown if any banned node is present in the build tree.

#### 11.2 OpenGL 3.3 Shader Specification & Material Architecture
- Shading model: Standard Lambertian diffuse with Blinn-Phong or low-cost GGX specular approximation.
- Custom vertex/fragment shaders written in Godot shading language (`shader_type spatial; render_mode blend_mix, depth_draw_opaque, cull_back;`).
- Complete ban on texture arrays and complex branching logic within fragment shaders.

#### 11.3 Fallback Strategies for Legacy Visual Features
- **Atmospheric Fog:** Implemented via `WorldEnvironment` exponential distance fog (`mode = FOG_EXPONENTIAL`, `density = 0.02`, `light_energy = 0.8`) combined with rotating billboard fog quad cards.
- **Indirect Lighting:** High-contrast chiaroscuro design, ambient sky tinting, and baked vertex color occlusions.
- **Surface Reflections:** Roughness-tuned environment cubemaps rather than real-time screen-space reflections.

#### 11.4 Comprehensive Compatibility Audit Protocol
- Step-by-step audit procedure for verifying scenes on clean OpenGL 3.3 test harnesses before deployment to the G210 target.

---

### CHAPTER 12: CROSS-DEPARTMENT TECHNICAL CONTRACTS & DELIVERABLES
*Owner: All Specialists & Game Engineering Director*

#### 12.1 Visual Production (Book 02) Asset Ingestion Contract
- Deliverable formats: Binary glTF (`.glb`) exclusively.
- Texture formats: PNG/TGA for source, imported to DXT/BC via Godot engine importer.
- Asset budgets: Hero props $\le 25,000$ tris; modular architectural blocks $\le 5,000$ tris.
- Pivot points: World-space origin $(0,0,0)$ placed at base center for snapping.

#### 12.2 Autonomous AI Studio (Book 04) CLI & Validation Tooling Contract
- Texture processing: Python Pillow scripts for automated resizing ($\le 1024\text{ px}$) and channel packing.
- Geometry validation: Headless GLB inspection scripts verifying vertex count, UV presence, and material counts.
- Automated code linters executing GDScript syntax validation.

#### 12.3 Execution Manual (Book 05) Milestone & Release Criteria
- Milestone 1: Core Engine Framework & Headless CI verification.
- Milestone 2: Dual Camera & Interaction Prototype.
- Milestone 3: Playable Vertical Slice (District 01 / Krupp St / Signal Tower).
- Milestone 4: Subterranean Systems & Train Physics.
- Milestone 5: The Outside & Tripartite Ending Arbitration.

#### 12.4 Wave 2 Specialist Assignment Matrices & Implementation Schedule
- Assignment schedules, prerequisites, and milestone deadlines for Specialists B1 through B8.

---

## 3. SPECIALIST ASSIGNMENT & DELIVERABLE MATRIX (WAVE 2 PREPARATION)

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    WAVE 2 SPECIALIST DELIVERABLE SCHEDULE                   │
├────┬─────────────────────────────┬──────────────────────────────────────────┤
│ ID │ Specialist Role             │ Wave 2 Target Implementation Artifacts   │
├────┼─────────────────────────────┼──────────────────────────────────────────┤
│ B1 │ Godot Architecture Spec.    │ • core/event_bus.gd                      │
│    │                             │ • core/game_state.gd                     │
│    │                             │ • core/resource_loader_service.gd        │
│    │                             │ • project.godot (Verified baseline)      │
├────┼─────────────────────────────┼──────────────────────────────────────────┤
│ B2 │ Player Controller Spec.     │ • systems/player/player_controller.gd    │
│    │                             │ • systems/camera/camera_rig.gd           │
│    │                             │ • systems/camera/camera_rig.tscn         │
│    │                             │ • systems/interaction/interaction_ray.gd │
├────┼─────────────────────────────┼──────────────────────────────────────────┤
│ B3 │ Investigation Systems Spec. │ • systems/investigation/evidence_item.gd │
│    │                             │ • systems/investigation/item_examiner.gd │
│    │                             │ • systems/investigation/item_examiner.tscn│
│    │                             │ • systems/investigation/folio_ui.gd      │
├────┼─────────────────────────────┼──────────────────────────────────────────┤
│ B4 │ Narrative Systems Spec.     │ • systems/narrative/dialogue_manager.gd  │
│    │                             │ • systems/narrative/typewriter_label.gd  │
│    │                             │ • systems/narrative/mission_manager.gd   │
│    │                             │ • systems/narrative/ending_arbitrator.gd │
├────┼─────────────────────────────┼──────────────────────────────────────────┤
│ B5 │ World & Physics Spec.       │ • systems/world/chunk_loader.gd          │
│    │                             │ • systems/physics/train_physics.gd       │
│    │                             │ • systems/world/azimuth_loop_warp.gd     │
├────┼─────────────────────────────┼──────────────────────────────────────────┤
│ B6 │ Audio & Atmosphere Spec.    │ • default_bus_layout.tres                │
│    │                             │ • systems/audio/audio_manager.gd         │
│    │                             │ • systems/audio/infrasound_generator.gd  │
├────┼─────────────────────────────┼──────────────────────────────────────────┤
│ B7 │ Save, Performance & QA Spec.│ • core/save_system.gd                    │
│    │                             │ • systems/qa/performance_monitor.gd      │
│    │                             │ • tests/test_runner.gd                   │
│    │                             │ • tests/unit/test_save_load_cycle.gd     │
├────┼─────────────────────────────┼──────────────────────────────────────────┤
│ B8 │ Engineering Reviewer        │ • tools/audit_compatibility_renderer.gd  │
│    │                             │ • audits/g210_performance_report.md      │
└────┴─────────────────────────────┴──────────────────────────────────────────┘
```

---

## 4. SIGN-OFF & STRUCTURAL APPROVAL

The structural outline for **Book 03: Game Engineering Bible** is hereby locked and ratified. It represents the authoritative structural blueprint that will guide all Department B specialists throughout Wave 2 and full production.

**Approved by:**  
*Game Engineering Director, PROJECT NULL*  
*Department B (Game Engineering)*  
*November 5, 2026*