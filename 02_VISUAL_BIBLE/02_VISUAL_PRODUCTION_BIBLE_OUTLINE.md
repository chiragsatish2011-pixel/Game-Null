# PROJECT NULL — BOOK 02: VISUAL PRODUCTION BIBLE
## MASTER CHAPTER OUTLINE & PRODUCTION SPECIFICATION
**Document ID:** PNL-OUTLINE-BIBLE-002  
**Classification:** Definitive Chapter Outline & Specialist Scope Allocation  
**Version:** 1.0.0  
**Date:** 2026-11-05  
**Author:** Department A — Visual Production Director (`6f7de551-99ee-49bf-80bb-8413af5bcb84`)  
**Target Book File:** `c:\Users\A2_B2_Chirag\Documents\Game 2.6\02_VISUAL_BIBLE\02_VISUAL_PRODUCTION_BIBLE.md`  

---

## 1. OUTLINE ARCHITECTURE & SPECIALIST MAPPING

This document establishes the exhaustive ten-chapter structural blueprint for **Book 02: Visual Production Bible**. Every chapter, section, and technical metric is mapped directly to one of the seven assigned specialists of Department A.

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                 BOOK 02: CHAPTER OUTLINE & SPECIALIST ROSTER                │
├─────────┬─────────────────────────────────────────────┬─────────────────────┤
│ Chapter │ Title                                       │ Assigned Specialist │
├─────────┼─────────────────────────────────────────────┼─────────────────────┤
│ CH 01   │ Creative Vision & Visual Language           │ Lead Visual Director│
│ CH 02   │ Hardware Constraints & Visual Budgets       │ Specialist A4 & A7  │
│ CH 03   │ World & Environment Architecture            │ Specialist A1       │
│ CH 04   │ Character Art, Silhouettes & Costume Design │ Specialist A2       │
│ CH 05   │ Industrial Design, Props & 3D Evidence Items│ Specialist A3       │
│ CH 06   │ Materials, Compatibility PBR & ORM Packing  │ Specialist A4       │
│ CH 07   │ Lighting Architecture & Atmospheric VFX     │ Specialist A4       │
│ CH 08   │ Camera Grammar, Locomotion & Cinematics     │ Specialist A5       │
│ CH 09   │ Strictly Blender-Free Asset Pipeline        │ Specialist A6       │
│ CH 10   │ Quality Review, Verification & Audit Gates  │ Specialist A7       │
└─────────┴─────────────────────────────────────────────┴─────────────────────┘
```

---

## 2. DETAILED CHAPTER SPECIFICATIONS

### CHAPTER 1: CREATIVE VISION & INVENTIVE VISUAL LANGUAGE
*Lead Author: Visual Production Director | Reviewer: Specialist A7*

- **1.1 The Visual Premise:** *"The world doesn't remember you."* Translating bureaucratic erasure and inscriptional materialism into a visual discipline.
- **1.2 Ontological Polarization:**
  - *The Consensus Aesthetic (The Known):* Monumental Neoclassical rationalism, geometric symmetry, unblemished limestone, pristine brass, manicured sycamores, immaculate purple administrative seals.
  - *The Residual Aesthetic (The Material Memory):* Heavy, dense, unyielding materials that refuse administrative dissolution: rolled 3mm lead, St. Jude's ironstone, soot-blackened cast iron, cold creosote railway timbers, salt-corroded brickwork.
  - *The Unwritten Aesthetic (The Excluded Reality):* Fraying spatial edges, advection fog horizons, non-Euclidean looping roads, displaced municipal relics emerging from peat bogs.
- **1.3 Chromatic Architecture & Color Theory:**
  - *Desaturated Realism Palette:* Dominant spectrum of soot black (`#141416`), damp slate (`#383D42`), weathered limestone (`#9E9B8F`), and creosote brown (`#2B231D`).
  - *Accent & Signal Colors:* Institutional purple aniline ink (`#4A2E5B`), tarnished clockmaker’s brass (`#A68038`), railway signal red (`#8B2626`), and lantern paraffin amber (`#C98A3C`).
  - Strict prohibition against synthetic neons, chromatic aberration slop, lens flares, and digital post-processing artifacts.
