# PROJECT NULL — DEPARTMENT B: GAME ENGINEERING CHARTER
**Document ID:** PNL-ENG-CHR-001  
**Classification:** Operational Governance & Engineering Charter  
**Version:** 1.0.0  
**Date:** 2026-11-05  
**Author:** Game Engineering Director  
**Target Engine:** Godot Engine 4.7.2 Stable (`gl_compatibility` / OpenGL 3.3)  
**Target Hardware:** Intel Core i5-12400F | 16 GB DDR4 | NVIDIA GeForce G210 (1024 MB DDR3 VRAM, Driver 21.21.13.4201, DX10.1, OpenGL 3.3)

---

## 1. DEPARTMENTAL MISSION & EXECUTIVE SUMMARY

Department B (Game Engineering) is the foundational systems, architecture, and runtime execution unit of PROJECT NULL. The department is chartered to translate the canonical narrative architecture defined in **Book 01: Story Bible** and the visual specifications formulated in **Book 02: Visual Production Bible** into a rock-solid, deterministic, highly optimized, and memory-constrained game application.

The core deliverable of this department is **Book 03: Game Engineering Bible** (`03_GAME_ENGINEERING_BIBLE.md`), supported by modular implementation specifications, automated test suites, and strict architectural contracts.

### Core Strategic Mandates:
1. **Architectural Purity & Strict Typing:** Implement a decoupled, node-composition architecture in Godot 4.7.2 utilizing strictly typed GDScript (`@export`, `class_name`, static return/argument types) and global EventBus signaling to eliminate circular dependencies.
2. **Deterministic Hardware Conformance:** Enforce non-negotiable performance, draw call, and memory budgets tailored strictly for legacy hardware: the NVIDIA GeForce G210 (1024 MB DDR3 VRAM, 16 CUDA cores, 64-bit bus, OpenGL 3.3).
3. **Immersive Dual-Mode Control & Tactile Investigation:** Engineer a seamless, zero-clipping dual-mode camera rig (switchable First-Person / Third-Person) with smooth contextual zoom transitions into 3D item examination (rotation, translation, clue hotspot discovery).
4. **Narrative & State Precision:** Deliver a comprehensive mission state machine tracking flags M-01 through M-12, dialogue branching with typewriter presentation, character agency variables, and tripartite ending trigger arbitration (Endings A, B, and C).
5. **Grounded Mechanics & Phenomenological Realism:** Program the mechanical reality of Locomotive #884 (1:48 grade tractive demand of 53.32 kN starting breakout resistance, 2.07 damp rail adhesion margin, dynamic wheel-slip, 40–50m structural crushing deceleration) and non-Euclidean spatial anomalies (silent chunk re-basing for the 6.4 km Azimuth Deflection loop, SM-14/SM-18 metric non-additivity).
6. **Automated Quality Assurance:** Implement command-line headless automated testing suites (`gut` / custom CLI runner) and atomic JSON save-state serialization with CRC32 verification.

---

## 2. HARDWARE & RENDERER GOVERNANCE (NON-NEGOTIABLE BOUNDARIES)

