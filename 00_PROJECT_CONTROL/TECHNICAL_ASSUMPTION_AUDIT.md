# PROJECT NULL — TECHNICAL ASSUMPTION AUDIT & EVIDENCE STANDARDS
**Document ID:** PNL-AUDIT-001  
**Authority:** Creative Director & Technical Director  
**Author:** Production Director (Lead Production Agent)  
**Date:** 2026-11-05  
**Status:** BINDING DIRECTIVE FOR ALL DEPARTMENTS & SPECIALISTS

---

## 1. PURPOSE & MANDATORY EVIDENCE CLASSIFICATION

This document establishes the verified technical baseline for Phase 2 production across Department A (Visual Production), Department B (Game Engineering), and Department C (Autonomous AI Studio). 

Every technical specification, architectural decision, and budget recommendation in Books 02, 03, and 04 must carry one of the following five standardized certainty classifications:

```
┌──────────────────────────────────────────────────────────────────────────────────────────┐
│                             EVIDENCE CLASSIFICATION TAXONOMY                             │
├──────────────────────────────┬───────────────────────────────────────────────────────────┤
│ Classification Tag           │ Standard & Justification Requirement                      │
├──────────────────────────────┼───────────────────────────────────────────────────────────┤
│ [Verified Capability]        │ Confirmed by functional CLI test, engine probe, or code   │
│                              │ execution on the active development environment.          │
├──────────────────────────────┼───────────────────────────────────────────────────────────┤
│ [Measured Result]            │ Quantified data derived from an explicit benchmark test,  │
│                              │ recording hardware environment, tool, and methodology.    │
├──────────────────────────────┼───────────────────────────────────────────────────────────┤
│ [Engineering Estimate]       │ First-principles calculation or industry-standard derived │
│                              │ estimate with explicit mathematical formulas and bounds.  │
├──────────────────────────────┼───────────────────────────────────────────────────────────┤
│ [Design Recommendation]      │ Creative, visual, or architectural guideline proposed to  │
│                              │ fulfill aesthetic, gameplay, or orchestration goals.      │
├──────────────────────────────┼───────────────────────────────────────────────────────────┤
│ [Unverified Assumption]      │ Provisional target or working hypothesis requiring       │
│                              │ empirical verification during testing before release.     │
└──────────────────────────────┴───────────────────────────────────────────────────────────┘
```

---

## 2. AUDIT & CORRECTION OF FIVE CORE TECHNICAL ASSUMPTIONS

### 2.1 Assumption A: ORM Texture Packing & VRAM Reality
- **Previous Unverified Claim:** *"Packing AO, Roughness, and Metallic into an RGB texture automatically saves 66% VRAM."*
- **Technical Correction & Reality [Engineering Estimate / Design Recommendation]:**
  - **Memory Footprint Reality:** In desktop OpenGL 3.3 on the GeForce G210, textures are compressed via S3TC/DXT. 
    - Retain ORM packing as a **recommended material workflow**.
    - One packed texture reduces texture sampler bindings from 3 slots to **exactly 1 sampler slot**, which is critical on OpenGL 3.3 where hardware sampler units are strictly limited (typically 16).
    - **Do NOT claim that ORM packing automatically reduces raw texture memory by 66%.** In reality, compression, cache behaviour, and performance depend directly on GPU format support, texture dimensions, channel bit-depth, and runtime workload.
    - If packed as BC1 (DXT1, RGB without alpha), the memory footprint is 4 bits per pixel (bpp). If imported as BC3 (DXT5, RGBA) or uncompressed, the memory footprint increases to 8 bpp or 24 bpp.
    - Supported compression formats must be verified on the target G210 hardware.
    - **No performance or bandwidth gains may be asserted as factual without empirical benchmark measurements.**

---