- **1.4 Environmental Storytelling Principles:**
  - Layers of municipal redaction: painted-over street names, chisel marks on building dedication tablets, recut apartment keyways, and welded-shut subway gates.

---

### CHAPTER 2: HARDWARE PROFILES & RIGID PERFORMANCE BUDGETS
*Lead Author: Specialist A4 & Specialist A7 | Engineering Liaison: Dept B (B7)*

- **2.1 NVIDIA GeForce G210 Architectural Profile:**
  - 1024 MB DDR3 VRAM on 64-bit bus (8.0 GB/s bandwidth limit).
  - Tesla architecture (GT218), 16 CUDA cores, 8 TMUs, 4 ROPs.
  - Complete absence of Vulkan, compute shaders, and D3D12 hardware support.
- **2.2 Godot 4.7.2 Compatibility Renderer (`gl_compatibility`) Boundaries:**
  - OpenGL 3.3 Core Profile restrictions.
  - Single directional shadow cascade; omni/spotlight real-time shadows strictly disabled.
  - Zero real-time global illumination (no SDFGI, no VoxelGI), zero SSR.
- **2.3 Comprehensive VRAM Allocation Matrix (1024 MB Total):**
  - Framebuffers & MSAA targets: 128 MB (12.5%).
  - Directional shadow depth buffer (1x 1024x1024 16-bit): 32 MB (3.1%).
  - Static environment textures (PBR Albedo + ORM + Normal): 250 MB (24.4%).
  - Dynamic characters & hero props: 100 MB (9.8%).
  - 2D User Interface & typography glyph atlases: 30 MB (2.9%).
  - Vertex/Index geometry buffers (VBO/IBO): 80 MB (7.8%).
  - Godot internal driver allocations & pipeline state: 200 MB (19.5%).
  - Unallocated dynamic safety headroom: 204 MB (20.0%).
- **2.4 Frame Budget & Draw Call Ceilings:**
  - Target framerate: Stable 30–60 FPS.
  - Hard draw call ceiling: **180 to 250 draw calls per frame maximum**.
  - Mandatory deployment of `MultiMeshInstance3D` for repeated geometry (cobblestones, track ballast, railway ties, streetlamps, fence pickets).
  - Visible triangle budget: 75,000 to 100,000 triangles per camera view.
- **2.5 Asset Polycount Thresholds:**
  - Dynamic Player Models (Thomas, Elena): 5,000 – 8,000 triangles.
  - Secondary NPCs (Janos, Aldous, Konrad): 4,000 – 6,000 triangles.
  - Hero Props (Interlocking frame, escapement clocks, Black Registry): 1,000 – 1,500 triangles.
  - Minor Environmental Clutter (bottles, ledger slips, keys): 150 – 500 triangles.
  - Modular CSG architectural blocks: 50 – 300 triangles per segment.

---

### CHAPTER 3: WORLD & ENVIRONMENT ARCHITECTURE
*Lead Author: Specialist A1 (Environment Art Researcher)*

- **3.1 Geographic Setting & Basin Topography:**
  - The 12-kilometer Vesper Basin bowl, northern granite bluffs, southern pine valley, stagnant cloud inversion layer.
- **3.2 District 01: The Park District & Civic Center (LOC-01):**
  - *Visual Identity:* Sterile Monumental Rationalism, symmetrical limestone colonnades, immaculate bronze lanterns, post-Settlement civic pride.
  - *The Over-Slab Structural Reality:* 1.5m–2.5m thick post-tensioned cellular concrete slab resting on 120 caissons and 8 natural rock monoliths; subterranean ventilation gratings exhaling low-frequency vibration.
- **3.3 District 02: The Foundry & West Junction (LOC-02):**
  - *Visual Identity:* Industrial cutting carved 15 meters into ironstone; multi-track rail cut; grease, creosote, and coal smoke.
  - *West Junction Signal Tower (LOC-02-A):* Four-story red-brick base with timber-framed upper operating floor; 360-degree multi-pane windows overlooking the switch tracks; interior lever room details.
