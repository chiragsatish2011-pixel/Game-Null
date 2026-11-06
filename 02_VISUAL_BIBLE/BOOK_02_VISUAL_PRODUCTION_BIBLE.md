# PROJECT NULL — BOOK 02: THE VISUAL PRODUCTION BIBLE
**Document ID:** PNL-BIBLE-002  
**Classification:** Authoritative Technical Art, Aesthetic Direction & Visual Engineering Specification  
**Version:** 2.0.0 (Consolidated Wave 2 Edition)  
**Date:** 2026-11-05  
**Authorities:** Visual Production Director (`6f7de551-99ee-49bf-80bb-8413af5bcb84`), Lead Technical Director & Creative Director  
**Gating Reviewer:** Specialist A7 (Visual Quality & Technical Art Reviewer — Certified in `PNL-AUDIT-A7-FINAL-001`)  
**Target Engine:** Godot Engine 4.7.2 Stable (`gl_compatibility` / OpenGL 3.3 Core Profile)  
**Target Hardware Baseline:** Intel Core i5-12400F | 16 GB DDR4 RAM | NVIDIA GeForce G210 (1024 MB DDR3 VRAM, 64-bit bus, PCIe 2.0)  

---

## EXECUTIVE TABLE OF CONTENTS
1. [Visual Department Charter & Core Aesthetic Axioms](#1-visual-department-charter--core-aesthetic-axioms)
2. [Environmental Art Architecture & Regional Landscapes](#2-environmental-art-architecture--regional-landscapes)
3. [Character Art Direction, Costume Architecture & Skeletal Rigs](#3-character-art-direction-costume-architecture--skeletal-rigs)
4. [Industrial Mechanisms, Signal Props & Artifact Design](#4-industrial-mechanisms-signal-props--artifact-design)
5. [PBR Material Standards, Atlas Budgets & Compatibility Lighting](#5-pbr-material-standards-atlas-budgets--compatibility-lighting)
6. [Traversal Animation, Dual 1st/3rd Camera Rig & Cinematics](#6-traversal-animation-dual-1st3rd-camera-rig--cinematics)
7. [Strict Blender-Free Asset Sourcing, Downsampling & CSG Pipeline](#7-strict-blender-free-asset-sourcing-downsampling--csg-pipeline)
8. [Hardware Compliance, Draw-Call Accounting & VRAM Budgets](#8-hardware-compliance-draw-call-accounting--vram-budgets)
9. [Cross-Department Ratification & Master Quality Sign-Off](#9-cross-department-ratification--master-quality-sign-off)

---

## 1. VISUAL DEPARTMENT CHARTER & CORE AESTHETIC AXIOMS

### 1.1 The Aesthetic Thesis: Tactile Bureaucratic Decay
Project NULL avoids generic post-apocalyptic tropes and neon sci-fi exaggeration. Its visual thesis is **tactile bureaucratic decay**: an alternate Eastern/Central European late-20th-century reality where totalitarian industrial systems reached an apex of administrative and architectural control, and are now quietly freezing into neglected obsolescence.

```text
┌────────────────────────────────────────────────────────────────────────────────────────┐
│                              THE VISUAL POLARITY MATRIX                                │
├───────────────────────────────────┬────────────────────────────────────────────────────┤
│ WHAT PROJECT NULL IS              │ WHAT PROJECT NULL STRICTLY IS NOT                  │
├───────────────────────────────────┼────────────────────────────────────────────────────┤
│ • Heavy cast iron, damp stone,    │ • No glowing sci-fi holograms, cybernetic implants,│
│   leaded glass, oxidised bronze   │   or fluorescent laser tripwires.                  │
│ • Desaturated, cold, overcast,    │ • No vivid high-saturation fantasy environments    │
│   leaden skies with coal soot     │   or chromatic hyper-stylized lighting.            │
│ • Grounded mechanical logic:      │ • No magical floating architecture or supernatural │
│   visible linkages, levers, cams  │   glowing glyphs.                                  │
│ • Architectural weight & mass:    │ • No flimsy hollow cardboard structures or         │
│   thick masonry, massive caissons │   unsupported floating geometry.                   │
│ • 1970s–1990s analog state craft: │ • No contemporary smartphones, flat OLED panels,   │
│   rotary dials, thermal printouts │   or high-speed wireless digital devices.          │
└───────────────────────────────────┴────────────────────────────────────────────────────┘
```

### 1.2 The Color & Tonal System
- **Dominant Palette:** Deep graphite (`#1E2224`), wet ballast gray (`#3A3E40`), tarnished brass (`#7A6A48`), oxidized iron rust (`#6E3A2B`), and archival parchment beige (`#C8BEA7`).
- **Accent Palette:** Cold sodium-vapor amber (`#D89030`), rail signal crimson (`#A32822`), dull phosphorescent gauge green (`#4A6B52`), and Elena's rescue cylinder enameled dark olive (`#2D382E`).
- **Exposure & Tonemapping:** Linear Reinhard tonemapping in Godot 4.7.2 `gl_compatibility` mode, calibrated to suppress specular highlight blowout while preserving deep shadow fidelity without crushed blacks.

---

## 2. ENVIRONMENTAL ART ARCHITECTURE & REGIONAL LANDSCAPES

### 2.1 Regional Environmental Profiles
Visual production is structured into four distinct environmental regions specified by Specialist A1:

```text
┌─────────────────────────────────────────────────────────────────────────────────────────────────┐
│                                   REGIONAL ARCHITECTURAL DIRECTORY                              │
├──────────────────┬────────────────────────────┬─────────────────────────────────────────────────┤
│ Region           │ Architectural Archetype    │ Key Visual Motifs & Silhouette Dominance        │
├──────────────────┼────────────────────────────┼─────────────────────────────────────────────────┤
│ District 01:     │ Interwar Austro-Hungarian  │ Soot-blackened ashlar limestone, arched railway │
│ Vesper Urban Core│ Municipal / Heavy Rail     │ viaducts, damp cobblestones, overhead catenary  │
├──────────────────┼────────────────────────────┼─────────────────────────────────────────────────┤
│ District 09:     │ 1960s Socialist Brutalism  │ Board-formed concrete caissons, monolithic      │
│ The Sunken Ward  │ & Cavernous Infrastructure │ load-bearing pylons, 4.2M m³ Quarry Pit 03 slab │
├──────────────────┼────────────────────────────┼─────────────────────────────────────────────────┤
│ The Deep Tiers:  │ Subterranean Karst &       │ Natural dripping limestone strata, reinforced   │
│ Tiers 1–3        │ Industrial Mining Vaults   │ I-beams, ventilation bulkheads, flooded sumps   │
├──────────────────┼────────────────────────────┼─────────────────────────────────────────────────┤
│ The Outside:     │ Coastal Salt Marsh &       │ Desolate granite bluffs, wind-swept reeds,      │
│ Km 14 to Km 20   │ Sub-Arctic Coastal Plain   │ rusting narrow-gauge rails, weathered dyke huts │
└──────────────────┴────────────────────────────┴─────────────────────────────────────────────────┘
```

### 2.2 Modular Architecture Grid & Geometry Rules
1. **The 0.5-Meter Spatial Cadence:** All walls, floor tiles, platform copings, and street curbs conform to strict modular increments of $0.5\text{ m}$, $1.0\text{ m}$, $2.0\text{ m}$, and $4.0\text{ m}$.
2. **Modular Structural Polygon Limits:**
   - Standard Wall Section ($4\text{m} \times 3\text{m}$): $\le 120$ triangles.
   - Arched Viaduct Pillar ($2\text{m} \times 8\text{m}$): $\le 350$ triangles.
   - Ground Cobblestone Chunk ($8\text{m} \times 8\text{m}$ planar mesh): $\le 64$ triangles.
   - Heavy Iron Shunting Pylon: $\le 450$ triangles.
3. **ArrayMesh Baking Mandate:** Godot CSG primitives (`CSGBox3D`, `CSGPolygon3D`) are strictly limited to early blockouts. Prior to inclusion in level scenes, all CSG assemblies must be programmatically baked into static `ArrayMesh` resources via automated pipeline scripts to eliminate runtime CSG evaluation penalties.

---

## 3. CHARACTER ART DIRECTION, COSTUME ARCHITECTURE & SKELETAL RIGS

### 3.1 5-Tier Character Rendering Hierarchy (**DEC-0033**)
To respect the strict DDR3 memory bandwidth and vertex pipeline limits of the NVIDIA GeForce G210, character models are categorized into five distinct rendering tiers:

```text
┌───────┬──────────────────────┬─────────────┬──────────────┬───────────────┬───────────────────────────────┐
│ Tier  │ Category             │ Triangle Cap│ Max Materials│ Max Bones     │ Facial Deformation Method     │
├───────┼──────────────────────┼─────────────┼──────────────┼───────────────┼───────────────────────────────┤
│ 1     │ Hero (Thomas Mercer) │ 5,000       │ 1 (ORM Atlas)│ 48 Body+6 Face│ 8-bone skeletal + 2 morphs    │
│ 2     │ Key NPCs (Elena,etc) │ 3,500–4,200 │ 1 (ORM Atlas)│ 48 Body+6 Face│ 8-bone skeletal sub-rig       │
│ 3     │ Ambient Witnesses    │ 1,800–2,500 │ 1 (Shared)   │ 32 Bones      │ Low-poly head / static jaw    │
│ 4     │ Distant Silhouettes  │ 600–900     │ 1 (Shared)   │ 18 Bones      │ Static vertex mesh            │
│ 5     │ Static / Archival    │ 250–500     │ 1 (Shared)   │ 0 (Rigid Mesh)│ None                          │
└───────┴──────────────────────┴─────────────┴──────────────┴───────────────┴───────────────────────────────┘
```

### 3.2 Canonical Character Specifications & Synchronized Ages
- **Thomas Mercer (Protagonist):**
  - **Age:** 56 years, 7 months (DOB March 12, 1948; Present: October 19, 2004).
  - **Visual Language:** Exhausted, weather-beaten former railway draughtsman. Wears a heavy charcoal wool overcoat with salt-stained cuffs, frayed woolen scarf, steel-rimmed spectacles, and scarred leather ankle boots.
  - **The Limp:** Pronounced right-leg antalgic gait caused by an unreduced malleolar fracture sustained in the 1968 Settlement collapse.
- **Elena Mercer (Daughter & Co-Investigator):**
  - **Age:** 26 years, 2 months (DOB August 19, 1978).
  - **Condition & Presentation (V3.4 Synchronized):** Acute chemical smoke inhalation, purulent bronchitis, and hypothermia. Seriously ill, tachypneic, and feverish, but alert and conscious.
  - **Hero Medical Equipment:** Low-flow medical-grade nasal cannula connected to dual 10L rescue cylinders at $1.8\text{ L/min}$ continuous flow. Strictly NO theatrical high-flow reservoir masks.
- **Inspector Janos Vance:**
  - **Age:** 61 years old (DOB January 4, 1943). Bureau 4 senior interrogator. Heavy trench coat, nicotinic finger stains, worn leather docket folio.
- **Master Bookbinder Konrad Hess:**
  - **Age:** 72 years old (DOB September 14, 1932). Custodian of the Black Registry. Apron stiffened with bone-glue and printer's ink, cataract-dulled left iris.

### 3.3 The Canonical Hybrid Facial Rig (**DEF-A7-002 / R-02 Resolved**)
Godot 4.7.2's Compatibility Renderer relies on OpenGL 3.3 Core `GL_TRANSFORM_FEEDBACK` for blend shapes, inducing severe GPU-CPU synchronization stalls when $> 2$ targets deform simultaneously.
- **Skeletal Facial Sub-Rig (Zero VRAM Write-Back):** 8 dedicated bones parented to `Head_Root`:
  - `Bone_Jaw_Root` (speech phonemes & mouth drop)
  - `Bone_Lip_Upper`, `Bone_Lip_Lower` (phoneme shaping)
  - `Bone_Lip_Corner_L`, `Bone_Lip_Corner_R` (grimace, smile, sorrow)
  - `Bone_Brow_L`, `Bone_Brow_R` (skeptical raise, anger)
  - `Bone_Eyelid_Master` (blink cycles)
- **Controlled Blend Shapes:** Exactly two morph targets (`Morph_Brow_Furrow`, `Morph_Brow_Raise`) authored on a single head surface mesh, evaluated strictly when the camera is $< 2.5\text{ m}$ from the subject.

---

## 4. INDUSTRIAL MECHANISMS, SIGNAL PROPS & ARTIFACT DESIGN

### 4.1 Prop Category Budgets & Material Slot Rules
Props are strictly classified into geometric and textural budgets:
- **Hero Inspectable Props:** $1,200\text{--}2,200$ triangles; 1 dedicated $1024\times 1024$ ORM material (or partitioned into shared bureau atlas).
- **Secondary World Clues:** $400\text{--}800$ triangles; bound to regional prop atlas.
- **Environmental Clutter:** $100\text{--}350$ triangles; batched via `MultiMeshInstance3D`.

### 4.2 Key Hero Props Directory

```text
┌──────────────┬────────────────────────────────────┬───────────┬──────────────────────────────────────────┐
│ Prop ID      │ Description                        │ Triangles │ Mechanical & Forensic Highlights         │
├──────────────┼────────────────────────────────────┼───────────┼──────────────────────────────────────────┤
│ PROP-HERO-01 │ Dispatch Order #14                 │ 64        │ Lead-sheet carbon folio, 1968 seal       │
│ PROP-HERO-02 │ Black Registry Volume I & II       │ 1,480     │ Oak-board binding, brass locking hasps   │
│ PROP-HERO-03 │ Master Regulator Clock (Station)   │ 1,840     │ Graham deadbeat escapement, mercury bob  │
│ PROP-HERO-04 │ Siemens & Halske Teletype Terminal │ 2,150     │ 5-bit Baudot paper tape punch, bakelite  │
│ PROP-HERO-05 │ Invar Tensioned Chaining Apparatus │ 1,220     │ Nickel-steel alloy tape, counter-weights │
│ PROP-HERO-06 │ Class 52 Reverser & Brake Column   │ 1,980     │ Cast bronze screw handle, Bourdon gauge  │
│ PROP-HERO-07 │ Rotary Telephony Intercom Hub      │ 1,420     │ Spring-wound mechanical ringer, 10 lines │
│ PROP-HERO-08 │ 10L Rescue Oxygen Cylinders &      │ 1,650     │ 34CrMo4 steel twin 10L cyls @ 150 bar,   │
│              │ Low-Flow Nasal Cannula Apparatus   │           │ 1.8 L/min detent flowmeter, 239L margin  │
└──────────────┴────────────────────────────────────┴───────────┴──────────────────────────────────────────┘
```

### 4.3 Technical Art Rules for Inspection Props (**DEF-A7-005 Resolved**)
1. **Opaque Reflection Approximation for Dial Glass:** Ordinary gauges and lanterns use high specular reflectivity ($0.90$) and ultra-low roughness ($0.05\text{--}0.12$) with baked environment maps, keeping 100% of geometry in the opaque raster pass.
2. **Decoupled Child Quad for Glass Examination Panels:** Where internal mechanisms must be examined (e.g., `PROP-HERO-03` Master Clock escapement), the solid walnut case and escapement reside in Material Slot 1 (Opaque). The front glass pane is authored as an independent 2-triangle planar child quad (`MeshInstance3D`) with transparency, eliminating alpha-sorting depth-thrashing.

---

## 5. PBR MATERIAL STANDARDS, ATLAS BUDGETS & COMPATIBILITY LIGHTING

### 5.1 ORM Channel Packing Protocol (**DEC-0031 / DEC-0033**)
Under OpenGL 3.3 Core Profile on the GeForce G210, binding multiple independent 2D texture samplers per surface saturates hardware texture units and induces pipeline stalls. All PBR materials utilize 3-channel ORM packing:
- **Red (R):** Ambient Occlusion (AO)
- **Green (G):** Roughness (0.0 = mirror, 1.0 = matte)
- **Blue (B):** Metallic (0.0 = dielectric, 1.0 = metal)

```text
┌─────────────────────────────────────────────────────────────────────────────┐
│                       ORM PACKING MEMORY & SAMPLER SAVINGS                  │
├──────────────────────┬────────────────────────┬─────────────────────────────┤
│ Metric               │ Unpacked (3 Textures)  │ Packed ORM (1 Texture)      │
├──────────────────────┼────────────────────────┼─────────────────────────────┤
│ Active Sampler Slots │ 3 texture unit slots   │ Exactly 1 texture unit slot │
│ GPU Texture Fetches  │ 3 distinct memory reads│ Exactly 1 composite fetch   │
│ Memory Cache Lines   │ 3 cache-line sweeps    │ 1 unified cache-line sweep  │
└──────────────────────┴────────────────────────┴─────────────────────────────┘
```

### 5.2 Regional Texture Atlas Architecture
To guarantee that active scene textures fit strictly within the provisional 750 MB VRAM ceiling:
- **Maximum Resolution Ceiling:** Strictly $1024\times 1024$ for architectural surfaces and hero props; $512\times 512$ for regional props. Zero 2K/4K textures.
- **Texture Compression:** VRAM-compressed via Godot's built-in S3TC/DXT5 (`bptc` disabled for OpenGL 3.3 Compatibility).

### 5.3 Compatibility Renderer Lighting Invariants
1. **Single Directional Light:** Exactly 1 `DirectionalLight3D` with shadow casting enabled per scene.
2. **Shadow Map Resolution:** Capped strictly at $1024\times 1024$ with 2-split PSSM (Parallel Split Shadow Maps).
3. **OmniLight3D & SpotLight3D Rules:**
   - Maximum 4 active Omni/Spot lights per camera frustum.
   - **Shadows DISABLED on all omni and spot lights** (`shadow_enabled = false`). Real-time point light shadows on the G210 require 6 shadow passes per cube map, which immediately crashes frame rates.
   - Subtle localized lighting is simulated using pre-baked vertex lighting or additive unshaded dust volumes.

---

## 6. TRAVERSAL ANIMATION, DUAL 1ST/3RD CAMERA RIG & CINEMATICS

### 6.1 Dual-Mode Camera Rig Architecture
- **Camera Mount:** Rigged to `GaitPivot/CameraMount` on the player character.
- **First-Person Mode:** SpringArm length $= 0.0\text{ m}$; camera positioned at eye level ($y = 1.65\text{ m}$).
- **Third-Person Mode:** SpringArm length $= 2.4\text{ m}$; collision mask strictly bound to Layer 1 (`World_Static` ONLY) to eliminate nausea-inducing pops against dynamic chairs or NPCs.
- **Unblocked Mode Switching:** Camera mode toggling between 1st and 3rd person remains 100% active during dialogue or inspection modes.

### 6.2 Thomas's Phenomenological Limp Specification (**DEF-A7-004 Resolved**)
Rather than an exaggerated video-game limp, Thomas's gait is mathematically grounded:
- **Right Knee Flexion Limit:** Hard anatomical stop at $35.0^\circ$ (reflecting post-traumatic osteoarthritic ankylosis).
- **Stance Phase Timing:** Left (healthy) stance $= 0.55\text{ s}$; Right (injured) stance $= 0.35\text{ s}$ (rapid weight offloading).
- **Procedural Trunk Drop:** Peak vertical drop of $-0.048\text{ m}$ during right heel-strike, accompanied by a subtle $3.2^\circ$ rightward coronal roll.

---

## 7. STRICT BLENDER-FREE ASSET SOURCING, DOWNSAMPLING & CSG PIPELINE

### 7.1 The Blender-Free Imperative (**DEC-0002**)
Project NULL operates without Blender (`.blend` files, headless `bpy` CLI scripts, or manual DCC software). The visual pipeline is 100% programmatic and headless:
1. **Source Sourcing:** Poly Haven CC0 textures and architectural models.
2. **Generative 3D Mesh APIs:** Meshy API and Tripo AI API for period-accurate mechanical props.
3. **Automated Python Processing:**
   - `07_ASSETS/scripts/inspect_glb.py`: GLB chunk header validator, mode==4 primitive checker, triangle budget gate.
   - `07_ASSETS/scripts/pack_orm.py`: Pillow-based 3-channel ORM channel packer with Lanczos downsampling.
   - `07_ASSETS/scripts/generate_collision.py`: Automated AABB box/cylinder collision shape generator.
4. **Godot CSG Grayboxing:** Modular assembly in Godot, followed by script-driven `ArrayMesh` baking.

---

## 8. HARDWARE COMPLIANCE, DRAW-CALL ACCOUNTING & VRAM BUDGETS

### 8.1 MultiMesh Draw-Call Accounting (**DEF-A7-001 / R-01 Resolved**)
Naïve claims that MultiMeshInstance3D collapses any scene into single-digit draw calls were disproved in Wave 2 auditing. Real-world draw calls in Godot 4.7.2 Compatibility mode follow the strict equation:

$$\text{DrawCalls} = \sum_{m \in \text{Meshes}} S_m \times (1 + N_{\text{shadow\_splits}}) + \sum_{l \in \text{Lights}} \text{Passes}_l$$

To remain within the strict **$\le 250$ draw call budget**:
1. **Single-Surface Meshes:** All modular tiles and MultiMesh prototypes have exactly $S_m = 1$.
2. **Shadow Culling:** Flat cobblestones, floor tiles, and subway ballast have `cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF`, eliminating shadow split passes.
3. **Spatial Grid Chunking:** MultiMesh instances are chunked into $32\text{m} \times 32\text{m}$ spatial cells to allow frustum culling to sleep non-visible cells.
- **Target Frame Draw Calls:** Bounded between **120 and 195 draw calls** in District 01 exterior scenes.

### 8.2 Scene VRAM Allocation Breakdown
```text
┌─────────────────────────────────────────────────────────────────────────────┐
│                 DISTRICT 01 PROVISIONAL VRAM CEILING BUDGET                 │
├───────────────────────────────────────────────────┬─────────────────────────┤
│ Allocation Subsystem                              │ Projected Memory        │
├───────────────────────────────────────────────────┼─────────────────────────┤
│ Primary Framebuffer (1280x720 RGB16F + D24S8)     │ 7.03 MB                 │
│ Directional Light Shadow Map (1024x1024 D16)      │ 2.00 MB                 │
│ Architectural Texture Atlases (4x 1024x1024 DXT5) │ 21.33 MB                │
│ Prop Texture Atlases (6x 512x512 DXT5)            │ 8.00 MB                 │
│ Character Atlases (Thomas, Elena, Vance 1024x1024)│ 16.00 MB                │
│ Static ArrayMeshes & MultiMesh Buffers            │ 42.50 MB                │
│ Godot Engine Internal VRAM & Driver State Buffer  │ 120.00 MB               │
│ Inspection SubViewport (Contextual Clue Mode)     │ 10.58 MB                │
├───────────────────────────────────────────────────┼─────────────────────────┤
│ TOTAL PEAK PROJECTED SCENE VRAM                   │ 227.44 MB               │
│ HARDWARE PROVISIONAL SCENE CEILING (DEC-0033)     │ 750.00 MB               │
│ DEDICATED HARDWARE SAFETY MARGIN                  │ +522.56 MB (69.7% Head) │
└───────────────────────────────────────────────────┴─────────────────────────┘
```

---

## 9. CROSS-DEPARTMENT RATIFICATION & MASTER QUALITY SIGN-OFF

### 9.1 Inter-Departmental Dependency Ratification
The visual specifications in Book 02 strictly honor all interlocking contracts:
- **Contract D-01:** Non-Implementation Invariant on `06_GAME_PROJECT/` strictly observed.
- **Contract D-02:** Zero Blender dependencies across all art pipelines.
- **Contract D-03:** Visible scene geometry fits within $\le 250$ draw calls and $\le 750\text{ MB}$ provisional VRAM ceiling.
- **Contract D-11:** Hybrid Facial Rig (8 skeletal bones + 2 morph targets) synchronized with Department B engineering.
- **Contract D-12:** First/Third Person perspective freedom preserved across all visual framing.
- **Contract D-13:** Physical embodiment of Black Registry and rescue cylinders synchronized with Book 01 canon.

### 9.2 Master Sign-Off Block
The Visual Production Director and Specialist A7 (Visual Reviewer) hereby certify that Book 02: Visual Production Bible represents the definitive, validated visual law of Project NULL.

- **Visual Production Director:** *Certified & Approved* — 2026-11-05
- **Specialist A7 (Visual Quality Reviewer):** *Formally Signed Off (`PNL-AUDIT-A7-FINAL-001`)* — 2026-11-05
- **Lead Production Director:** *Ingested & Consolidated for Master Archive* — 2026-11-05

---
*End of Book 02: The Visual Production Bible.*