All code, shaders, scene trees, and asset pipelines under Department B must strictly comply with the **OpenGL 3.3 Compatibility Renderer** (`gl_compatibility`). The deployment target hardware has been definitively verified via `DEC-0001` and active hardware probing:

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                       TARGET HARDWARE & RENDERER PROFILE                    │
├─────────────────────┬───────────────────────────────────────────────────────┤
│ Central Processor   │ Intel Core i5-12400F (6C / 12T @ 2.50 GHz - 4.40 GHz) │
├─────────────────────┼───────────────────────────────────────────────────────┤
│ System Memory       │ 16.0 GB DDR4 RAM (Allocated Game Budget: ≤ 1.2 GB)     │
├─────────────────────┼───────────────────────────────────────────────────────┤
│ Graphics Processor  │ NVIDIA GeForce G210 (Tesla GT218, 16 CUDA Cores)      │
├─────────────────────┼───────────────────────────────────────────────────────┤
│ Video Memory (VRAM) │ 1024 MB DDR3 (64-bit bus, ~8.0 GB/s bandwidth)        │
│                     │ Allocated Game Budget: ≤ 850 MB (174 MB OS/Buffer)    │
├─────────────────────┼───────────────────────────────────────────────────────┤
│ Driver & API Level  │ Driver 21.21.13.4201 | DirectX 10.1 | OpenGL 3.3 Core  │
├─────────────────────┼───────────────────────────────────────────────────────┤
│ Engine & Renderer   │ Godot Engine 4.7.2 Stable Win64 | `gl_compatibility`  │
└─────────────────────┴───────────────────────────────────────────────────────┘
```

### 2.1 Strictly Prohibited Engine Features
The following features are **physically unsupported** by the G210 hardware or the OpenGL 3.3 backend in Godot 4, and any invocation will cause driver crashes, fatal runtime exceptions, or catastrophic stutter:
- **NO Vulkan or Direct3D 12 APIs:** Never configure `rendering_method="forward_plus"` or `rendering_method="mobile"`.
- **NO Compute Shaders:** The `RenderingDevice` API and `.glsl` compute passes are disabled; all simulation logic must run on CPU in GDScript or native worker threads.
- **NO Screen-Space Global Illumination (SSAO/SSIL):** SSAO and Screen-Space Indirect Lighting are strictly banned.
- **NO Real-Time Global Illumination:** SDFGI (`SDFGI3D`) and VoxelGI (`VoxelGI`) are forbidden. Indirect lighting must rely on baked lightmaps or ambient color grading in `WorldEnvironment`.
- **NO Screen-Space Reflections (SSR):** Roughness and specular reflections must use standard environment sky reflections or material parameters.
- **NO Volumetric Fog:** Volumetric fog passes cannot run on OpenGL 3.3. Atmospheric fog must use exponential distance fog in `WorldEnvironment` or transparent billboard particle/quad cards.
- **NO Multi-Light Shadow Casting:** Real-time shadow maps from OmniLight3D and SpotLight3D are strictly prohibited. The scene is allowed exactly **one** DirectionalLight3D casting shadows at **1024x1024** resolution with 2-split PSSM or orthogonal projection.

### 2.2 Hard Performance Budgets (Per-Frame)
- **Draw Calls:** Maximum **250 draw calls** per frame (target: $\le 180$ draw calls in standard interior and exterior scenes).
- **Triangle / Primitive Count:** Maximum **150,000 to 250,000 visible triangles** per frame.
- **Texture Memory Allocation:** Maximum **512 MB** total resident textures in VRAM. Hero items $\le 512 \times 512$; structural modular kits $\le 1024 \times 1024$. All textures must use S3TC/DXT compression (`import_s3tc_bptc=true`).
- **Target Framerate:** Solid **30 FPS minimum / 60 FPS target** at $1280 \times 720$ (native target) and $1920 \times 1080$ (with 0.75x internal scaling if fill-rate bound).

---

## 3. SPECIALIST SQUAD STRUCTURE & MANDATES

Department B is organized into eight specialized engineering roles. Each specialist owns dedicated subsystems, data contracts, and implementation chapters in **Book 03: Game Engineering Bible**:

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    DEPARTMENT B: SPECIALIST SQUAD STRUCTURE                 │
├────┬─────────────────────────────┬──────────────────────────────────────────┤
│ ID │ Specialist Role             │ Core Ownership & Bible Focus             │
├────┼─────────────────────────────┼──────────────────────────────────────────┤
│ B1 │ Godot Architecture Spec.    │ Project tree, Autoloads, EventBus, Types │
│ B2 │ Player Controller Spec.     │ Dual-mode Camera, SpringArm, Raycasting  │
│ B3 │ Investigation Systems Spec. │ 3D item inspection, Hotspots, Folio      │
│ B4 │ Narrative Systems Spec.     │ Dialogue trees, M01-M12 state, Endings   │
│ B5 │ World & Physics Spec.       │ Chunk streaming, Train physics, Anomaly  │
│ B6 │ Audio & Atmosphere Spec.    │ 3D Spatial audio, Infrasound, 16 voices  │
│ B7 │ Save, Performance & QA Spec.│ JSON save schema, Budgets, Headless Test │
│ B8 │ Engineering Reviewer        │ Compatibility audit, G210 bottleneck QA  │
└────┴─────────────────────────────┴──────────────────────────────────────────┘
```