- **3.4 District 03: The Old Canal & Wharves (LOC-03):**
  - *Visual Identity:* Salt-glazed red industrial brick, slow murky water, wooden pilings, damp cobblestone quays.
  - *Hess & Sons Bookbindery (LOC-03-A):* Cramped subterranean workshop, cast-iron book presses, drying racks, animal-glue pots, lead sheeting rolls.
- **3.5 District 04: The High Tenements (LOC-04):**
  - *Visual Identity:* Dense five-story tenements stacked vertically against eastern quarry cliffs; cast-iron funicular railway; "The Seven Hundred Steps"; improvised rooftop laundry drying.
- **3.6 District 05: The University & Medical Terraces (LOC-05):**
  - *Visual Identity:* Heavy 19th-century granite institutional facades; Geological Institute lecture halls with rock core racks; Victorian infirmary wards with high clerestory windows.
- **3.7 District 09 & Quarry Pit 03: The Sunken Ward Architectural Reconstruction:**
  - *The 15-Hectare Excavation Footprint:* 650m x 200m main basin; 28m to 75m deep quarry walls.
  - *The 8 Monolithic Rock Bastions:* Pyramidal limestone pillars retaining 333,200 m³ of unmined rock; weathered chisel marks and drilling sockets.
  - *The 120 Drilled Concrete Caissons:* 2.5m diameter cylindrical pillars rising 26 meters to support the over-slab transfer girders.
  - *The Infill Embankment:* 210,000 m³ (319,200 tonnes) of crushed masonry piled against the western quarry face.
  - *The Preserved Ward Ruins:* Intact ground-floor storefronts, street signage, crushed schoolhouses, rusted streetcars preserved in pitch-black 8°C subterranean gloom.
- **3.8 The Deep: Tiered Subterranean Industrial World:**
  - *Tier 1 (-15m):* Subway Line 2; glazed white ceramic tiles; copper pneumatic message conduits; Platform 0 walled-off secret transit stop.
  - *Tier 2 (-45m):* Heavy coal spurs; blackened timber shoring; roaring iron drainage sluices; battery transformer rooms.
  - *Tier 3 (-85m):* Rotary Turbine Hall (LOC-DEEP-TURB) housing six 12-meter bronze impellers (18.4 Hz); Vault 04 (LOC-DEEP-V04) armored steel bulkhead redoubt.
- **3.9 Greyhaven: Rural Sanctuary & Coastal Peatlands:**
  - *Visual Identity:* Weathered cedar shingles, granite fishing piers, ancient pine barrens, granite headlands; complete acoustic and architectural departure from Vesper's ironstone.
  - *The Split House (LOC-GH-04):* Architectural manifestation of ontological contradiction (rotting empty eastern wing vs. inhabited, warm western wing).
- **3.10 The Outside (Kilometer 14 to Salt Marsh):**
  - *Visual Identity:* Cold wind-swept coastal flatlands, acid peat bogs, stunted birch and pine barrens, sheer basalt bluffs with magnetite veins.
  - *The Abandoned 1920 Coal Corridor:* Unballasted single track, rusted fishplates, rotted timber ties, dry grass growing through switch levers.
  - *Visual Phenomena of Spatial Anomalies:*
    - The 6.4 km Azimuth Deflection loop: flat, horizonless whiteout fog.
    - Metric Non-Additivity: visual alignment of bronze survey markers `SM-14` and `SM-18` across open marsh.
    - Displaced Matter: erased District 09 municipal streetlamps and boundary stones protruding from damp peat bogs.

---

### CHAPTER 4: CHARACTER ART, ANATOMICAL SILHOUETTES & TEXTILES
*Lead Author: Specialist A2 (Character Art Director)*

- **4.1 Character Design Philosophy & Silhouette Readability:**
  - Realistic anatomical proportions (8 heads tall); grounded posture reflecting weight, age, and occupational strain; zero stylized anime or caricature tropes.
  - Silhouette test: characters must be instantly distinguishable in high-contrast rim lighting or dense fog by their shoulder slope, coat hem, and headwear.