### 2.2 Assumption B: GPU & VRAM Memory Budgets
- **Previous Unverified Claim:** *"Target 750 MB scene VRAM budget universally across the game as a validated limit."*
- **Technical Correction & Reality [Unverified Assumption — Provisional Scene-Memory Budget]:**
  - The proposed **750 MB scene ceiling is a planning target and working hypothesis, NOT a verified hardware limit.**
  - **Hardware Envelope:** NVIDIA GeForce G210 possesses exactly **1,024 MB physical DDR3 VRAM** on a 64-bit bus.
  - **Driver & OS Overhead:** On Windows 10/11 x86_64, the Desktop Window Manager (DWM), display driver context, and OpenGL runtime consume an estimated **150 MB to 250 MB of VRAM** before the game renders a single frame.
  - **Measurement Mandate:** Department B (Game Engineering) must define and execute an explicit measurement methodology:
    1. Tracking render target and framebuffer allocations at 1280x720 native.
    2. Shadow map buffer allocation (single directional light at 1024x1024).
    3. Vertex buffer object (VBO) and index buffer object (IBO) geometry allocations.
    4. Compressed texture VRAM residency.
    5. Driver-level private allocations via OS performance counters.
  - **Validation Status:** This budget must **NOT be declared validated** until a representative, populated Godot scene (with terrain, modular architecture, lighting, and an active character) has been benchmarked under live execution on the actual GeForce G210 hardware in `08_TESTING/`.

```
┌──────────────────────────────────────────────────────────────────────────────────────────┐
│                    PROVISIONAL VRAM PLANNING BUDGETS [Unverified Target]                 │
├───────────────────┬──────────────┬──────────────┬─────────────┬──────────────────────────┤
│ Scene Category    │ Max Texture  │ Geometry /   │ Render /    │ Total Target VRAM        │
│                   │ Memory (MB)  │ VBO Buffers  │ Shadow Maps │ (Including OS Overhead)  │
├───────────────────┼──────────────┼──────────────┼─────────────┼──────────────────────────┤
│ Tier 1: UI / Menu │ ≤ 80 MB      │ ≤ 15 MB      │ ≤ 45 MB     │ ≤ 350 MB (Provisional)   │
│ Tier 2: Interior  │ ≤ 220 MB     │ ≤ 45 MB      │ ≤ 85 MB     │ ≤ 550 MB (Provisional)   │
│ Tier 3: Exterior  │ ≤ 380 MB     │ ≤ 110 MB     │ ≤ 110 MB    │ ≤ 750 MB (Provisional)   │
└───────────────────┴──────────────┴──────────────┴─────────────┴──────────────────────────┘
```

---

### 2.3 Assumption C: Asset Triangle & Geometry Budgets
- **Previous Unverified Claim:** *"Universal 1,500-triangle restriction for all 3D assets."*
- **Technical Correction & Reality [Design Recommendation / Engineering Starting Point]:**
  - Category polygon ranges are **useful starting points, NOT immutable universal limits.**
  - Every asset category budget must dynamically account for six critical rendering factors:
    1. **LOD Level & Transition Distance:** Geometric reduction curves (LOD0 at 0–10m, LOD1 at 10–30m, LOD2/culling beyond 30m).
    2. **Screen-Space Coverage:** Maximum percentage of screen pixels occupied by the asset at standard camera distance.
    3. **Material & Draw-Call Cost:** Strictly 1 material per prop wherever possible. A 500-poly prop with 3 materials is far more expensive on the G210 than a 2,000-poly prop with 1 material.
    4. **Silhouette Importance:** Preserving distinctive edge silhouettes on primary narrative figures and landmark architecture while aggressively decimating interior planar surfaces.
    5. **Animation & Deformation Requirements:** Articulation loops on deforming meshes (knees, elbows, coat hems) versus static rigid environmental geometry.
    6. **Instance Count & Spatial Visibility:** Singleton hero items (e.g. Black Registry, Escapement Clock) versus high-count repeated items (e.g. railway ties, streetlamps) which must use `MultiMeshInstance3D`.
  - **Revision & Benchmarking Method:** Polygon budgets will be empirically adjusted by Department B by rendering scenes with escalating mesh counts until vertex shader bound thresholds are reached in the compatibility renderer.