### 3.1 Specialist B1: Godot Architecture Specialist
- **Mandate:** Establish the bedrock directory structure, scene tree conventions, node composition standards, and strict typing contracts across the entire codebase.
- **Key Deliverables:**
  - Standard directory hierarchy (`res://core/`, `res://systems/`, `res://scenes/`, `res://assets/`, `res://tests/`).
  - Core EventBus service (`core/event_bus.gd`) defining strongly typed signals for gameplay events, camera transitions, inventory updates, and audio cues.
  - Core GameState service (`core/game_state.gd`) maintaining live runtime state, session counters, player flags, and inventory registry.
  - Resource caching and asynchronous preloading manager (`core/resource_loader_service.gd`).
  - GDScript Coding Standards & Linting Guide (mandatory static typing, snake_case methods/files, PascalCase classes, typed signals).

### 3.2 Specialist B2: Player Controller Specialist
- **Mandate:** Design and implement the primary player character controller, dual-mode camera rig, collision handling, and interaction raycast pipeline.
- **Key Deliverables:**
  - Character kinematic body controller (`systems/player/player_controller.gd`) supporting walking, running, crouching, physical mass, and stair stepping without jitter.
  - Dual-mode Camera Rig (`systems/camera/camera_rig.gd`) featuring seamless toggling between First-Person ($r = 0.0\text{ m}$) and Third-Person ($r = 2.4\text{ m}$) with `SpringArm3D` zero-clipping collision avoidance against geometry layers.
  - Smooth contextual zoom and depth-of-field transition system for focused inspection of interactive objects.
  - Active-camera interaction raycasting (`systems/interaction/interaction_ray.gd`) detecting `Interactable` components with crosshair feedback and contextual interaction prompts.

### 3.3 Specialist B3: Investigation Systems Specialist
- **Mandate:** Architect the physical investigation engine, tactile 3D prop inspection subsystem, inventory folio, and evidence cross-referencing timeline.
- **Key Deliverables:**
  - 3D Item Inspection Viewport (`systems/investigation/item_examiner.gd`) providing pitch/yaw mesh rotation, continuous texture zoom, lighting rotation, and interactive clue hotspot discovery.
  - Clue & Evidence Data Contracts (`systems/investigation/evidence_item.gd`) defining unique IDs, forensic tags, lead-bound folio metadata, and associated audio spools.
  - The Lead-Bound Folio UI (`systems/investigation/folio_ui.gd`) supporting pagination, blueprint overlays, carbon-slip reading, and document magnification.
  - Timeline Reconstruction & Cross-Referencing Manager (`systems/investigation/timeline_manager.gd`) tracking discovered evidence dependencies and uncovering historical contradictions.

### 3.4 Specialist B4: Narrative Systems Specialist
- **Mandate:** Build the dynamic dialogue engine, typewriter text display, mission progression state machine (M-01 through M-12), and tripartite ending arbitration logic.
- **Key Deliverables:**
  - Graph-based Branching Dialogue System (`systems/narrative/dialogue_manager.gd`) supporting speaker attribution, conditional branching, dialogue audio triggers, and variable injections.
  - Accessible Typewriter UI (`systems/narrative/typewriter_label.gd`) featuring configurable character display rates, punctuation pausing, sound-bite triggers, and skip/fast-forward capabilities.
  - Master Mission State Machine (`systems/narrative/mission_manager.gd`) tracking state flags, entry prerequisites, required clues, and emotional state variables across Missions M-01 to M-12.
  - Tripartite Ending Arbitration Engine (`systems/narrative/ending_arbitrator.gd`) validating conditions for Ending A (Preservation), Ending B (Recognition), and Ending C (Release), handling transition cinematics and credits roll.