- **4.2 Lead Character: Thomas Arthur Mercer (`CHAR-MERC-001`, Age 56):**
  - *Physical Anatomy:* Heavy-set, broad-shouldered railwayman; stooped thoracic spine; lined, tired face; heavy jaw with grey stubble; scarred knuckles.
  - *Costume:* Worn double-breasted navy woolen greatcoat with tarnished municipal railway buttons; heavy charcoal twill work trousers; oiled leather high-lacing boots; knit woolen fingerless gloves; brass pocket watch chain.
  - *Expression & Demeanor:* Stoic, guarded, deeply burdened eyes; jaw clamped tight to suppress grief and guilt.
- **4.3 Lead Character: Elena Martha Mercer (`CHAR-MERC-002`, Age 26):**
  - *Physical Anatomy:* Lean, angular silhouette; sharp cheekbones; intense, observant dark eyes; dark brown hair tied back with a plain ribbon.
  - *Costume:* Tailored municipal registrar’s dark wool jacket with ink-stained cuffs; pleated charcoal wool skirt over heavy cotton petticoats; practical lace-up calfskin boots; dark red woolen scarf.
  - *Distress & Illness State:* Feverish flush, pale sunken temples, purulent bronchitis cough posture, wool blanket wrap during Vault 04 shelter.
- **4.4 Antagonist / Foil: Inspector Janos Vance (`CHAR-VANC-003`, Age 61):**
  - *Physical Anatomy:* Solid, stocky administrative build; slight belly; round jowly face with tired, heavy eyelids; nicotine-stained teeth.
  - *Costume:* Rumpled brown tweed three-piece suit; faded herringbone wool overcoat; heavy horn-rimmed reading spectacles; brown fedora; worn cowhide audit portfolio.
- **4.5 Bureaucratic Foil: Chief Registrar Aldous Vane (`CHAR-VANE-004`, Age 68):**
  - *Physical Anatomy:* Gaunt, razor-sharp posture; aristocratic skull; clean-shaven translucent skin; cold, clinical grey eyes.
  - *Costume:* Impeccably pressed dark charcoal morning suit; stiff celluloid wing collar; silk cravat; gold pince-nez spectacles on a black silk ribbon.
- **4.6 Survivor Anchor: Master Bookbinder Konrad Hess (`CHAR-HESS-005`, Age 72):**
  - *Physical Anatomy:* Slender, bent frame; gnarled arthritic hands scarred by needles and binding wire; cataract in left eye; trembling hands that stabilize only when handling books.
  - *Costume:* Thick oiled leather work apron over faded homespun linen shirt; corduroy trousers tucked into felt slippers; round steel-rimmed spectacles.
- **4.7 Secondary Witness Network Specifications:**
  - *Marta Kroll (`CHAR-KROL-006`, Age 59):* Starched white nurse's apron over navy wool dress; wool knit shawl; ring of institutional brass keys.
  - *Goran Lindt (`CHAR-LIND-007`, Age 24):* Young grease-stained railway switchman; oversized railway tunic; wool flat cap; nervous demeanor.
  - *Aunt Lidia Vane-Mercer (`CHAR-AUNT-008`, Age 70):* Greyhaven village elder; heavy hand-spun wool shawl; wooden rosary; weather-beaten face.
  - *Inspector Pavel Radek (`CHAR-RADE-009`, Age 44):* Field enforcement officer; dark rubberized mackintosh trenchcoat; leather service gloves; flashlight holster.
  - *Henrik Baum (`CHAR-BAUM-010`, Age 38):* Relocated citizen; plain clerk’s woolen jacket; holding invalid cadastral assignment paperwork; bewildered, fearful eyes.
- **4.8 Master Textile & Material Reference Library:**
  - Heavy boiled wool (rough, low-sheen, absorbs water).
  - Oiled cowhide leather (creased, scuffed, specular sheen along folds).
  - Starched linen and celluloid collars.
  - Municipal stamped brass buttons (verdigris oxidation in crevices).

---

### CHAPTER 5: INDUSTRIAL DESIGN, HERO PROPS & 3D EVIDENCE MODELS
*Lead Author: Specialist A3 (Prop & Industrial Design Specialist)*