```
┌──────────────────────────────────────────────────────────────────────────────────────────┐
│                     PROVISIONAL CATEGORY POLYGON BUDGET RANGES                           │
├──────────────────────────────┬──────────────┬──────────────┬─────────────┬───────────────┤
│ Asset Category               │ LOD0 (Tris)  │ LOD1 (Tris)  │ Max Mats    │ Max Texture   │
├──────────────────────────────┼──────────────┼──────────────┼─────────────┼───────────────┤
│ Primary Characters (Thomas)  │ 3,500–5,000  │ 1,500–2,000  │ 2 Materials │ 1024x1024     │
│ Secondary NPCs / Witnesses   │ 2,000–3,000  │ 1,000–1,500  │ 1 Material  │ 512x512       │
│ Hero Interactive Props       │ 1,200–2,500  │ 500–800      │ 1 Material  │ 512x512       │
│ Ordinary Environment Props   │ 250–800      │ 100–250      │ 1 Material  │ 512x512       │
│ Modular Architecture Panels  │ 100–400      │ 50–100       │ 1 (Shared)  │ Trim Sheet 1K │
│ Vegetation & Debris Clusters │ 100–350      │ 30–80        │ 1 (Shared)  │ 256x256       │
│ Distant Backdrop Geometry    │ 200–600      │ N/A          │ 1 Material  │ 256x256       │
└──────────────────────────────┴──────────────┴──────────────┴─────────────┴───────────────┘
```

---

### 2.4 Assumption D: Character Rendering Hierarchy & Requirements
- **Previous Unverified Assumption:** *"Every named story character requires a continuously rendered, fully animated NPC model."*
- **Technical Correction & Reality [Design Recommendation]:**
  - Named story characters have vastly distinct staging and gameplay requirements. Attempting to maintain skeletal rigs and animation trees for all named figures will overwhelm the G210's 16 CUDA cores and draw call limits.
  - **Five-Tier Character Rendering Hierarchy:**
    1. **Tier 1: Hero Playable / Core Companion (Thomas Mercer, Elena Mercer):** Continuously rendered, dual-mode camera support (1st/3rd person), full skeletal rig, subtle limping gait cycles, dedicated inspection zoom framing.
    2. **Tier 2: Key Interactive NPCs (Janos Vance, Konrad Hess, Aldous Vane):** Staged only in specific narrative scenes/rooms, conversational idle blend trees, seated/standing scripted positions, strictly culled when the player departs the conversation zone.
    3. **Tier 3: Ambient Witnesses & Sector Passersby (Station commuters, foundry shift workers):** Simplified skeletal rigs (15-20 bones max), shared instanced textures, distance-culled beyond 15 meters, simple looping path-follow locomotion.
    4. **Tier 4: Distant Silhouettes (Guards along Over-Slab, crane operators):** Low-poly 2.5D animated billboard quads or ultra-low vertex meshes (100–250 tris) with baked silhouette lighting, zero bone rigging.
    5. **Tier 5: Archival / Static Corpse / Environmental Presence (Josef Lind, historical figures):** Static rigid meshes or photographs/dossier portraits without animator or skeletal tree overhead.

---

### 2.5 Assumption E: Strict Blender-Free Pipeline & Practical Ingestion Route
- **Mandate Reaffirmation [Design Requirement]:**
  - The prohibition against Blender remains **absolute and unconditional.** No `.blend` files, Blender Python scripts, or Blender-dependent DCC pipelines may be introduced.
  - Every proposed asset workflow must have a **concrete, automated, and lightweight ingestion route** into Godot:
    1. **Terrain & Architecture:** Godot native CSG primitives (`CSGBox3D`, `CSGPolygon3D`) combined into modular `.tscn` prefabs, converted to static mesh resources via Godot's built-in CSG mesher.
    2. **Materials & Textures:** Sourced from Poly Haven (CC0 1K/2K PNG/JPG) or generated via texturing tools, downsampled and ORM-packed via standalone Python scripts using Pillow (`PIL.Image`).
    3. **Hero & Minor Props:** Generated via Meshy / Tripo AI directly to binary glTF (`.glb`), inspected via standalone Python `struct`/`json` validation scripts (`inspect_glb.py`), and imported directly into Godot Compatibility materials.
    4. **Inspection & Verification:** Headless Godot validation scripts executed via Windows PowerShell CLI.