### 3.5 Specialist B5: World & Physics Specialist
- **Mandate:** Architect the level streaming and chunk management pipeline, CSG collision generation, mechanical railway simulation for Locomotive #884, and non-Euclidean spatial anomaly execution.
- **Key Deliverables:**
  - Sector & Chunk Streaming Manager (`systems/world/chunk_loader.gd`) performing asynchronous background loading/unloading based on trigger volumes and visibility occluders to respect the 850 MB VRAM budget.
  - Locomotive #884 Physics Model (`systems/physics/train_physics.gd`) simulating:
    - 1:48 grade incline ($2.08\%$ gradient) on the 1,200m helical tunnel.
    - Starting breakout stiction of $53.32\text{ kN}$ ($24.71\text{ kN}$ static journal resistance + $28.61\text{ kN}$ grade resistance).
    - Calculated adhesion margin of $2.07$ against $110.4\text{ kN}$ damp subterranean rail adhesion.
    - Dynamic wheel-slip mitigation via pneumatic sanders.
    - Platform 2 collision model: structural crushing deceleration over $40 - 50\text{ meters}$ absorbing $9.53\text{ MJ}$ of kinetic energy.
  - Spatial Anomaly Runtime Mechanics:
    - **Azimuth Deflection Loop:** Seamless coordinate transformation and silent chunk re-basing along a $6.4\text{ km}$ loop without visual seam or position pop.
    - **Metric Non-Additivity (SM-14 to SM-18):** Non-Euclidean distance warping linking physical curved rail path ($4.30\text{ km}$) with optical straight path ($6.00\text{ km}$) and triangle inequality violation ($6.40\text{ km} > 5.00\text{ km}$).

### 3.6 Specialist B6: Audio & Atmosphere Specialist
- **Mandate:** Design the spatial 3D audio listener rig, distance attenuation curves, low-frequency atmospheric acoustics, and strict 16-voice audio bus architecture.
- **Key Deliverables:**
  - Audio Bus Architecture (`default_bus_layout.tres`) defining Master, Music, Ambience, SFX, Dialogue, and Infrasound sub-buses with real-time low-pass filter ducking.
  - Voice Limiter & Prioritization Manager (`systems/audio/audio_manager.gd`) strictly capping concurrent audio playback to **16 physical voices** to prevent CPU/driver stalls on the G210 platform.
  - Atmospheric Resonance Engine:
    - Continuous $18.4\text{ Hz}$ rotary turbine hum with distance attenuation and structural low-pass filtering through solid rock and concrete over-slabs.
    - Fog acoustic desynchronization: $7 - 10\text{ second}$ local cliff echo followed by faint replicas repeating at predictable **18-minute intervals** across The Outside.
  - Dynamic Soundscape Controller triggering spatialized room reverberation, wet footsteps on ballast/tile, and steam release hiss.

### 3.7 Specialist B7: Save, Performance & QA Specialist
- **Mandate:** Engineer the atomic save/load serialization pipeline, establish telemetry and profiling benchmarks, and build the headless automated testing suite.
- **Key Deliverables:**
  - Atomic JSON Save Pipeline (`core/save_system.gd`) utilizing temporary swap files, schema versioning, and CRC32 checksum verification to eliminate save corruption during sudden power loss.
  - Memory & Performance Profiler (`systems/qa/performance_monitor.gd`) logging real-time FPS, draw calls, video memory usage, static memory usage, and process ticks against established budgets.
  - Automated Headless Test Runner (`tests/test_runner.gd`) executing test scripts from command line via `Godot_v4.7.2-stable_win64_console.exe --headless` for continuous validation.
  - Automated test suites covering mission state transitions, save/load roundtrips, train physics force equations, camera collision clipping, and dialogue branching integrity.