- **5.1 Railway Mechanical Systems & Tower Hardware:**
  - *64-Lever Mechanical Interlocking Frame:* Solid cast-iron levers (red = signals, black = turnout switches, white = spares); machined steel catch-handles and quadrant locking dogs; tappet locking beds.
  - *Mechanical Train Describer & Bell Tappers:* Polished brass dials, enamel lettering, cast-iron clappers for block signaling.
  - *Pendulum Dispatch Clock:* Mahogany case, glazed door, deadbeat escapement, heavy brass pendulum bob swinging at exactly 1 beat per second.
  - *West Junction Wire Recorder:* Stainless-steel magnetic wire transport mechanism, brass drive spools, glowing vacuum tube indicators.
- **5.2 Locomotive #884 Visual Model (Class 52 2-10-0 Heavy Freight):**
  - *Boiler & Chassis:* Riveted steel boiler shell (180 PSI rated); five coupled 1,400mm driving wheels with connecting rods and Walschaerts valve gear; twin cylinder blocks; front sheet-metal smoke deflectors (Witte type).
  - *Tender & Postal Car:* 4-axle bogie tender loaded with 12 tonnes of black anthracite coal; steel-clad wooden postal van with barred slit windows and heavy padlocked sliding cargo doors.
  - *Weathering & Surface Realism:* Black boiler enamel stripped by heat to oxidized dark grey iron; lime scale streaks below safety valves; grease and oil caked around driving axle brasses.
- **5.3 Bureaucratic Municipal Technology:**
  - *Municipal Ledger Seal Presses:* Heavy cast-iron screw-down embossing presses bearing the eagle seal of the Bureau of Municipal Consistency.
  - *De-Registration Document Cancellers:* Spring-loaded steel hand punches that stamp a clean 20mm round hole through citizen registry numbers.
  - *Pneumatic Transit Capsules:* Cylindrical brass canisters with felt sealing rings and leather index tags.
- **5.4 The Black Registry (Volumes I & II) Technical Anatomy:**
  - *Dimensions & Construction:* Folio size (35cm x 45cm x 12cm); gross weights 11.4 kg (Vol I) and 12.8 kg (Vol II).
  - *Binding:* 3mm rolled sheet lead beaten around 15mm seasoned oak boards; riveted brass corner guards; hand-soldered lead backstrip.
  - *Locking Mechanism:* Dual brass four-lever tumbler locks inset into front board; keyed exclusively to `KEY-MERC-04`.
  - *Paper Stock:* 120 gsm mould-made cotton rag paper, unbleached, resistant to moisture; bound with waxed hemp cord over split leather thongs.
  - *Internal Slips:* 1,418 duplicate carbon receipts in Volume II; 412 pre-1976 architectural blueprints and mine surveys in Volume I.
- **5.5 Physical Clues & Interactive Evidence Items (Asset Register):**
  - `DOC-001`: 1968 Settlement Parchment with 14 lead signature seals.
  - `DOC-002`: Railway Dispatch Order #14 (carbon paper slip with Thomas's handwriting).
  - `DOC-003`: Cadastral Adjustment Warrant #8492-X (chemical bleach erasure visible under light).
  - `DOC-004`: District 09 Infill Transfer Blueprint (cyanotype on linen).
  - `KEY-MERC-01` to `KEY-MERC-04`: Hand-cut brass lever keys with unique bittings.
  - `DISC-SM-14` / `DISC-SM-18`: 15cm bronze survey discs stamped with cadastral survey grid marks.
  - *Invar Surveying Chain:* 20-meter linked nickel-steel chain with spring dynamometer handle.

---

### CHAPTER 6: MATERIAL SCIENCE, PBR STANDARDS & ORM CHANNEL PACKING
*Lead Author: Specialist A4 (Materials & Lighting Specialist)*

- **6.1 OpenGL 3.3 Compatibility PBR Material Pipeline:**
  - Standard Godot `StandardMaterial3D` parameters supported in Compatibility mode: Albedo Color/Texture, Roughness, Metallic, Normal Map, Ambient Occlusion, Emission.
  - Subsurface scattering, displacement mapping, and clearcoat disabled for performance.
