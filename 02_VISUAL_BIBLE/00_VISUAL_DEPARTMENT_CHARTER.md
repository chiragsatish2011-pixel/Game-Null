# PROJECT NULL — DEPARTMENT A: VISUAL PRODUCTION CHARTER
**Document ID:** PNL-CHARTER-DEPT-A  
**Classification:** Operational Department Charter & Governance Standard  
**Version:** 1.0.0  
**Date:** 2026-11-05  
**Department Lead:** Visual Production Director (`6f7de551-99ee-49bf-80bb-8413af5bcb84`)  
**Target Book:** Book 02: Visual Production Bible (`02_VISUAL_PRODUCTION_BIBLE.md`)  

---

## 1. EXECUTIVE MISSION & CORE MANDATE

Department A (Visual Production) is responsible for the total aesthetic, architectural, material, spatial, character, and cinematographic realization of **PROJECT NULL**. The department translates the narrative canon, historical weight, and philosophical tension codified in *Book 01: The Story Bible* into concrete, physically plausible, and aesthetically devastating visual assets and specifications.

### 1.1 The Visual Axiom: Inscriptional Materialism
The visual philosophy of PROJECT NULL is governed by a central thematic conflict: **Plastic Societal Consensus versus Stubborn Physical Matter**.
- **The State's Facade:** Smooth, orderly, mathematically sterile, post-Settlement Neoclassical geometry. Immaculate limestone ministries, broad granite boulevards, uniform municipal fonts, and fresh purple administrative ink.
- **The Physical Residue:** Cold, damp, heavy, non-biodegradable matter that stubbornly remembers what the state erases. Rolled 3mm sheet lead, St. Jude’s high-density ironstone, pitted cast bronze, oily creosote-soaked timber, tarnished brass escapements, and soot-caked boiler iron.
- **Visual Tone:** Grounded, tactile, cold, desaturated psychological realism. PROJECT NULL is not a sci-fi dystopia with glowing holograms or neon lights, nor is it a fantasy realm with magical mist. Every visual element must carry the tactile friction of 19th-to-mid-20th-century heavy mechanical engineering and bureaucratic totalitarianism.

### 1.2 Absolute Hardware & Pipeline Boundaries
All visual concepts, geometries, materials, animations, and lighting must strictly comply with two non-negotiable technical directives:
1. **Target Hardware Profile:** 
   - CPU: Intel Core i5-12400F | RAM: 16 GB DDR4.
   - GPU: **NVIDIA GeForce G210 (1024 MB DDR3 VRAM, PCIe 2.0, 16 CUDA cores).**
   - API / Renderer: **Godot 4.7.2 Compatibility Renderer (`gl_compatibility` / OpenGL 3.3).**
   - No Vulkan, no Direct3D 12, no compute shaders, no screen-space reflections (SSR), no volumetric fog, no real-time multi-light shadow cascades.
2. **Strictly Blender-Free Asset Production:**
   - Zero dependency on Blender for modeling, UV unwrapping, baking, rigging, or file conversion.
   - Environment architectural shells built via Godot CSG primitives and modular sub-scenes.
   - Organic and mechanical hero props sourced from CC0 libraries (Poly Haven) or generative AI mesh services (Meshy / Tripo AI), imported as binary `.glb`.
   - Texture optimization, resizing, and ORM channel packing executed via automated Python scripts using Pillow (`PIL`).

---