### 3.8 Specialist B8: Engineering Reviewer
- **Mandate:** Conduct uncompromising code audits, enforce OpenGL 3.3 Compatibility renderer compliance, verify shader fallbacks, and optimize fill-rate bottlenecks on the NVIDIA GeForce G210.
- **Key Deliverables:**
  - Compatibility Renderer Compliance Checklist auditing every scene, material, shader, and script against banned engine features.
  - G210 Bottleneck Mitigation Guidelines: fill-rate optimizations, overdraw elimination, shadow pass tuning, and texture compression verification.
  - Comprehensive Audit Report identifying potential performance pitfalls in early scene prototypes and defining corrective refactors.

---

## 4. INTER-DEPARTMENTAL INTERFACES & PIPELINE CONTRACTS

To maintain production velocity and prevent architectural rework, Department B establishes formal interface contracts with neighboring departments:

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                       CROSS-DEPARTMENTAL INTERFACE MATRIX                   │
├──────────────────────────┬──────────────────────────────────────────────────┤
│ Interfacing Department   │ Interface Scope & Technical Contract             │
├──────────────────────────┼──────────────────────────────────────────────────┤
│ Department A:            │ • Mesh format: Binary glTF (.glb)                │
│ Visual Production        │ • Poly budget: ≤ 25k hero props, ≤ 5k modular pcs│
│ (Book 02)                │ • Texture resolution: 512x512 hero, 1024x1024 env│
│                          │ • Texture channels: ORM packed (R:AO, G:Rough,   │
│                          │   B:Metallic) to minimize texture samplers       │
│                          │ • Colliders: Exported as -col or -convcol nodes  │
│                          │ • MultiMesh: Prefab structures aligned to grid   │
├──────────────────────────┼──────────────────────────────────────────────────┤
│ Department C:            │ • Automated texture downsampling via Pillow      │
│ Autonomous AI Studio     │ • GLB geometry and texture budget validation     │
│ (Book 04)                │ • Headless CLI test harness invocation           │
│                          │ • GDScript static linter integration             │
│                          │ • Synthetic scene generation contracts           │
├──────────────────────────┼──────────────────────────────────────────────────┤
│ Department D / E:        │ • Vertical slice milestone gates                 │
│ Production & Execution   │ • Packaging and standalone release exports       │
│ (Book 05)                │ • Profiling telemetry logs & QA sign-off criteria│
└──────────────────────────┴──────────────────────────────────────────────────┘
```

---

## 5. QUALITY GATES & VERIFICATION PROTOCOLS

No code, scene, or system shall be merged into the master project repository (`06_GAME_PROJECT/`) without passing four automated and manual quality gates:

1. **Gate 1: Static Typing & Linter Verification**
   - GDScript must compile with zero warnings when configured for strict typing (`treat_warnings_as_errors=true` in critical core files).
   - All class names, signals, and methods must adhere to project naming standards.
2. **Gate 2: Headless Test Suite Execution**
   - The automated CLI test suite must execute cleanly headlessly:
     ```powershell
     & "Godot_v4.7.2-stable_win64_console.exe" --headless --path "06_GAME_PROJECT" -s "res://tests/test_runner.gd"
     ```
   - All unit and integration test assertions must pass with an exit code of `0`.
3. **Gate 3: Hardware & Renderer Audit**
   - Scene inspection confirming strictly zero prohibited nodes (`VoxelGI`, `SDFGI3D`, `VolumetricFog`, compute shaders).
   - Total material passes must not exceed 1 directional shadow map.
4. **Gate 4: Performance Budget Verification**
   - Profiling of test scenes on representative hardware or calibrated throttling demonstrating $\le 250$ draw calls, $\le 850\text{ MB}$ VRAM usage, and steady framerates.

---

## 6. AUTHORIZATION & COMMENCEMENT

This charter is approved and enacted by the Game Engineering Director for immediate execution across all Wave 1 and Wave 2 engineering deliverables. All eight specialists are authorized to commence research and author their designated sections of **Book 03: Game Engineering Bible**.

**Signed,**  
*Game Engineering Director, PROJECT NULL*  
*Department B (Game Engineering)*  
*November 5, 2026*