- **6.2 ORM Texture Channel Packing Standard:**
  - Consolidating three grayscale maps into a single 3-channel RGB image:
    - **Red (R):** Ambient Occlusion (AO).
    - **Green (G):** Roughness.
    - **Blue (B):** Metallic.
  - Memory savings: 3 textures compressed into 1, reducing texture sampler units from 3 to 1 and cutting VRAM overhead by 66.7%.
- **6.3 Texture Resolution & Atlas Hierarchy:**
  - *1024x1024 Maximum Atlas:* Reserved strictly for primary architectural tileables (District 01 limestone facades, District 02 brickwork, Over-slab concrete deck).
  - *512x512 Standard:* Characters (Thomas, Elena), Locomotive #884 main sections, and Hero Props (Signal lever frame, Black Registry).
  - *256x256 Minor Props:* Paper slips, books, lanterns, track clutter.
  - Format standard: S3TC / DXT1 (Albedo, ORM) and DXT5 (Normal).
- **6.4 Canonical Material Library Specifications:**
  - *MAT-01: St. Jude's Ironstone:* Slate-charcoal albedo, high roughness (0.85), low metallic (0.05), pitted micro-porosity normal map.
  - *MAT-02: Weathered Neoclassical Limestone:* Warm off-white/beige albedo, chalky roughness (0.90), zero metallic, fine dressed-stone chisel lines.
  - *MAT-03: Salt-Glazed Industrial Red Brick:* Dark terracotta/burnt umber albedo, uneven roughness (0.40–0.75), low metallic (0.0), mortar recess normal map.
  - *MAT-04: Rolled 3mm Sheet Lead:* Dull silver-grey albedo with white lead-carbonate oxidation bloom, moderate roughness (0.55), high metallic (0.80), hammered dent normal map.
  - *MAT-05: Pitted Cast Foundry Iron:* Dark graphite grey albedo, rough grain (0.70), high metallic (0.90), casting pit normal map.
  - *MAT-06: Oiled Creosote Railway Timber:* Deep blackened amber-brown albedo, variable roughness (0.35 in wet oil pools to 0.85 on weathered grain), zero metallic, fibrous wood grain normal map.
  - *MAT-07: Tarnished Clockmaker's Brass:* Dark golden-yellow albedo with green verdigris in recesses, smooth roughness (0.25 on polished surfaces, 0.70 in crevices), high metallic (0.95).
  - *MAT-08: Wet Coastal Peat Marsh:* Dark chocolate/black organic soil albedo, high roughness (0.90) with specular wet puddles (roughness 0.05), zero metallic, clodded root normal map.

---

### CHAPTER 7: LIGHTING ARCHITECTURE, SHADOWS & ATMOSPHERIC EFFECTS
*Lead Author: Specialist A4 (Materials & Lighting Specialist)*

- **7.1 Single Directional Light Architecture:**
  - Exactly one active `DirectionalLight3D` per environment (sunlight during overcast day, moon/cloud glow during night).
  - Shadow map configuration: 1024x1024 16-bit depth buffer; orthogonal projection; shadow max distance restricted to 60–80 meters.
  - PSSM (Parallel Split Shadow Maps): 2 splits maximum to conserve fill-rate on the G210.
- **7.2 Ambient Illumination & Environment Energy:**
  - `WorldEnvironment` background mode: Custom color (`#0A0B0E` night, `#2E3238` overcast day).
  - Ambient light: Provided via `Environment.ambient_light_source = AMBIENT_COLOR` with subtle chromatic tinting (cold blue-grey for rain, pale amber for interiors).
- **7.3 Distance Fog & Atmospheric Calibration ("The Grey Sheet"):**
  - Simulated exclusively using `WorldEnvironment` exponential distance fog:
    - `fog_enabled = true`
    - `fog_light_color = Color(0.22, 0.24, 0.26, 1.0)`
    - `fog_density = 0.015` to `0.045` (tuned by district)
    - `fog_depth_begin = 10.0` meters, `fog_depth_end = 80.0` meters.
  - Absolute suppression of volumetric fog (`volumetric_fog_enabled = false`).
- **7.4 Light-Card & Simulated Volumetric Shaders:**
  - Godot Compatibility-safe simulated light beams:
    - Transparent quad mesh cards with additive unshaded materials.
    - Vertical gradient alpha fade: soft edges without geometry clipping.
    - Used for signal lantern beams, streetlamp cones, and high infirmary window rays.