---

### 2.6 Assumption F: Train Implementation — Narrative Canon vs. Runtime Physics
- **Previous Unverified Claim:** *"Locomotive #884 ascent requires full multi-body dynamic physics simulation of tractive stiction and cylinder strokes in Godot."*
- **Technical Correction & Reality [Engineering Architecture]:**
  - **Narrative vs. Runtime Separation:**
    - The mathematical calculations in Book 01 ($53.32\text{ kN}$ breakout effort, $35.16\text{ kN}$ running resistance, $110.4\text{ kN}$ damp adhesion, $9.53\text{ MJ}$ kinetic energy) establish the **objective narrative canon and thematic verisimilitude** of the universe.
    - They are NOT runtime game-physics requirements. Attempting to simulate a 10-coupled driving axle reciprocating steam engine with slip-curve integrators on the G210 CPU/GPU wastes engineering cycles and introduces gameplay instability.
  - **Runtime Implementation Specification:**
    1. **Ascent Traversal:** Implemented via a smoothed **Kinematic / PathFollow3D spline**. Speed is governed by a state machine linked to player cab interactions (injector valve, blower, regulator lever).
    2. **Tractive Sensation & Slip:** Communicated through audio-visual feedback (wheel-slip sound fx, procedural camera shake, particle steam bursts, and cab pressure gauges) rather than rigid-body tire-rail friction simulation.
    3. **Platform 2 Collision (Ending B):** Handled as a choreographed cinematic sequence combining pre-fractured CSG mesh triggers, rigid-body debris impulses, screen shake, and blinding steam particle occlusion over the canonical $40 - 50\text{ meter}$ deceleration zone.

---

### 2.7 Assumption G: Low-Frequency Audio & 18.4 Hz Lore Realism
- **Previous Unverified Claim:** *"Infrasound turbines at 18.4 Hz directly delete human memories and must be simulated as raw 18.4 Hz audio."*
- **Technical Correction & Reality [Audio Engineering / Lore]:**
  - **Acoustic Physics:** An $18.4\text{ Hz}$ sine wave is beneath the lower threshold of human hearing ($20\text{ Hz}$) and cannot be physically reproduced by ordinary desktop computer speakers, television sets, or consumer headphones, which sharply roll off below $45\text{ to }50\text{ Hz}$. Emitting raw sub-audible frequencies merely causes voice-coil clipping and distortion without producing audible sound.
  - **Sound Design Strategy:**
    1. **Psychoacoustic Harmonics:** The 18.4 Hz turbine hum must be conveyed through musical and acoustic overtones at the 2nd harmonic ($36.8\text{ Hz}$), 3rd harmonic ($55.2\text{ Hz}$), 4th harmonic ($73.6\text{ Hz}$), and 6th harmonic ($110.4\text{ Hz}$), creating a resonant, chest-rattling drone that is audible across standard stereo hardware.
    2. **Haptic & Visual Transduction:** Physical camera micro-jitter, rattling light fixtures, and subtle vibrating screen shaders represent the physical standing wave.
  - **Thematic Integrity:** Adhere strictly to Book 01 canon: the infrasound does not magically erase synapses; it induces chronic cognitive fatigue, headaches, tinnitus, and docility, lowering psychological resistance to administrative erasure and bureaucratic consensus.

---

## 3. IMPLEMENTATION MANDATE

All specialists across Departments A, B, and C must cite this document and verify their deliverable chapters against these corrected standards. Any document incorporating disproven assumptions (e.g. "66% VRAM magic savings" or "raw 18.4 Hz audio erasing brains") will be rejected at the Wave 5 Quality Gate.