## 2. DEPARTMENT SCOPE & BOUNDARIES

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    DEPARTMENT A: VISUAL PRODUCTION SCOPE                    │
├───────────────────────────────────┬─────────────────────────────────────────┤
│ Scope Category                    │ In-Scope Responsibilities               │
├───────────────────────────────────┼─────────────────────────────────────────┤
│ 1. Environment Architecture       │ Architectural style guides, district    │
│    & Spatial Design               │ profiles (Districts 01–05, 09), The     │
│                                   │ Deep (Tiers 1–3, Vault 04), Greyhaven,  │
│                                   │ and The Outside (Km 14–18 anomalies).   │
├───────────────────────────────────┼─────────────────────────────────────────┤
│ 2. Character Art & Visual Identity│ Silhouettes, anatomical proportions,    │
│                                   │ costume textiles, aging progression,   │
│                                   │ facial expressions for 5 core leads and │
│                                   │ 5 secondary Witness Network figures.   │
├───────────────────────────────────┼─────────────────────────────────────────┤
│ 3. Industrial & Prop Design       │ Detailed mechanical specifications for  │
│                                   │ signal levers, escapement clocks, wire  │
│                                   │ recorders, lead-bound folios, stamps,   │
│                                   │ and Locomotive #884 (Class 52 2-10-0).  │
├───────────────────────────────────┼─────────────────────────────────────────┤
│ 4. Materials, Shading & Lighting  │ OpenGL 3.3 PBR standard, ORM channel    │
│                                   │ packing, texture resolution gates,      │
│                                   │ single directional shadow model, and    │
│                                   │ distance fog calibration.               │
├───────────────────────────────────┼─────────────────────────────────────────┤
│ 5. Animation & Camera Language    │ Traversal kinetics (56y Thomas's limp,  │
│                                   │ 26y Elena's pace), dual 1st/3rd person  │
│                                   │ camera framing, and 3D clue inspection. │
├───────────────────────────────────┼─────────────────────────────────────────┤
│ 6. Asset Pipeline & Optimization  │ Generative GLB intake, automated Python │
│                                   │ mesh inspection, texture channel        │
│                                   │ packing, and Godot CSG modular systems. │
├───────────────────────────────────┼─────────────────────────────────────────┤
│ 7. Visual Quality & Budget Gate   │ VRAM allocation monitoring, triangle    │
│                                   │ count enforcement, draw call capping,   │
│                                   │ and aesthetic cohesion verification.    │
└───────────────────────────────────┴─────────────────────────────────────────┘
```

---

## 3. SPECIALIST ROSTER & DIRECTORIAL ASSIGNMENTS

Department A deploys 7 specialized production roles. Each specialist owns distinct research mandates, deliverable chapters, technical constraints, and quality acceptance criteria.

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                      DEPARTMENT A: SPECIALIST ASSIGNMENTS                   │
├───────┬───────────────────────────────┬─────────────────────────────────────┤
│ ID    │ Role Title                    │ Core Ownership                      │
├───────┼───────────────────────────────┼─────────────────────────────────────┤
│ A1    │ Environment Art Researcher    │ Architecture, Geography & Landscapes│
│ A2    │ Character Art Director        │ Visual Identity, Faces & Costumes   │
│ A3    │ Prop & Industrial Designer    │ Mechanical Devices, Props & Clues   │
│ A4    │ Materials & Lighting Spec.    │ Shaders, ORM Textures & Compatibility│
│ A5    │ Animation & Camera Director   │ Movement Language & Camera Systems  │
│ A6    │ Asset Pipeline Specialist     │ Blender-Free Ingestion & Python PIL │
│ A7    │ Visual Quality Reviewer       │ Budget Gatekeeper & Aesthetic Audit │
└───────┴───────────────────────────────┴─────────────────────────────────────┘
```

### 3.1 Specialist A1: Environment Art Researcher
- **Objective:** Establish the comprehensive architectural visual guide for all narrative locations in Vesper Basin, The Deep, Greyhaven, and The Outside.
- **Specific Tasks:**
  1. *District 01 (The Park District):* Monumental Neoclassical rationalism, limestone facades, manicured sycamores, bronze fittings, over-slab surface reality.
  2. *District 02 (The Foundry & West Junction):* Soot-blackened brickwork, railway cuts, overhead telegraph/signal wire networks, creosote wood, mechanical lever tower exterior/interior.
  3. *District 03 (Old Canal & Wharves):* Salt-glazed industrial brick, warehouse timbering, foggy quays, Konrad Hess's damp basement bookbindery.
  4. *District 04 (High Tenements):* Five-story sandstone tenements, steep iron funiculars, laundry lines, "Seven Hundred Steps".
  5. *District 05 (University & Medical Terraces):* Classical stone institutionalism, geological archives, high-ceiling Victorian infirmary wards.
  6. *The Deep (Tiers 1–3 & The Sunken Ward):* White-tiled Metro Line 2 and Platform 0; raw limestone caverns with coal spurs; crushed District 09 storefronts sitting beneath 120 concrete caissons; colossal Rotary Turbine Hall (18.4 Hz); Vault 04 hermetic armor redoubt.
  7. *Greyhaven & The Outside:* Salt marshes, pine barrens, granite sea bluffs, persistent maritime advection fog ("The Grey Sheet"), abandoned 1920 mining railway, and visual markers of metric non-additivity and displaced matter.
- **Deliverables:** Sections 3.1 through 3.8 of Book 02.

### 3.2 Specialist A2: Character Art Director
- **Objective:** Define the physical appearance, anatomical silhouettes, aging progression, clothing materials, and emotional expressions for all canonical figures.
- **Specific Tasks:**
  1. *Thomas Mercer (Age 56):* Heavy silhouette, stooped posture, weathered grey stubble, worn woolen railway greatcoat with tarnished municipal brass buttons, scuffed leather workboots, deliberate gait with left-knee weight shift.
  2. *Elena Mercer (Age 26):* Sharp angular jawline, dark observant eyes, practical registrars’ dark wool coat, ink-stained cuffs, wool scarf, severe fatigue, pallor from pulmonary distress.
  3. *Janos Vance (Age 61):* Bulky administrative frame, rumpled brown tweed overcoat, heavy horn-rimmed glasses, tobacco-stained fingers, worn leather audit briefcase.
  4. *Aldous Vane (Age 68):* Severe, razor-thin silhouette, bespoke dark charcoal wool suit, high starched collar, pocket watch chain, cold expressionless detachment.
  5. *Konrad Hess (Age 72):* Gnarled, scarred hands from bookbinder’s needles and bone folders, heavy leather apron, wire spectacles, hollow eyes of 1967 fire trauma.
  6. *The Witness Network:* Distinct visual archetypes for Marta Kroll (nurse's starch and wool cape), Goran Lindt (young grease-smeared signalman), Aunt Lidia (rural Greyhaven homespun shawls), Pavel Radek (leather trenchcoat auditor), Henrik Baum (confused, timid new tenant).
- **Deliverables:** Chapter 4 of Book 02.

### 3.3 Specialist A3: Prop and Industrial Design Specialist
- **Objective:** Specify the complete mechanical design, materials, wear patterns, and 3D evidence models for the tactile bureaucratic world.
- **Specific Tasks:**
  1. *Railway Infrastructure:* 64-lever interlocking mechanical frame (color-coded red/black/white levers, quadrant plates, locking dogs), mechanical train describer, brass telegraph keys.
  2. *Locomotive #884:* Visual design of the DRB Class 52 2-10-0 freight locomotive (blackened boiler plate, 5 coupled driving axles, sheet-metal smoke deflectors, coal tender, armored postal wagon).
  3. *Bureau Municipal Apparatus:* Cast-iron document cancellers, embossed lead seal presses, indelible purple aniline ink stamp pads, pneumatic tube capsules.
  4. *The Black Registry (Volumes I & II):* 3mm rolled sheet-lead bindings over oak boards, pitted surface oxidation, dual brass lever-tumbler locks, cream rag-cotton folios, carbon-transfer receipts.
  5. *3D Interactive Clues:* Dispatch Order #14, brass dispatch clocks, wire recorder spools, invar survey chains, bronze survey discs `SM-14` and `SM-18`, chemical eviction warrants.
- **Deliverables:** Chapter 5 of Book 02.

### 3.4 Specialist A4: Materials and Lighting Specialist
- **Objective:** Formulate the PBR shader rules, texture memory constraints, ORM channel packing protocols, and lighting pipeline under Godot 4 Compatibility Renderer.
- **Specific Tasks:**
  1. *VRAM & Texture Allocations:* Hero props capped at 512x512; architectural surfaces capped at 1024x1024; shared 512x512 palettes for minor clutter.
  2. *ORM Channel Packing Standard:* R = Ambient Occlusion, G = Roughness, B = Metallic. Total reduction of texture memory overhead by 66%.
  3. *Master Material Library:* Visual definition for 8 canonical surfaces: St. Jude's Ironstone, Weathered Neoclassical Limestone, Salt-Glazed Red Brick, Rolled Sheet Lead, Cast Foundry Iron, Oiled Creosote Timber, Tarnished Dial Brass, and Wet Coastal Peat.
  4. *Lighting Architecture:* Exactly 1 directional light (sun/moon) casting a single 1024x1024 depth shadow map; ambient fill via constant environment energy; distance fog in `WorldEnvironment`; simulated light beams using transparent additive billboard cards.
- **Deliverables:** Chapters 6 and 7 of Book 02.

### 3.5 Specialist A5: Animation and Cinematics Director
- **Objective:** Establish the movement kinematics, camera choreography, and low-cost cinematic staging systems.
- **Specific Tasks:**
  1. *Traversal Motion Language:* 56-year-old Thomas's deliberate, grounded movement (slower turn rate, slight left-leg limp, heavy bootfalls) vs. Elena's brisk, urgent stride.
  2. *Dual-Mode Camera System:* 3rd-person over-the-shoulder traversal rig transitioning seamlessly to 1st-person inspection mode without clipping through geometry.
  3. *Contextual Evidence Zoom:* Dynamic focal shift to inspect 3D items in hand with rotation, translation, and localized lighting highlight.
  4. *No-Mocap Cinematic Dialogue:* Grounded, cinematic staging using locked camera cuts, shallow depth-of-field simulation (via distance fog), micro-idle breathing loops, head turns, and dramatic chiaroscuro key lighting.
- **Deliverables:** Chapter 8 of Book 02.

### 3.6 Specialist A6: Asset Pipeline Specialist
- **Objective:** Codify the end-to-end, strictly Blender-free asset production workflow.
- **Specific Tasks:**
  1. *Poly Haven Ingestion Protocol:* Automated sourcing of CC0 architectural textures and environmental elements, standardized downsampling to 1024/512.
  2. *Generative 3D Mesh Intake (Meshy / Tripo AI):* Exact prompt syntax, polygon budget enforcement (≤1,500 triangles per prop), and `.glb` binary import pipeline.
  3. *Python Automation Tools:* PIL-based batch downsampling scripts, ORM packing scripts, and struct-based GLB vertex/mesh inspection tools.
  4. *Godot CSG Prototyping Standards:* Architectural room-and-corridor modular blocks (`CSGBox3D`, `CSGPolygon3D`), collision standards, and conversion to static meshes or MultiMesh.
- **Deliverables:** Chapter 9 of Book 02.

### 3.7 Specialist A7: Visual Quality Reviewer
- **Objective:** Establish the verification gatekeeper system to ensure zero aesthetic drift and absolute hardware compliance.
- **Specific Tasks:**
  1. *Hardware Budget Gate:* Strict enforcement of draw calls (≤180–250 per frame), total scene triangle count (≤100,000 active), and texture VRAM (≤350 MB committed to textures).
  2. *Aesthetic Coherence Audit:* Zero sci-fi tropes, zero fantasy glowing runes, zero plastic/clean CGI surfaces, strict historical texture authenticity.
  3. *Pre-Commit Inspection Gate:* Formal checklist that every 3D model, material, and scene must pass before being imported into `res://`.
- **Deliverables:** Chapter 10 of Book 02.

---

## 4. HARDWARE PERFORMANCE CONSTRAINTS (NVIDIA GEFORCE G210)

The entire visual production of PROJECT NULL is architected around the hard performance ceiling of the NVIDIA GeForce G210 running the Godot 4.7.2 Compatibility Renderer (`gl_compatibility` / OpenGL 3.3).

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                 NVIDIA GEFORCE G210 HARDWARE SPECIFICATION                  │
├───────────────────────────────┬─────────────────────────────────────────────┤
│ Architecture / Generation     │ Tesla (GT218, 40nm process)                 │
│ CUDA Cores / Texture Units    │ 16 Cores | 8 TMUs | 4 ROPs                  │
│ Core Clock / Memory Clock     │ 589 MHz Core | 500 MHz DDR3 Memory          │
│ Video Memory (VRAM)           │ 1024 MB DDR3 (64-bit bus, 8.0 GB/s bandwidth)│
│ Bus Interface                 │ PCI Express 2.0 x16                         │
│ API Level                     │ OpenGL 3.3 Core Profile                     │
│ Hardware Shader Support       │ Shader Model 4.1 (No Compute Shaders)       │
└───────────────────────────────┴─────────────────────────────────────────────┘
```

### 4.1 VRAM Allocation Budget (1024 MB Total Ceiling)
Because memory bandwidth is restricted to 8.0 GB/s on a 64-bit bus, VRAM thrashing will immediately collapse frame rates. The 1024 MB pool is allocated with strict safety headroom:

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                        1024 MB VRAM BUDGET ALLOCATION                       │
├───────────────────────────────────┬───────────────┬─────────────────────────┤
│ Subsystem                         │ Allocation    │ Percentage              │
├───────────────────────────────────┼───────────────┼─────────────────────────┤
│ Framebuffers & Render Targets     │ 128 MB        │ 12.5%                   │
│ Shadow Map (1x Directional 1024²) │ 32 MB         │ 3.1%                    │
│ Static Environment Textures (PBR) │ 250 MB        │ 24.4%                   │
│ Character & Hero Prop Textures    │ 100 MB        │ 9.8%                    │
│ UI & Font Textures                │ 30 MB         │ 2.9%                    │
│ Geometry Vertex & Index Buffers   │ 80 MB         │ 7.8%                    │
│ Godot Internal Drivers & Overhead │ 200 MB        │ 19.5%                   │
│ Unallocated Safety Margin         │ 204 MB        │ 20.0%                   │
├───────────────────────────────────┼───────────────┼─────────────────────────┤
│ Total Dedicated Video Memory      │ 1024 MB       │ 100.0%                  │
└───────────────────────────────────┴───────────────┴─────────────────────────┘
```

### 4.2 Rendering Metric Constraints
- **Draw Calls:** Maximum **180–250 draw calls per frame**. Controlled via `MultiMeshInstance3D` for streetlights, track ties, brick repeats, and modular walls.
- **Scene Triangle Count:** Maximum **75,000 to 100,000 triangles visible in frustum**.
- **Prop Polygon Budgets:**
  - Hero Props (Clocks, Lever Frame, Black Registry): 1,000 – 1,500 triangles.
  - Secondary Clutter (Ink pots, ledgers, teacups): 200 – 500 triangles.
  - Characters (Thomas, Elena): 5,000 – 8,000 triangles.
  - Architectural Modules (Wall sections, pillars): 50 – 300 triangles.
- **Texture Dimensions:**
  - Hero props & characters: Max 512x512 Albedo + 512x512 ORM + 512x512 Normal.
  - Architectural tileables: Max 1024x1024 Albedo + 1024x1024 ORM + 1024x1024 Normal.
  - Minor props & documents: 256x256 or atlased into shared sheets.
- **Lighting Limits:**
  - Real-time shadows: Exactly **1 DirectionalLight3D** with 1024x1024 shadow map.
  - Point and Spot lights: **Shadows DISABLED**. Maximum 4–6 active omni/spot lights in any single viewing frustum.
  - Ambient Lighting: Provided via `WorldEnvironment` clear color and ambient tint.
  - Fog: Simulated exclusively via `WorldEnvironment` exponential distance fog. Zero volumetric fog.

---

## 5. CROSS-DEPARTMENT DEPENDENCY GRAPH & INTERFACE CONTRACTS

Department A interfaces directly with Department B (Game Engineering) and Department C (Autonomous AI Studio). The operational contracts are defined below:

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                 DEPARTMENT A: CROSS-DEPARTMENT DEPENDENCY GRAPH             │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   [BOOK 01: STORY BIBLE] ─────────────────────────────────────────────┐     │
│   (Locked Canonical Foundation: Characters, Locomotives, Lore)        │     │
│                                │                                      │     │
│                                ▼                                      │     │
│               ┌───────────────────────────────────┐                   │     │
│               │ DEPARTMENT A: VISUAL PRODUCTION   │                   │     │
│               │ (Book 02: Visual Production Bible)│                   │     │
│               └─────────────────┬─────────────────┘                   │     │
│                                 │                                     │     │
│        ┌────────────────────────┼────────────────────────┐            │     │
│        ▼                        ▼                        ▼            │     │
│ ┌───────────────┐      ┌─────────────────┐      ┌─────────────────┐   │     │
│ │ DEPT B (ENG)  │      │ DEPT C (AI)     │      │ DEPT E (EXEC)   │   │     │
│ ├───────────────┤      ├─────────────────┤      ├─────────────────┤   │     │
│ │ B2 Camera Rig │◄────►│ C4 Gen3D Pipeline│◄────►│ Release Package │   │     │
│ │ B3 Clue Zoom  │      │ C6 QA Gates     │      │ Vertical Slice  │   │     │
│ │ B5 Streaming  │      │ C1 Agent Graph  │      │ Milestones      │   │     │
│ │ B7 G210 Perf  │      │                 │      │                 │   │     │
│ └───────────────┘      └─────────────────┘      └─────────────────┘   │     │
│                                                                       │     │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 5.1 Department B (Game Engineering) Interface Contracts
1. **Contract `DEP-A-B-01`: Dual-Camera System & Inspection Zoom**
   - *Visual Ownership:* Camera FOV (65° traversal, 45° inspection), near/far planes (0.05m near, 120m far), spring-arm offsets, and evidence inspection illumination rig.
   - *Engineering Ownership:* `CameraRig` GDScript, input capturing, collision masking on spring-arm, raycasting interaction layer (`systems/interaction/interaction_ray.gd`).
2. **Contract `DEP-A-B-02`: G210 Performance Budget Enforcement**
   - *Visual Ownership:* MultiMesh modularization, LOD distance limits, texture downsampling, triangle culling.
   - *Engineering Ownership:* Automated headless performance profiling, draw call monitoring, frame-time verification scripts in `tests/run_tests.gd`.
3. **Contract `DEP-A-B-03`: World Streaming & Occlusion Culling**
   - *Visual Ownership:* Interior/exterior boundary placement, structural occluder placement (thick walls, tunnels, portals).
   - *Engineering Ownership:* Chunk loading/unloading logic (`systems/world/`), `OccluderInstance3D` baking, visibility range node management.
4. **Contract `DEP-A-B-04`: 3D Evidence Interaction Rig**
   - *Visual Ownership:* Transform anchors, rotation limits, material highlight shader for interactive props.
   - *Engineering Ownership:* `evidence_manager.gd`, mouse-drag rotation math, UI inspect overlay.

### 5.2 Department C (Autonomous AI Studio) Interface Contracts
1. **Contract `DEP-A-C-01`: Generative 3D Mesh Ingestion Pipeline**
   - *Visual Ownership:* Aesthetic style prompts, poly budgets (≤1,500 tris), GLB mesh validation rules.
   - *AI Studio Ownership:* Agent tool wrapper for Meshy/Tripo API, automated CLI download, format verification.
2. **Contract `DEP-A-C-02`: Automated Image Downsampling & Packing Script**
   - *Visual Ownership:* PIL channel-packing logic (ORM: R=AO, G=Roughness, B=Metallic) and resolution downsampling (1024/512).
   - *AI Studio Ownership:* Python script integration into the agent execution harness, automated pre-commit hook execution.
3. **Contract `DEP-A-C-03`: Visual Reviewer Automated Quality Gates**
   - *Visual Ownership:* Rubric for grading aesthetic coherence, grit, historical plausibility, and material realism.
   - *AI Studio Ownership:* Dedicated reviewer subagent prompt architecture, structured output scoring schema.

---

## 6. DEPARTMENT WORKFLOW & DELIVERY PHASES

Department A operates across six synchronized project waves:

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                 DEPARTMENT A: PRODUCTION WAVE SCHEDULE                      │
├────────┬──────────────────────────────────┬─────────────────────────────────┤
│ Wave   │ Title                            │ Department A Scope              │
├────────┼──────────────────────────────────┼─────────────────────────────────┤
│ Wave 1 │ Department Setup & Outline       │ Charter & Bible Outline locked. │
│ Wave 2 │ Specialist Research & Findings   │ Specialists A1–A6 generate      │
│        │                                  │ technical specifications.       │
│ Wave 3 │ Cross-Department Alignment       │ Resolve camera, VRAM, and       │
│        │                                  │ streaming contracts with B & C. │
│ Wave 4 │ Book 02 Drafting & Assembly      │ Consolidate full Book 02 Bible. │
│ Wave 5 │ Independent Quality Audit        │ Specialist A7 executes budget   │
│        │                                  │ and aesthetic compliance audit. │
│ Wave 6 │ Final Production Packaging       │ Deliver Book 02 into Master     │
│        │                                  │ Project Control archive.        │
└────────┴──────────────────────────────────┴─────────────────────────────────┘
```

---

## 7. APPROVAL & GOVERNANCE SIGN-OFF

This Department Charter establishes the authoritative operating parameters for Department A. No visual asset, shader, mesh, or camera setup may be committed to the project without satisfying the criteria documented herein.

- **Charter Author:** Visual Production Director (`6f7de551-99ee-49bf-80bb-8413af5bcb84`)
- **Status:** APPROVED & ACTIVE FOR WAVE 1 EXECUTION
- **Next Step:** Generate `02_VISUAL_PRODUCTION_BIBLE_OUTLINE.md` and report to Production Director.