- **7.5 Particle Systems on Compatibility Renderer:**
  - `CPUParticles3D` exclusively (no GPU compute particles).
  - Maximum 300 active particles per scene:
    - Falling rain / drizzle (stretched quad billboards, alpha blend).
    - Locomotive chimney coal smoke (soft radial gradient sprites with slow rotation).
    - Steam escape vents (billboard cards with fade-out lifecycle).

---

### CHAPTER 8: CAMERA GRAMMAR, TRAVERSAL MOTION & CINEMATICS
*Lead Author: Specialist A5 (Animation & Cinematics Director)*

- **8.1 Dual-Mode Camera Rig Architecture:**
  - Spring-arm based system (`SpringArm3D` + `Camera3D`).
  - *Mode A: Third-Person Over-the-Shoulder:*
    - Focal length: 35mm equivalent (Horizontal FOV: 68°).
    - Spring length: 2.4 meters; shoulder offset: (0.45m right, 0.25m up).
    - Spring collision mask: World geometry only (excludes player character capsule).
  - *Mode B: First-Person Traversal / Inspection:*
    - Spring length collapses to 0.0 meters; camera position aligns with player eye-socket node (1.68m height).
    - Smooth cubic interpolation ($t = 0.35\text{s}$) between modes.
- **8.2 Contextual Evidence Inspection Mode:**
  - Triggered upon interacting with 3D clue items.
  - Camera transitions to locked studio framing (45° FOV) focused on prop bounding box center.
  - Full 360-degree interactive mouse-drag rotation; subtle rim-light illumination to highlight serial numbers, lead seals, and inscriptions.
- **8.3 Locomotion Kinematics & Character Movement Language:**
  - *Thomas Mercer (Age 56):*
    - Deliberate, grounded locomotion. Max walking speed: 3.2 km/h; running speed: 6.8 km/h.
    - Turn rate constrained to realistic inertial acceleration (no instant snapping).
    - Asymmetric gait: slight left-knee dip (35mm downward offset every left step) reflecting old railway injury.
    - Heavy footstep audio/visual synchronization with boot-to-surface contacts.
  - *Elena Mercer (Age 26):*
    - Brisk, purposeful, rapid stride; slight forward lean; defensive posture.
- **8.4 Low-Cost Cinematic Dialogue Staging:**
  - Rejection of expensive full-body performance capture.
  - Staging based on classic film noir chiaroscuro framing:
    - Over-the-shoulder medium close-ups with shallow focus cues.
    - Subtle procedural skeletal micro-motion: breathing idle loops, eye dart saccades, slow head rotations.
    - Dramatic side key lighting emphasizing jaw lines, coat collars, and facial exhaustion.

---

### CHAPTER 9: STRICT BLENDER-FREE ASSET PRODUCTION PIPELINE
*Lead Author: Specialist A6 (Asset Pipeline Specialist)*

- **9.1 Poly Haven Sourcing & Ingestion Protocols:**
  - Sourcing CC0 textures and architectural surface maps.
  - Ingestion filter: strictly download 1K or 2K PNG maps (never 4K/8K).
  - Standardized local file structure: `res://assets/materials/polyhaven/<material_name>/`.
- **9.2 Generative 3D Mesh Ingestion (Meshy / Tripo AI):**
  - Text-to-3D and Image-to-3D generation parameters:
    - Output format: Binary `.glb` (glTF 2.0).
    - Geometry budget: Enforce target triangle count $\le 1,500$ triangles per prop.
    - Topology: Watertight manifold mesh; triangulated or quad-dominant.
- **9.3 Automated Python GLB Geometry Inspection Tool:**
  - Standalone script (`inspect_glb.py`):
    - Reads binary header chunk without 3D DCC software.
    - Extracts vertex counts, index buffers, triangle counts, texture resolutions, and material names.
    - Automatically rejects any asset exceeding 1,500 triangles or 1024x1024 textures.
- **9.4 Automated Python PIL Texture Processing & ORM Packing:**
  - Standalone script (`pack_orm.py`):
    - Reads separate AO, Roughness, and Metallic grayscale images.
    - Downsamples to target resolution (512x512 or 1024x1024) using high-quality Lanczos resampling.
    - Packs channels into combined RGB image: R=AO, G=Roughness, B=Metallic.
    - Saves optimized output as JPEG (quality=85) or compressed PNG.
- **9.5 Godot 4 CSG Modular Architectural Prototyping:**
  - Street, corridor, and apartment geometry constructed inside Godot using `CSGBox3D`, `CSGCylinder3D`, and `CSGPolygon3D`.
  - Reusable modular segments saved as `.tscn` branch scenes.
  - Level blockout validation: check collision profiles, doorway clearances (min 2.1m height, 0.9m width), stair tread ratios (18cm riser, 28cm tread).
  - Production bake: Export CSG assemblies to unified static meshes or MultiMesh instances to reduce draw calls.

---

### CHAPTER 10: QUALITY ASSURANCE, BUDGET ENFORCEMENT & GATEKEEPING
*Lead Author: Specialist A7 (Visual Quality Reviewer)*

- **10.1 The Pre-Commit Visual Compliance Checklist:**
  - [ ] Mesh format is strictly binary `.glb` or native Godot `.tscn`.
  - [ ] Prop triangle count is $\le 1,500$ (hero) or $\le 500$ (minor).
  - [ ] PBR textures packed into ORM format (R=AO, G=Roughness, B=Metallic).
  - [ ] Texture resolution is $\le 512 \times 512$ (props) or $\le 1024 \times 1024$ (environment).
  - [ ] No compute shaders, no volumetric fog, no real-time omni/spot shadows.
  - [ ] Draw call impact evaluated; instances greater than 5 combined into `MultiMeshInstance3D`.
- **10.2 Automated Headless Verification Suite:**
  - Godot CLI test script checking scene tree metrics headlessly:
    - Verifies that total scene mesh instances in any room chunk do not exceed 60 nodes.
    - Scans materials to ensure no incompatible shader features are enabled.
- **10.3 Aesthetic Integrity & Anti-Slop Audit Rubric:**
  - Zero high-tech glowing interfaces or neon aesthetics.
  - Zero generic fantasy styling (no magical swirls, mystical fog, glowing runes).
  - Tactile authenticity: surfaces must show realistic physical wear, chipped enamel, soot stains, greasy fingerprints, and paper fraying.
- **10.4 Phase 2 Acceptance Gates (Waves 2 through 6):**
  - Sign-off requirements for specialist research findings in Wave 2.
  - Pre-assembly validation in Wave 4.
  - Final red-team budget certification in Wave 5.

---

## 3. SCHEDULE OF DELIVERABLES & INTER-DEPARTMENT INTEGRATION

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                       BOOK 02 DELIVERY MILESTONES                           │
├────────┬────────────┬───────────────────────────────────────────────────────┤
│ Wave   │ Date       │ Milestone Target                                      │
├────────┼────────────┼───────────────────────────────────────────────────────┤
│ Wave 1 │ 2026-11-05 │ Department Charter & Book 02 Master Outline locked.   │
│ Wave 2 │ 2026-11-06 │ Specialist research papers (A1–A6) completed.         │
│ Wave 3 │ 2026-11-07 │ Cross-department contracts (Dept B & C) signed off.   │
│ Wave 4 │ 2026-11-08 │ Book 02: Visual Production Bible drafted & assembled. │
│ Wave 5 │ 2026-11-09 │ Specialist A7 independent quality audit executed.     │
│ Wave 6 │ 2026-11-10 │ Final book sign-off & release into Project Control.   │
└────────┴────────────┴───────────────────────────────────────────────────────┘
```

---

## 4. FORMAL APPROVAL & ADOPTION

This outline constitutes the binding structural specification for **Book 02: Visual Production Bible** of PROJECT NULL. All specialist research, material formulations, and pipeline scripts produced during Phase 2 must conform directly to these chapter designations.

- **Director of Visual Production:** `6f7de551-99ee-49bf-80bb-8413af5bcb84`
- **Status:** APPROVED & LOCKED FOR WAVE 2 DISPATCH
