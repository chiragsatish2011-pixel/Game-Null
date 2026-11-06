# PROJECT NULL — BOOK 02: VISUAL PRODUCTION BIBLE
## CHAPTER 03 RESEARCH DELIVERABLE: ENVIRONMENT ART RESEARCH & ARCHITECTURAL WORLDBUILDING
**Document ID:** PNL-BIBLE-02-ENV-01  
**Classification:** Authoritative Environmental Art & Spatial Design Specification  
**Version:** 1.0.0  
**Date:** 2026-11-05  
**Author:** Specialist A1: Environment Art Researcher & Architectural Worldbuilder  
**Department:** Department A — Visual Production  
**Parent Document:** Book 02: Visual Production Bible (`02_VISUAL_PRODUCTION_BIBLE.md`)  
**Target Engine / API:** Godot Engine 4.7.2 (`gl_compatibility` / OpenGL 3.3 Core Profile)  
**Hardware Profile:** Intel Core i5-12400F | 16 GB DDR4 | NVIDIA GeForce G210 (1024 MB DDR3 VRAM)  

---

## 1. EXECUTIVE DIRECTIVE & EVIDENCE FRAMEWORK

### 1.1 Specialist Mission & Scope
As Specialist A1 within Department A (Visual Production), this document establishes the exhaustive architectural, geological, atmospheric, and spatial specifications for all navigable and visible environments across **PROJECT NULL**. 

The environment art across Vesper Basin, The Deep, Greyhaven, and The Outside embodies the visual core axiom of the project: **Inscriptional Materialism**—the persistent physical tension between the state's sterile, plastic consensus and stubborn, heavy, non-biodegradable physical matter that refuses bureaucratic erasure.

```
┌──────────────────────────────────────────────────────────────────────────────────────────────────┐
│                             ENVIRONMENT ART RESEARCH MANDATE & SCOPE                             │
├──────────────────────────┬───────────────────────────────────────────────────────────────────────┤
│ Macro-Territory          │ Specific Environmental Research & Architectural Specifications        │
├──────────────────────────┼───────────────────────────────────────────────────────────────────────┤
│ 1. Vesper Basin          │ Districts 01 to 05, the Erased District 09, urban topography,         │
│    (Urban Surface)       │ monumental facades, industrial rail cuts, wharves, tenements, cloisters│
├──────────────────────────┼───────────────────────────────────────────────────────────────────────┤
│ 2. The Deep              │ Tier 1 (-15m Transit), Tier 2 (-45m Industrial), Tier 3 (-85m Sunken  │
│    (Subterranean Void)   │ Ward, 15.0 ha Quarry Pit 03, 8 Bastions, 120 Caissons, Turbines)      │
├──────────────────────────┼───────────────────────────────────────────────────────────────────────┤
│ 3. Greyhaven             │ Rural maritime granite, peat bogs, tidal marshes, The Split House,    │
│    (The Rural Periphery) │ Greyhaven Sanitarium (1968 Treaty site), South Cemetery               │
├──────────────────────────┼───────────────────────────────────────────────────────────────────────┤
│ 4. The Outside           │ Beyond Km 14, abandoned 1920 rail cut, basalt sea bluffs, "The Grey   │
│    (Cadastral Waste)     │ Sheet" advection fog, Azimuth Loop, Metric Non-Additivity, Monuments  │
├──────────────────────────┼───────────────────────────────────────────────────────────────────────┤
│ 5. Materiality & Color   │ Regional hex palettes, PBR roughness/metallic bands, weathering drips │
├──────────────────────────┼───────────────────────────────────────────────────────────────────────┤
│ 6. Occlusion & Budgets   │ Draw-call breaking geometry, sightline kinks, MultiMesh, G210 gates   │
└──────────────────────────┴───────────────────────────────────────────────────────────────────────┘
```

### 1.2 Mandatory Evidence Classification Taxonomy
In strict compliance with `00_PROJECT_CONTROL/TECHNICAL_ASSUMPTION_AUDIT.md` (DEC-0031), every engineering calculation, geometric limit, lighting parameter, and architectural dimension in this specification is categorized according to the five-tier taxonomy:
1. `[Verified Capability]` — Confirmed via functional CLI test, engine probe, or code execution on the active development environment.
2. `[Measured Result]` — Quantified data derived from an explicit benchmark test, recording hardware, tool, and methodology.
3. `[Engineering Estimate]` — First-principles calculation or industry-standard derived estimate with explicit mathematical formulas and bounds.
4. `[Design Recommendation]` — Creative, visual, or architectural guideline proposed to fulfill aesthetic, gameplay, or orchestration goals.
5. `[Unverified Assumption]` — Provisional target or working hypothesis requiring empirical verification during testing before release.

### 1.3 Technical Boundaries & Performance Directives
Every environment design specification must adhere strictly to the non-negotiable Phase 2 technical constraints:
- **Target GPU Envelope:** NVIDIA GeForce G210 with 1024 MB DDR3 VRAM, 64-bit bus (8.0 GB/s bandwidth) `[Verified Capability]`.
- **System Memory Overhead:** Windows DWM and driver overhead consumes 150 MB to 250 MB VRAM before game initialization `[Engineering Estimate]`.
- **Safe VRAM Ceiling:** Complex exterior/interior environment scenes must not exceed **750 MB Total VRAM** (reserving >= 274 MB safety headroom to prevent slow PCIe 2.0 paging to system RAM) `[Engineering Estimate]`.
- **Draw Call Ceiling:** Maximum **180 to 250 draw calls per frame** `[Design Recommendation]`.
- **Visible Polygon Budget:** 75,000 to 100,000 triangles per camera view `[Design Recommendation]`.
- **Asset Geometry Allocations:**
  - Modular architectural panels: 100 to 400 triangles `[Design Recommendation]`.
  - Ordinary environment props: 250 to 800 triangles `[Design Recommendation]`.
  - Vegetation & debris clusters: 100 to 350 triangles `[Design Recommendation]`.
  - Strictly 1 material per prop wherever possible `[Design Recommendation]`.
- **Lighting & Shader Discipline:** Godot 4 Compatibility Renderer (`gl_compatibility` / OpenGL 3.3). Exactly 1 directional light with a single 1024x1024 16-bit depth shadow map; zero real-time point/spotlight shadow maps; no SSR; no volumetric fog; ambient fill driven by constant environment energy and calibrated distance fog in `WorldEnvironment` `[Verified Capability]`.
- **Strictly Blender-Free Workflow:** Environment architecture constructed via Godot CSG primitives and modular binary `.glb` kitbashing; CC0 Poly Haven and generative AI meshes (Meshy / Tripo AI); automated Python Pillow (`PIL`) texture processing and ORM channel packing `[Design Recommendation]`. Zero `.blend` files or Blender runtime dependencies permitted (DEC-0002).
- **Non-Implementation Protocol:** This document contains research, visual design criteria, spatial dimensions, material definitions, and architectural layouts. It contains zero production scene trees, GDScript code, or runtime logic scripts `[Design Recommendation]`.

---

## 2. REGIONAL ARCHITECTURAL ARCHETYPES & URBAN MORPHOLOGY (VESPER BASIN)

```
                                  THE NORTHERN BLUFFS (Granite Palisade)
                                                   ▲
                                                   │
  ┌────────────────────────────────────────────────┼────────────────────────────────────────────────┐
  │                                           VESPER BASIN                                          │
  │                                                                                                 │
  │     [WEST JUNCTION & FOUNDRY]      [DISTRICT 01: CIVIC PARK]       [DISTRICT 05: UNIVERSITY]     │
  │            (District 02)             (Over-Slab / Ministries)        (Medical Terraces)         │
  │                 │                                │                                │             │
  │                 └─── West Freight Cut ──────────┼──────────── High Canal ─────────┘             │
  │                                                  │                                              │
  │     [DISTRICT 03: OLD CANAL]                     │                 [DISTRICT 04: TENEMENTS]     │
  │       (Wharves & Printshops)           Vesper River Confluence        (Funicular / High Quarry) │
  │                 │                                │                                │             │
  └─────────────────┼────────────────────────────────┼────────────────────────────────┼─────────────┘
                    │                                │                                │
                    ▼                                ▼                                ▼
  ═══════════════════════════════════════════════════════════════════════════════════════════════════
                                THE DEEP (Subterranean Tiers 1, 2, 3)
  ═══════════════════════════════════════════════════════════════════════════════════════════════════
                    │
                    ▼ (Old Coast Rail Line - 28 km)
  ┌─────────────────────────────────────────────────────────────────────────────────────────────────┐
  │                                       GREYHAVEN VALLEYS                                         │
  │            (Ancient Pine Forests, Coastal Salt Marshes, The Sanitarium, South Cemetery)         │
  └─────────────────────────────────────────────────────────────────────────────────────────────────┘
                    │
                    ▼ (Topological Breakdown Boundary - Kilometer 14)
  ┌─────────────────────────────────────────────────────────────────────────────────────────────────┐
  │                                         THE OUTSIDE                                             │
  │               (Non-Euclidean Spatial Folds, Looping Roads, Cadastral Waste Horizon)             │
  └─────────────────────────────────────────────────────────────────────────────────────────────────┘
```

### 2.1 Macro-Topography of the 12-Kilometer Basin Bowl
The urban setting of Vesper sits enclosed within an elliptical geological sink approximately 12 kilometers east-to-west and 9 kilometers north-to-south `[Design Recommendation]`. 
- **Geological Bedrock:** Composed predominantly of **St. Jude’s Ironstone**—a dense, ferrous, slate-grey dolomitic limestone interspersed with dark shale beds and magnetite bands `[Design Recommendation]`.
- **Topographical Enclosure:** Flanked along the northern and north-eastern boundary by the sheer 80-meter granite palisades of the Northern Bluffs, and terminating to the south in damp coastal pine forests and peat valleys that slope toward the sea `[Design Recommendation]`.
- **Atmospheric Microclimate:** The basin bowl operates as a natural thermal inversion sink. Stagnant moisture from the Lower Vesper Canal and industrial coal emissions from District 02 form a persistent ground-level smog and cold drizzle layer. Sunlight rarely strikes street surfaces directly; illumination is characterized by uniform, diffused cool-grey skylight (correlated color temperature ~6500K) `[Design Recommendation]`.

---

### 2.2 District 01: The Park District & Civic Center (LOC-01)
*The Facade of Total Consensus*

```
     ◄── Monumental Limestone Facade ──►
   ┌─────────────────────────────────────┐  ▲
   │ [ ] [ ] [ ] [ ] [ ] [ ] [ ] [ ] [ ] │  │ 18.0m Ministry Height
   │ ─── ─── ─── ─── ─── ─── ─── ─── ─── │  │
   │ [ ] [ ] [ ] [ ] [ ] [ ] [ ] [ ] [ ] │  ▼
===╡ █   █   █   █   █   █   █   █   █   ╞=============================== Surface Level 0.0m
   └─┴───┴───┴───┴───┴───┴───┴───┴───┴───┘
   ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ ◄── 1.5m - 2.5m Over-Slab Deck
   ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ ◄── Transfer Girders & Cellular Ribs
        │                       │
        │ 2.5m Dia. Caisson     │ 40m Natural Bastion
        │                       │
```

- **Urban Function & Morphology:** Constructed between 1976 and 1982 directly above the sealed quarry void of District 09. A 1.6 square-kilometer geometric plateau functioning as the administrative seat of the Consensus Government and the Bureau of Cadastral Rectification `[Design Recommendation]`.
- **Architectural Movement:** Post-Settlement Neoclassical Rationalism with Neo-Brutalist structural massing `[Design Recommendation]`.
  - Strict axial symmetry; uniform building heights (18.0 to 22.0 meters, exactly 4 stories plus recessed attic) `[Design Recommendation]`.
  - Complete suppression of individual ornamentation, religious iconography, or historical plaques pre-dating November 1968 `[Design Recommendation]`.
  - Massive, unembellished square pilasters (1.2m x 1.2m), heavy horizontal entablatures, and recessed window embrasures that conceal interior human activity `[Design Recommendation]`.
- **Primary Facade Materiality:**
  - Machine-honed white-to-buff Jura-style limestone cladding panels (1200mm x 600mm x 40mm) mounted over poured aerated concrete blocks `[Design Recommendation]`.
  - Ground-floor podiums constructed from polished dark charcoal granite slabs (honed finish, zero reflectivity, high compressive density) `[Design Recommendation]`.
  - Windows: Cold-rolled dark bronze extruded mullions framing dual-pane greenish float glass (low-emissivity coating, 15% transmission) `[Design Recommendation]`.
- **Streetscape & Street Furniture:**
  - Boulevards: Perfectly straight 24-meter-wide avenues paved in monolithic brushed granite slabs (800mm x 400mm) bordered by continuous cast-iron gutter channels `[Design Recommendation]`.
  - Flora: London Plane and Sycamore trees planted in strictly spaced 12.0-meter intervals inside flush cast-iron geometric grates (radial slit patterns, painted matte black `#1E1E22`) `[Design Recommendation]`.
  - Municipal Lighting: 6.5-meter-tall square cast-iron lamp standards painted dull basalt grey (`#3A3E45`), mounting sealed cylindrical sodium-vapor lanterns emitting pale monochrone amber (2200K, 60 Hz hum) `[Design Recommendation]`.
- **The Structural Secret (The Over-Slab Surface Reality):**
  - Walking across the center of Civic Park reveals subtle acoustic anomalies: footsteps over the flagstones do not produce the dull thud of deep earth, but a hollow, resonant metallic click `[Design Recommendation]`.
  - Every 60 meters along building footings, flush bronze ventilation grates (3.0m x 0.8m) exhale moist, lukewarm air (8°C–10°C) carrying a faint scent of damp lime, calcium efflorescence, and machine oil, vibrating with a constant 18.4 Hz sub-audible mechanical pulsation `[Design Recommendation]`.

---

### 2.3 District 02: West Junction & The Foundry (LOC-02)
*The Tactile Industrial Machine*

```
 +-------------------------------------------------------------------------+
 | LOC-02-A: WEST JUNCTION SIGNAL TOWER (1922)                              |
 |                                                                         |
 |  [Roof] Corrugated zinc hipped roof with 1.2m overhang & zinc finials   |
 |  [Fl 4] Operating Floor: 360° timber-framed sash windows, 64-lever frame|
 |  [Fl 3] Interlocking Locking-Bed Chamber: Riveted iron cross-bracing    |
 |  [Fl 2] Relay Room & Battery Banks: Heavy ceramic terminal boards       |
 |  [Fl 1] Track-Level Masonry Base: 600mm salt-glazed industrial red brick|
 +-------------------------------------------------------------------------+
```

- **Urban Function & Morphology:** An industrial railway gorge excavated 15.0 meters below the natural plain into St. Jude’s ironstone bedrock. Contains the western freight sorting classification yard, shunting bottlenecks, coal staging platforms, and locomotive service roundhouses `[Design Recommendation]`.
- **Architectural Movement:** Late Victorian to 1920s Heavy Industrial Utilitarianism `[Design Recommendation]`.
  - Massive load-bearing brick masonry, exposed hot-riveted steel lattice trusses, cast-iron bracket columns, and corrugated zinc cladding `[Design Recommendation]`.
  - Every surface is coated in decades of bituminous coal soot, steam locomotive valve-oil mist, and ferric brake-dust accumulation `[Design Recommendation]`.
- **Key Landmark: West Junction Signal Tower (LOC-02-A):**
  - Dimensions: Footprint 14.5m x 6.2m; total structural height 16.8 meters across four vertical functional tiers `[Engineering Estimate]`.
  - Base Structure: Floors 1 through 3 constructed of 600mm-thick wire-cut industrial engineering red brick laid in English bond, bedded in dark ash-lime mortar. Arched window openings with double-rowlock brick headers `[Design Recommendation]`.
  - Operating Floor (Floor 4): Cantilevered timber-framed observation cabin with continuous 360-degree multi-pane sash windows (cast-iron frames, 24 individual 400mm x 300mm panes per bay) overlooking the 16 parallel tracks of the throat switch `[Design Recommendation]`.
  - Roof: 35-degree hipped roof clad in corrugated 20-gauge galvanized zinc sheeting, heavily oxidized to a chalky dark grey (`#484D52`) with soot-black streaking along water-drip lines `[Design Recommendation]`.
- **Environmental Clutter & Rail Infrastructure:**
  - Overhead Wire Networks: Multi-tier copper telegraph cross-arms and mechanical signal wire runs carried on creosote-treated timber poles (250mm diameter) spanning alongside rail cuts `[Design Recommendation]`.
  - Switch Shacks & Tool Hovels: Modular 3.5m x 2.8m trackside sheds built of creosoted 200mm tongue-and-groove pine planks, heavy iron latch-bars, and cast-iron potbelly stove chimneys venting bituminous smoke `[Design Recommendation]`.
  - Ground Plane: Coarse basalt track ballast (40mm–60mm angular crushed stone, dark purple-grey `#36303B`), heavily contaminated with dripped locomotive cylinder oil and black coal fines. Track rails are rolled steel (54 kg/m profile) featuring pitted ferric rust along web faces and polished mirror chrome on the railhead contact crown `[Design Recommendation]`.

---

### 2.4 District 03: Old Canal & Wharves (LOC-03)
*The Subterranean Counter-Archive*

- **Urban Function & Morphology:** The oldest surviving commercial core of Vesper, lining the brackish, sluggish waters of the Lower Vesper Canal. Bounded by high stone retaining walls, tidal lock basins, and stagnant canal spurs `[Design Recommendation]`.
- **Architectural Movement:** 1880–1910 Maritime Mercantile and Industrial Warehousing `[Design Recommendation]`.
  - Deep-plan, four-to-five-story warehouse blocks featuring heavy timber internal post-and-beam frameworks behind load-bearing exterior brick shells `[Design Recommendation]`.
  - Street grid: Narrow, winding cobblestone alleyways (3.0m to 5.0m wide) intersected by iron gantry bridges, overhead hoisting beams, and timber catwalks linking opposing warehouse upper lofts `[Design Recommendation]`.
- **Materiality & Atmospheric Degradation:**
  - Salt-glazed red-and-brown engineering brick exhibiting white crystalline salt efflorescence and dark-green slimy algal growth extending 2.0 meters up from the tidal waterline `[Design Recommendation]`.
  - Quayside Timbering: Heavy pitch-pine pilings (350mm diameter) and square wharf bumper beams impregnated with dark creosote, splintered by iron barge collars, and encrusted with dried salt crusts `[Design Recommendation]`.
  - Canal Water Surface: Opaque, sluggish brackish water (`#1A2220`), exhibiting iridescent fuel-oil slicks, floating wood chips, and thick surface scum. Zero underwater transparency (absorption depth < 0.3 meters) `[Design Recommendation]`.
- **Key Landmark: Hess & Sons Bookbindery (LOC-03-A):**
  - Location: Subterranean basement level of a five-story 1894 warehouse at 14 Wharfinger Lane, sitting 1.8 meters below canal high-water level `[Design Recommendation]`.
  - Architectural Shell: Barrel-vaulted ceiling constructed of low-temperature red brick, reinforced with bolted iron tie-rods and turnbuckles spanning wall to wall `[Design Recommendation]`.
  - Interior Details: Damp flagstone floor with sump pump drain in the northeast corner; hand-cranked cast-iron book-presses (standing 1.8m tall, bolted to flagstones); drying racks hung from iron wires across the vault; long workbench of 75mm scarred oak planks stained with animal hide glue, potassium bichromate, iron gall ink, and lampblack `[Design Recommendation]`.
  - Storage Nook: In the rear archway, partially concealed behind stacks of heavy Dutch rag paper, sit rolled coils of 3mm sheet lead and oak binding boards used in the fabrication of *The Black Registry* `[Design Recommendation]`.

---

### 2.5 District 04: High Tenements & Eastern Quarry Slopes (LOC-04)
*The Vertical Quarry Enclave*

- **Urban Function & Morphology:** A dense, precarious residential district clinging to the steep 35-degree eastern ironstone cliffs of the basin. Home to foundry hands, rail switchmen, quarry laborers, and families relocated under falsified identity cards during the 1968 Settlement `[Design Recommendation]`.
- **Architectural Movement:** 1930s High-Density Tenement Masonry and Improvised Vertical Infrastructure `[Design Recommendation]`.
  - Five-to-six-story vertical tenement tenements built directly against the raw ironstone bedrock cut, utilizing stepped terrace footings `[Design Recommendation]`.
  - Rear windows of lower floors often look directly into a sheer wet rock face less than 1.5 meters away `[Design Recommendation]`.
- **Pedestrian Traversal & Mechanical Transport:**
  - "The Seven Hundred Steps": A continuous, grueling switchback staircase carved directly into the St. Jude's ironstone bedrock in 1898, bordered by 40mm galvanized iron gas-pipe handrails anchored via lead-poured iron stanchions `[Design Recommendation]`. Steps are worn down 25mm in the center tread from millions of workboot strikes `[Design Recommendation]`.
  - The Public Funicular Railway: A twin-track inclined cable railway (slope angle 38 degrees, track length 145 meters) built in 1914. Cars are riveted sheet-iron frames with slatted varnished oak bench interiors, pulled by a counterweighted 32mm steel haulage cable driven by a subterranean winding drum at the upper terminal `[Design Recommendation]`.
- **Architectural Details & Domestic Living Conditions:**
  - Facades: Rough-dressed St. Jude’s ironstone ashlar blocks (400mm x 250mm) alternating with banded courses of dark clinker brick `[Design Recommendation]`.
  - Balconies & Lightwells: Cantilevered cast-iron balconies with geometric balustrades; communal courtyard lightwells crisscrossed by hundreds of hemp laundry lines sagging with heavy wet wool garments `[Design Recommendation]`.
  - Communal Coal Bunkers: Cast-concrete bunkers (3.0m x 2.0m x 1.5m) located in internal entrance courtyards, lined with soot-blackened timber boards and filled with lump anthracite coal `[Design Recommendation]`.

---

### 2.6 District 05: University & Medical Terraces (LOC-05)
*The Monumental Archive of Cold Logic*

- **Urban Function & Morphology:** An elevated institutional plateau occupying the north-western promontory of the basin, 35 meters above the canal level. Sits on solid granite bedrock, conferring acoustic and physical isolation from the industrial basin floor `[Design Recommendation]`.
- **Architectural Movement:** Late 19th-Century Classical Academic Historicism and Institutional Victorian Gothic `[Design Recommendation]`.
  - Imposing ashlar granite facades, monumental limestone porticoes with Doric columns, towering 4.5-meter double-hung sash windows, and steep slate roofs with copper mansard gutters `[Design Recommendation]`.
- **Key Landmark: Vesper Municipal Institute of Geology:**
  - Facade: Grand 8-column pedimented portico of light grey St. Jude’s crinoidal limestone, with deeply incised foundation dedication carvings (partially chiseled away and filled with Portland cement during the 1968 renaming) `[Design Recommendation]`.
  - Interior Archive Halls: High-ceilinged (7.5m) barrel-vaulted galleries lined with multi-tiered cast-iron mezzanine catwalks. Houses floor-to-ceiling oak specimen drawers containing over 40,000 diamond-drill rock cores dating back to 1885 `[Design Recommendation]`.
- **Key Landmark: St. Jude’s Public Infirmary:**
  - Architectural Character: Sprawling four-story pavilion-plan hospital complex built in 1892. Long, drafty Nightingale wards with 4.8-meter ceilings, glossy off-white vitreous wall tiles (`#E8ECE9`), exposed overhead cast-iron radiator steam pipes wrapped in decaying canvas-lagging, and high clerestory windows designed for cross-ventilation `[Design Recommendation]`.
  - Basement Record Vault: Heavy cast-iron fireproof vault door (double throw-bolts, bronze combination dial) concealing the pre-Settlement admissions ledgers and the original pulmonary mortality files guarded by Nurse Marta Kroll `[Design Recommendation]`.

---

### 2.7 The Erased District 09: Historical Footprint & Ruin Stratum
*The Cadastral Ghost*

- **Pre-Destruction Reality (1895–1965):**
  - Total district cadastral footprint: **1.4 square kilometers (1,400,000 m²)** across 420 surveyed city blocks `[Design Recommendation]`.
  - Population in 1965: Approximately **34,000 working-class citizens**, primarily miners, quarry workers, foundry machinists, and railwaymen `[Design Recommendation]`.
  - Structural Character: 4-story high-density tenement blocks constructed of local dolomitic limestone and red brick, featuring ground-floor bakeries, grocers, union halls, and public schools `[Design Recommendation]`.
- **Destruction & Physical Dismantling (February 1967 – 1976):**
  - Following the Winter of Ashes firestorm and artillery cordon in February 1967 (~4,200 casualties), the 1.25 km² surface portion resting on solid bedrock was methodically bulldozed down to ground level `[Design Recommendation]`.
  - Upper floors (Levels 3 and 4) of all masonry structures were pushed into the adjoining 15.0-hectare excavation of Quarry Pit 03, generating **319,200 tonnes (~210,000 m³ bulk rubble at 1.52 t/m³)** of compacted structural talus `[Engineering Estimate]`.
- **The Missing Street Grid Paradox:**
  - Modern municipal maps printed by the Bureau depict District 01 directly abutting District 04, completely omitting any number "9" from municipal indices. Street names jump alphabetically; railway mileage markers skip from Mile 3.4 directly to Mile 4.6 `[Design Recommendation]`.
  - However, in the subterranean darkness of Tier 3, the physical ground floors and basements of District 09 remain standing in situ beneath the over-slab transfer girders, fully furnished with cast-iron cookware, cash registers, school desks, and rusted streetcars sitting on tracks that terminate in concrete bulkhead walls `[Design Recommendation]`.

---

## 3. THE SUNKEN WARD & THE DEEP: SUBTERRANEAN CIVIL ENGINEERING & ARCHITECTURE

```
 0.0m ── [SURFACE: DISTRICT 01 STREET LEVEL] ──────────────────────────────────────────
         │
-15.0m ── [TIER 1: THE SHALLOW TRANSIT] ───────────────────────────────────────────────
         Public Metro Line 2, Pneumatic Mail Conduits, Water Mains, Sealed Platform 0
         │
-45.0m ── [TIER 2: THE HEAVY INDUSTRIAL SPURS] ────────────────────────────────────────
         Coal Train Sorting Sidings, Drainage Sluices, Battery Transformer Rooms
         │
-85.0m ── [TIER 3: THE SUNKEN WARD & CORE TURBINES] ───────────────────────────────────
         15.0 ha Quarry Pit 03, 8 Rock Bastions, 120 Caissons, 210,000 m³ Rubble Bank,
         Preserved District 09 Storefronts, Rotary Turbines 1-6 (18.4 Hz), Vault 04
```

### 3.1 Structural Schedule & Volumetric Reality of Quarry Pit 03
The physical reality of Quarry Pit 03 and the Sunken Ward is governed by a rigorous civil-engineering volume balance reconciled in `DEC-0015` and `DEC-0021`:

```
┌──────────────────────────────────────────────────────────────────────────────────────────┐
│                   QUARRY PIT 03 & THE SUNKEN WARD: VOLUMETRIC LEDGER                     │
├───────────────────────────────────────────────┬───────────────────┬──────────────────────┤
│ Metric / Component                            │ Value             │ Classification Tag   │
├───────────────────────────────────────────────┼───────────────────┼──────────────────────┤
│ Total District 09 Footprint                   │ 1,400,000 m²      │ [Design Rec.]        │
│ Bedrock Terrace Footprint (Dismantled)        │ 1,250,000 m²      │ [Engineering Est.]   │
│ Quarry Pit 03 Total Footprint                 │ 150,000 m² (15 ha)│ [Engineering Est.]   │
│ - Main Oval Basin Dimensions                  │ 650m x 200m       │ [Engineering Est.]   │
│ - Main Oval Basin Area                        │ 102,100 m²        │ [Engineering Est.]   │
│ - Two Quarry Access & Staging Lobes           │ 47,900 m²         │ [Engineering Est.]   │
│ Average Excavated Depth                       │ 28.0 meters       │ [Engineering Est.]   │
│ Maximum Central Sump Depth                    │ 75.0 meters       │ [Engineering Est.]   │
│ Gross Excavated Quarry Envelope               │ 4,200,000 m³      │ [Engineering Est.]   │
├───────────────────────────────────────────────┼───────────────────┼──────────────────────┤
│ Retained Rock / Structure Offsets:            │                   │                      │
│ - 8 Unmined Natural Rock Bastions             │ 333,200 m³        │ [Calculated]         │
│ - Stepped Perimeter Highwall Benches (1:1)    │ 186,800 m³        │ [Engineering Est.]   │
│ Subtotal Retained Rock Mass                   │ 520,000 m³        │ [Engineering Est.]   │
│ Net Excavated Void Prior to Infill            │ 3,680,000 m³      │ [Calculated]         │
├───────────────────────────────────────────────┼───────────────────┼──────────────────────┤
│ Post-1967 Structural Infill & Construction:   │                   │                      │
│ - Compacted Rubble Infill (319,200 tonnes)    │ 210,000 m³        │ [Engineering Est.]   │
│ - Total Structural Concrete Envelope (Reconc.)│ 90,000 m³         │ [Calculated / Est.]  │
│   • 120 Drilled Caisson Shafts (2.5m dia)     │ 18,850 m³         │ [Calculated]         │
│   • Socket Caps & Spread Collars (120 units)  │ 12,960 m³         │ [Calculated]         │
│   • Post-Tensioned Transfer Girders & Rib Grid│ 31,500 m³         │ [Engineering Est.]   │
│   • Retaining Walls, Rock Anchors, Bracing    │ 26,690 m³         │ [Engineering Est.]   │
├───────────────────────────────────────────────┼───────────────────┼──────────────────────┤
│ NET ACCESSIBLE VOID (THE SUNKEN WARD)         │ 3,380,000 m³      │ [Calculated]         │
│ Net Accessible Void Percentage of Envelope    │ 80.48% Accessible │ [Calculated]         │
└───────────────────────────────────────────────┴───────────────────┴──────────────────────┘
```

---

### 3.2 The Eight Natural Rock Bastions
The 8 natural rock bastions are monolithic pillars of dolomitic limestone intentionally left unmined between 1885 and 1965 during open-cut extraction to prevent catastrophic slope failure along the highwalls `[Design Recommendation]`.

```
  ◄── 40m Crest Width ──►
  ┌─────────────────────┐  ▲
  │                     │  │
 /                       \ │ 28.0m Height (Frustum Profile)
/                         \│
┌───────────────────────────┐▼
◄───── 60m Base Width ──────►
```

- **Frustum Geometry & Mathematical Derivation:** Modeled as truncated pyramidal frustums using the formula $V = \frac{h}{3}(A_1 + A_2 + \sqrt{A_1 A_2})$:
  1. **Four Peripheral Highwall Buttresses (North & South Highwalls):**
     - Base at quarry floor ($-28\text{m}$): $60\text{m} \times 45\text{m}$ ($A_1 = 2,700\text{ m}^2$) `[Engineering Estimate]`.
     - Crest at surface deck level ($0\text{m}$): $40\text{m} \times 30\text{m}$ ($A_2 = 1,200\text{ m}^2$) `[Engineering Estimate]`.
     - Height: $h = 28.0\text{ meters}$ `[Engineering Estimate]`.
     - Calculated volume per buttress: $\frac{28}{3}(2,700 + 1,200 + \sqrt{2,700 \times 1,200}) = \frac{28}{3}(2,700 + 1,200 + 1,800) = \mathbf{53,200\text{ m}^3}$ `[Calculated]`.
     - Subtotal (4 units): $4 \times 53,200 = \mathbf{212,800\text{ m}^3}$ `[Calculated]`.
  2. **Four Central Island Monoliths (East-West Midline Spine):**
     - Base at quarry floor ($-28\text{m}$): $40\text{m} \times 40\text{m}$ ($A_1 = 1,600\text{ m}^2$) `[Engineering Estimate]`.
     - Crest at girder seat ($0\text{m}$): $25\text{m} \times 25\text{m}$ ($A_2 = 625\text{ m}^2$) `[Engineering Estimate]`.
     - Height: $h = 28.0\text{ meters}$ `[Engineering Estimate]`.
     - Calculated volume per monolith: $\frac{28}{3}(1,600 + 625 + \sqrt{1,600 \times 625}) = \frac{28}{3}(1,600 + 625 + 1,000) = \mathbf{30,100\text{ m}^3}$ `[Calculated]`.
     - Subtotal (4 units): $4 \times 30,100 = \mathbf{120,400\text{ m}^3}$ `[Calculated]`.
  3. **Total Bastions Rock Mass:** $212,800 + 120,400 = \mathbf{333,200\text{ m}^3}$ `[Calculated]`.
- **Surface Texture & Architectural Tooling:**
  - Lower 15 meters: Horizontally stepped extraction ledges (benches 2.0m wide x 4.0m drop) bearing vertical diamond-wire saw kerfs and 65mm pneumatic drill half-rounds spaced every 300mm `[Design Recommendation]`.
  - Upper 13 meters: Weathered, jagged natural fracture faces encrusted with white and pale orange calcium carbonate drip sheets and dark ironstone oxidation crusts `[Design Recommendation]`.
  - Bastion Crests: Topped with post-tensioned reinforced concrete corbel collars (4.0m thick) that form the seats for the cellular over-slab transfer girders `[Engineering Estimate]`.

---

### 3.3 The 120 Reinforced Concrete Caissons
The deep cavern zone of the Sunken Ward ($48,000\text{ m}^2$) is supported by an orthogonal grid of 120 drilled circular concrete caissons installed between 1976 and 1978 `[Engineering Estimate]`.

```
 +-------------------------------------------------------------------------+
 │ CAISSON ELEVATION DETAIL                                                │
 │                                                                         │
 │  [Deck Soffit] Post-Tensioned Box Girders (14m-18m spans)                │
 │  ═════════════════════════════════════════════════════════════════════  │
 │  [Pier Capital] 5.5m x 5.5m x 2.0m Reinforced Concrete Capital Spreader │
 │  ─────────────────────────────────────────────────────────────────────  │
 │  [Exposed Shaft] 2.5m Diameter Cylindrical Column (26.0m Free Height)   │
 │                  Slip-formed concrete with vertical timber board grain   │
 │                  Rusted steel rungs, calcium drips, maintenance conduits│
 │  ─────────────────────────────────────────────────────────────────────  │
 │  [Base Collar] 6.0m x 6.0m x 2.0m Spread Collar                         │
 │  ═════════════════════════════════════════════════════════════════════  │
 │  [Bedrock Socket] 2.5m Dia. Shaft Drilled 6.0m into Solid Granite Bedrock│
 +-------------------------------------------------------------------------+
```

- **Grid Spacing & Tributary Allocations:**
  - Grid Configuration: Orthogonal rows aligned along the north-south axis with an average spacing of $20.0\text{ meters}$ ($18.0\text{m}$ to $22.0\text{m}$ local variation to avoid subterranean faults) `[Engineering Estimate]`.
  - Tributary Deck Area: Exactly $400\text{ m}^2$ per caisson ($120 \times 400\text{ m}^2 = 48,000\text{ m}^2$, exactly accounting for the central cavern footprint) `[Calculated]`.
- **Geometric Dimensions & Component Volumes:**
  - Shaft Diameter: $2.5\text{ meters}$ `[Engineering Estimate]`.
  - Free Exposed Height: $26.0\text{ meters}$ (from floor slab to capital soffit) `[Engineering Estimate]`.
  - Bedrock Socket Depth: $6.0\text{ meters}$ drilled into solid underlying granite `[Engineering Estimate]`.
  - Total Cylinder Length: $32.0\text{ meters}$ `[Engineering Estimate]`.
  - Volume per shaft cylinder: $\pi \times (1.25\text{m})^2 \times 32.0\text{m} \approx 157.08\text{ m}^3$ `[Calculated]`.
  - Subtotal (120 shafts): $120 \times 157.08 = \mathbf{18,850\text{ m}^3}$ `[Calculated]`.
  - Spread Collars & Pier Capitals (non-overlapping prisms): $108\text{ m}^3$ per unit $\times 120 = \mathbf{12,960\text{ m}^3}$ `[Calculated]`.
- **Surface Texture & Environmental Aging:**
  - Concrete Finish: Cast in situ using vertical tongue-and-groove rough pine timber formwork; the concrete surface permanently retains 100mm-wide board textures, wood grain knots, and formwork seam bleed fins `[Design Recommendation]`.
  - Moisture Streaking: Continuous seepage of groundwater through the over-slab causes vertical white lime streaks (efflorescence) and pale green calcite deposits that run the full 26-meter height `[Design Recommendation]`.
  - Inspection Fixtures: Every fourth caisson features a vertical run of rusted steel climbing rungs (300mm wide, spaced 350mm) and a bolted 50mm galvanized conduit carrying dead 110V emergency lighting cables `[Design Recommendation]`.

---

### 3.4 The 210,000 m³ Rubble Deposit
- **Spatial Location & Geometry:** The **319,200 tonnes (~210,000 m³)** of crushed District 09 upper-story brick, mortar, and limestone rubble is not scattered randomly across the void. In 1974, municipal dump trucks graded the material into a continuous, compacted retaining embankment running along the **south-western highwall face** `[Engineering Estimate]`.
- **Embankment Dimensions:** Average crest thickness of 12.0 meters, sloping at a natural angle of repose (34 degrees) down to the quarry floor over a lateral run of 350 meters `[Engineering Estimate]`.
- **Visual Texture & Composition:**
  - A dense, compressed matrix of crushed red brick fragments, pulverized lime plaster, chunks of dressed ashlar limestone, and broken roof slates `[Design Recommendation]`.
  - Protruding Relics: Twisted 200mm steel I-beams, crushed cast-iron bathtubs, shattered porcelain washbasins, and iron window grates jut out from the compacted face `[Design Recommendation]`.
  - Stability & Footing: The rubble face is partially blanketed in a coarse coat of pneumatically sprayed Portland gunite (shotcrete, 50mm thick), which has fractured over three decades into irregular spiderweb fissures exuding orange ferric oxide water `[Design Recommendation]`.

---

### 3.5 The Preserved Ward Ruins & Subterranean Atmosphere
*The Entombed Streetscape*

```
 +-------------------------------------------------------------------------+
 │ THE SUNKEN WARD: ENTOMBED STREETSCAPE (TIER 3, -85m)                    │
 │                                                                         │
 │  [Over-Slab Soffit] Massive post-tensioned cellular concrete beams      │
 │  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  │
 │  [Atmosphere] Perpetual 8°C cold; 95% humidity; absolute pitch black    │
 │  [Ceiling Seepage] Calcium stalactites forming on 50-year-old crack lines│
 │  [Intact Ruin] Ground floors of Primary School #04, cobbles, gas lamps  │
 │  [Rail Clutter] 14 derailed wooden boxcars rotting into iron frames     │
 │  [Acoustic State] Heavy echo dampening: high frequencies absorbed by    │
 │                   rubble, leaving only the 18.4 Hz turbine thrum        │
 +-------------------------------------------------------------------------+
```

- **Intact Streetscape Elements:**
  - Cobblestone Paving: 12-meter-wide basalt cobblestone street intersections (Rue Saint-Florent / Mercer Way) preserved in complete alignment, complete with dry granite curbs and cast-iron catch basins `[Design Recommendation]`.
  - Primary School #04 Facade: The lower two stories of a red-brick civic schoolhouse stand intact under the shadow of Bastion 2. The classroom windows are shattered, but inside, timber student desks with cast-iron leg frames remain bolted to the oak floorboards. On the slate blackboard, faint chalk dates from **Friday, February 17, 1967** remain legible `[Design Recommendation]`.
  - Abandoned Transit: Three two-axle wooden municipal electric tramcars (painted cream and dark green, serials #14, #19, #22) sit derailed on their tracks; their canvas-covered roofs have caved in under falling plaster, exposing varnished mahogany interior benchwork and cast-brass hand-straps `[Design Recommendation]`.
- **Microclimate & Atmospheric Properties:**
  - Temperature & Humidity: Stagnant, perpetual **8.0°C (46.4°F)** year-round; relative humidity maintains a continuous **92% to 96%** `[Design Recommendation]`.
  - Water Dynamics: Constant drip of cold mineral-rich groundwater from over-slab joints. Calcium carbonate stalactites (lengths 50mm to 450mm) hang from concrete girder soffits, depositing matching white calcite stalagmites on the asphalt and cobblestone below `[Design Recommendation]`.
  - Air Quality: Faint odor of damp crushed limestone, stale stagnant puddle water, and ancient creosote. Pockets of heavy carbon dioxide collect in floor depressions below $-88\text{m}$ `[Design Recommendation]`.
- **Acoustic Reality:** High-frequency sounds (footsteps, metal clicks, speech) are rapidly absorbed by the porous rubble bank and shattered brickwork (reverberation time $RT_{60} < 1.2\text{ seconds}$), eliminating cavernous slapback. In their place, the entire void vibrates with the deep, visceral **18.4 Hz acoustic thrum** generated by the Rotary Turbines `[Design Recommendation]`.

---

### 3.6 Tiered Industrial Strata of The Deep

```
 +-------------------------------------------------------------------------+
 │ TIER 1: THE SHALLOW TRANSIT (-10m to -25m)                              │
 │ - Arched tunnels of white-glazed vitreous ceramic tiles (150mm x 75mm)  │
 │ - Twin copper pneumatic message conduits (100mm dia.) on brass saddles │
 │ - High-pressure cast-iron municipal water mains (400mm dia., black)    │
 │ - Sealed Platform 0: 90m passenger platform walled off behind 400mm     │
 │   double-course industrial red brick in November 1968                   │
 +-------------------------------------------------------------------------+
 │ TIER 2: THE HEAVY INDUSTRIAL SPURS (-30m to -60m)                       │
 │ - Raw-hewn St. Jude's ironstone cavern walls shored with 300mm pine ties│
 │ - Heavy coal classification sidings: 7 parallel tracks, 54 kg/m rail   │
 │ - Roaring concrete drainage sluices carrying 4,500 L/min mountain runoff│
 │ - Heavy cast-iron transformer vaults housing 10kV step-down oil units   │
 +-------------------------------------------------------------------------+
 │ TIER 3: THE SUNKEN WARD & CORE TURBINES (-70m to -150m)                 │
 │ - Rotary Turbine Hall (LOC-DEEP-TURB): 140m x 35m x 22m limestone vault│
 │   housing 6 colossal 12-meter bronze Francis impellers spinning at      │
 │   368 RPM, inducing the 18.4 Hz basin-wide infrasound frequency        │
 │ - Emergency Siding #04: Home of Locomotive #884 (Class 52 2-10-0 engine)│
 │ - Vault 04 (LOC-DEEP-V04): 20cm armored steel bulkhead redoubt          │
 +-------------------------------------------------------------------------+
```

#### Tier 1: The Shallow Transit (-10m to -25m)
- **Architectural Archetype:** Turn-of-the-century Municipal Metro Transit and Subterranean Logistics `[Design Recommendation]`.
- **Wall Cladding:** Continuous barrel-vaulted tunnels clad in rectangular white-glazed vitreous ceramic tiles (150mm x 75mm, bevel-edged), interrupted every 5.0 meters by cobalt blue border bands and relief cast-iron cable junction boxes `[Design Recommendation]`.
- **Pneumatic Network:** Overhead runs of twin copper pneumatic tubes (100mm outer diameter), tarnished with green verdigris patina, held in cast-brass ceiling brackets `[Design Recommendation]`.
- **Sealed Platform 0:**
  - Length: 90.0-meter curved passenger platform built in 1912 for the Central Municipal Mail Line `[Engineering Estimate]`.
  - The Wall: Severed completely from public access in November 1968 by a continuous 400mm-thick double-course wall of engineering red brick, roughly pointed with grey Portland mortar `[Design Recommendation]`.
  - Condition: Enclosed in absolute darkness; passenger benches of varnished pitch pine are covered in 5mm of undisturbed soot; enameled metal signs read *"Central Station — Postal Branch"* in faded black Fraktur lettering `[Design Recommendation]`.

#### Tier 2: The Heavy Industrial Spurs (-30m to -60m)
- **Architectural Archetype:** Deep Mining Extraction and Freight Marshalling `[Design Recommendation]`.
- **Rock Walls & Shoring:** Rough-blasted St. Jude’s ironstone walls with exposed chisel teeth and dynamite fracture ridges, stabilized by heavy square timber shoring sets (300mm x 300mm pitch pine posts and caps, treated with creosote `#221C16`) spaced every 2.5 meters `[Design Recommendation]`.
- **Drainage Sluices:** Open concrete flumes (1.8m wide x 1.2m deep) carrying rushing, turbulent mountain runoff water (flow rate ~4,500 L/min) roaring beneath heavy cast-iron floor gratings toward the lower sumps `[Engineering Estimate]`.
- **Atmosphere:** Constant swirling drafts generated by surface ventilation shafts; heavy ozone smell near electric transformer switchgear banks `[Design Recommendation]`.

#### Tier 3: Core Turbine Hall (LOC-DEEP-TURB) & Vault 04 (LOC-DEEP-V04)
- **Core Turbine Hall (LOC-DEEP-TURB):**
  - Dimensions: Massive excavation measuring 140 meters long, 35 meters wide, and 22 meters clear height, carved out of deep crystalline granite bedrock `[Engineering Estimate]`.
  - The Six Rotary Turbines: Arranged along the longitudinal midline. Each unit consists of a cast-iron spiral volute casing feeding a **12-meter-diameter phosphor bronze Francis runner impeller** `[Design Recommendation]`.
  - Mechanical Kinetics & Infrasound: Driven by deep geothermal steam and high-head drainage sluices, the impellers rotate at a steady 368 RPM. The harmonic blade-pass frequency creates the relentless, inescapable **18.4 Hz acoustic vibration** ($368\text{ RPM} / 60 \times 3\text{ blade interaction harmonic} = 18.4\text{ Hz}$) that resonates through the entire St. Jude's stone stratum `[Design Recommendation]`.
  - Overhead Cranes: A 50-tonne electric overhead gantry crane spanning the full 35-meter width of the hall, resting on riveted steel plate girder runways mounted to rock-bolted concrete corbels `[Design Recommendation]`.
- **Vault 04 (LOC-DEEP-V04):**
  - Architectural Function: Emergency civil-defense command bunker and classified records redoubt constructed in 1966 `[Design Recommendation]`.
  - External Bulkhead: Embedded into the solid granite face of the southern highwall. The entrance is a circular naval-style armored steel bulkhead door (diameter 2.2 meters, thickness **200mm solid rolled armor plate**, painted drab industrial green `#3B443B`), secured by eight perimeter locking lugs actuated via a central 800mm cast-bronze pilot handwheel `[Design Recommendation]`.
  - Decontamination Vestibule: A 4.0m x 3.0m airlock lined with lead-shielded steel panels (12mm thick), brass pressure-equalization valves, and pneumatic gasket seals `[Design Recommendation]`.
  - Primary Archive Chamber: A 16m x 12m rectangular bunker with concrete walls 1.5m thick, lined with explosion-proof incandescent fixtures in heavy brass cage housings, steel map cases, an active 1960s wire-recorder station, and the wooden desk where Elena Mercer maintains her stand with Volume II of *The Black Registry* `[Design Recommendation]`.

---

## 4. GREYHAVEN & THE COASTAL PERIPHERY

```
 +-------------------------------------------------------------------------+
 │ GREYHAVEN COASTAL PROFILE (LOC-GH-01 to 04)                             │
 │                                                                         │
 │   [Granite Headlands] Cold grey intrusive coastal granite bluffs        │
 │   [Peat Bog Valley] Acidic, spongy Sphagnum peat, stunted wind-bent pine │
 │   [Fishing Quays] Salt-weathered cedar shingles, creosote-soaked pilings │
 │   [The Split House] Ancestral stone cottage manifesting ontological tear│
 │   [Sanitarium] Neoclassical granite pavilion where 1968 Treaty was inked│
 │   [South Cemetery] Sunken slate headstones in peat; Martha's unmarked grave│
 +-------------------------------------------------------------------------+
```

### 4.1 Rural Maritime Landscape & Visual Identity
Located 28 kilometers southwest of Vesper, Greyhaven represents a complete morphological, geological, and acoustic departure from the claustrophobic ironstone city `[Design Recommendation]`.
- **Geological Foundation:** Rests on coastal intrusive pink-grey granite bedrock blanketed by deep marine clay and acidic peat bogs (1.5m to 4.0m thick) `[Design Recommendation]`.
- **Acoustic Sanctuary:** Because the granite and coastal peat completely sever contact with the St. Jude's ironstone formation, the 18.4 Hz turbine drone cannot propagate into Greyhaven. The acoustic environment is defined exclusively by natural sound: roaring ocean surf, wind buffeting pine needles, and the crying of gulls `[Design Recommendation]`.
- **Architectural Movement:** 18th-to-19th-Century Coastal Maritime Vernacular `[Design Recommendation]`.
  - Low-profile, single-story cottages with heavy fieldstone masonry walls (600mm thick), steep pitch roofs clad in split Atlantic white cedar shingles weathered to a silver-grey (`#8B9196`), and thick mortar chimneys `[Design Recommendation]`.
  - Fishing Piers & Fish-Houses: Built on heavy rough-hewn granite timber cribbing and round hemlock pilings. Walls are clad in rough-sawn horizontal pine weatherboarding coated in black pine tar or dark Swedish iron-vitriol red (`#682A2B`) `[Design Recommendation]`.

---

### 4.2 The Split House (LOC-GH-04)
*The Physical Manifestation of Ontological Rupture*

The ancestral Mercer family cottage sits isolated on a low granite knoll 1.5 kilometers north of Greyhaven village. The house serves as the definitive environmental metaphor for the central narrative conflict:

```
  ◄──────────── E A S T E R N   W I N G ───────────►◄─────────── W E S T E R N   W I N G ───────────►
  ┌─────────────────────────────────────────────────┬───────────────────────────────────────────────┐
  │ [The Neglected Consensus Half]                  │ [The Inhabited Counter-Archive Half]          │
  │ - Shingles rotted, moss-covered, leaking roof   │ - Fresh cedar shingles, tight copper flashing │
  │ - Boarded sash windows, broken glass            │ - Intact clean double-hung windows, wool drapes│
  │ - Interior: Cold, damp, empty hearth            │ - Interior: Warm peat fire burning in hearth  │
  │ - Mould on plaster, bare rotted floorboards     │ - Shelves stacked with dry ledgers, oil lamp  │
  │ - Dust-covered, water-logged furniture          │ - Operating tube radio, fresh coffee tin, bread│
  └─────────────────────────────────────────────────┴───────────────────────────────────────────────┘
  ◄═════════════════════════════════════════════════╩═══════════════════════════════════════════════►
                     CRACK LINE: 10mm shear fracture splitting central stone chimney
```

- **Exterior Morphological Division:**
  - Structural Footprint: Rectangular 14.0m x 7.5m traditional stone cottage divided exactly down its central structural spine by a vertical 10mm stress fracture cutting through the lime mortar and central chimney `[Design Recommendation]`.
  - Eastern Wing (Thomas’s Memory): Roof rafters have sagged 200mm; cedar shingles are rotten, curled, and encrusted with dark green carpet moss; window frames are weathered to bare silver pine with broken lower panes covered by warped plywood; gutter has torn free, leaving black rain streaks on the stone `[Design Recommendation]`.
  - Western Wing (Elena’s Active Field Post): Roof is freshly shingled in sound Alaskan yellow cedar; window sashes are freshly painted in black enamel; brick chimney cap is intact, venting sweet, pungent peat smoke; brass door latch is polished bright `[Design Recommendation]`.
- **Interior Environmental Contrast:**
  - Eastern Interior: Stagnant 4°C air; ceiling plaster has fallen in chunks onto bare water-stained pine boards; dead hearth choked with ancient grey ash and bird nests; absolute silence save for wind rattling the sash `[Design Recommendation]`.
  - Western Interior: Ambient temperature 19°C maintained by a cast-iron wood stove; neat pine desk illuminated by a brass kerosene hurricane lamp; walls lined with hand-drawn triangulation maps of Quarry Pit 03 and railway track charts; battery-powered shortwave receiver humming on the side table `[Design Recommendation]`.

---

### 4.3 Greyhaven Sanitarium (LOC-GH-02) & South Cemetery (LOC-GH-03)
- **Greyhaven Sanitarium (LOC-GH-02):**
  - Historic Significance: Site of the signing of **The Great Settlement (The Grand Compromise)** on November 14, 1968 `[Design Recommendation]`.
  - Architecture: A severe, three-story Neo-Palladian granite pavilion built in 1904 on an exposed sea cliff overlooking the salt marshes. Imposing rusticated granite base, arched first-floor windows, and a high central cupola `[Design Recommendation]`.
  - The Treaty Hall: Grand ground-floor conference salon featuring high wainscoting of dark Hungarian walnut, a monumental Carrara marble fireplace, and floor-to-ceiling French windows looking onto the fog-shrouded Atlantic. The massive oak conference table where the municipal partition maps were signed remains preserved as an untouched historical monument `[Design Recommendation]`.
- **South Cemetery (LOC-GH-03):**
  - Landscape: A waterlogged coastal graveyard situated in a hollow of low peat dunes, overgrown with sea lavender, bracken fern, and gorse bushes `[Design Recommendation]`.
  - Gravestones: Over 200 tilted, sinking headstones of dark Atlantic slate and grey granite, their carved inscriptions heavily eroded by maritime salt spray and acid rain `[Design Recommendation]`.
  - Martha Mercer’s Grave: Located in the unhallowed south-western corner along the stone boundary dyke. Marked only by a rough, unworked slab of St. Jude’s ironstone carrying no inscribed name—only an unpainted cast-iron railway track spike driven 100mm into a pre-drilled lead plug at its base (Thomas's secret physical counter-marker) `[Design Recommendation]`.

---

## 5. THE OUTSIDE: BEYOND KILOMETER 14

```
 [Kilometer 14.00] ── Boundary of Unsurveyed Agricultural Reserve
                     ▲
                     │ (Single-track 1920 mining line enters cutting)
 ┌───────────────────┴─────────────────────────────────────────────────────────────────────────────┐
 │ PHENOMENOLOGICAL CLASSIFICATION (BEYOND KM 14)                                                  │
 ├─────────────────────────┬───────────────────────────────────────────────────────────────────────┤
 │ A. Ordinary Geography   │ Coastal peat bogs, stunted pine barrens, basalt cliffs, 1920 rail cut │
 ├─────────────────────────┼───────────────────────────────────────────────────────────────────────┤
 │ B. Sensory Distortions  │ 45° Magnetite compass deflection, whiteout "Grey Sheet" advection fog │
 ├─────────────────────────┼───────────────────────────────────────────────────────────────────────┤
 │ C. Spatial Anomalies    │ 1. 6.4 km Azimuth Loop (closed traversal on flat terrain)            │
 │                         │ 2. Metric Non-Additivity (SM-14 to SM-18: rail 4.30 km vs opt 6.00 km)│
 │                         │ 3. Triangulation Violation (baseline 6.40 km vs 5.00 km legs)         │
 │                         │ 4. 18-minute acoustic replicas of impulse sounds                      │
 │                         │ 5. Displaced District 09 matter counter-anchoring 50m Euclidean zones │
 └─────────────────────────┴───────────────────────────────────────────────────────────────────────┘
```

### 5.1 The Unsurveyed Agricultural Reserve & 1920 Rail Corridor
Beyond the northern granite bluffs of Vesper Basin lies an officially redacted boundary marked on all municipal survey charts as **"Unsurveyed Agricultural Reserve"**. The physical portal to this region begins at **Kilometer 14.00** along the decommissioned railway spur `[Design Recommendation]`.
- **Historical Origin:** Built in 1920 by the St. Jude Iron Mining Syndicate to access remote coastal magnetite deposits; abandoned following catastrophic corporate liquidation in 1928 `[Design Recommendation]`.
- **Physical Rail Infrastructure:**
  - Trackbed: Unballasted single track laid directly over swampy peat and timber fascine mattresses. Sleepers are rotted 250mm x 150mm untreated hemlock ties, deeply split and sunken into black acidic mire `[Design Recommendation]`.
  - Rails: Lightweight 35 kg/m rolled Bessemer steel rails, heavily exfoliated with dark rust flakes. Fishplates are loose or missing bolts; track gauge varies erratically from 1435mm to 1460mm due to tie decay `[Design Recommendation]`.
  - Turnouts & Switch Stands: Harp-style ground-throw switch stands with rusted circular counterweights and oval red-enameled target vanes faded to chalky pink (`#C47A7A`), locked in place with frozen, corroded brass padlocks `[Design Recommendation]`.

---

### 5.2 Maritime Advection Fog ("The Grey Sheet") & Basalt Bluffs
- **"The Grey Sheet":**
  - Atmospheric Nature: A freezing, super-saturated maritime advection fog that rolls inland continuously from the northern sea, channelled between the basalt headlands `[Design Recommendation]`.
  - Optical Properties: Completely eliminates the sky-ground horizon line. Optical visibility drops to a uniform, diffuse **12.0 to 15.0 meters** `[Design Recommendation]`.
  - Illumination: Constant, directionless ambient scattering (Albedo: `#A2A8AE`). Shadows are completely non-existent; all objects emerge gradually as low-contrast dark silhouettes before resolving surface details `[Design Recommendation]`.
  - Thermal Profile: Ambient temperature hovers perpetually between **2.0°C and 5.0°C (35.6°F–41.0°F)**, inducing shivering, extreme fatigue, and severe hypothermia during prolonged exposure `[Design Recommendation]`.
- **Basalt Sea Bluffs:**
  - Topography: Sheer, vertical columnar basalt cliffs rising 40 to 65 meters above the churning sea, displaying hexagonal columnar jointing (columns 0.8m to 1.2m across) `[Design Recommendation]`.
  - Color & Mineralogy: Deep black-green to anthracite grey (`#1B1F1E`), displaying visible metallic crystalline veins of high-density magnetite ore `[Design Recommendation]`.

---

### 5.3 Surveying Paradoxes & Investigative Mechanics
*Codified Spatial Anomalies (DEC-0017, DEC-0024)*

The environmental design of The Outside incorporates four strictly defined, repeatable anomalies that challenge Euclidean geometric principles. The player investigates these phenomena using physical surveying instruments (brass theodolite, tensioned 20m invar chain, surveyor's compass, notebook triangulation):

```
 +-------------------------------------------------------------------------+
 │ METRIC NON-ADDITIVITY PARADOX: PERMANENT BEDROCK MONUMENTS              │
 │                                                                         │
 │               [SM-14: Bedrock Bronze Disc @ Km 14.00]                   │
 │                               │                                         │
 │   Physical Rail Route         │ Direct Optical Chained Sightline        │
 │   Follows curved steel track  │ Across unobstructed flat peat marsh     │
 │   with surveyor's wheel:      │ Standard 20m invar chain @ 100N tension:│
 │   - SM-14 to SM-16 = 3.20 km  │ - SM-14 to SM-18 DIRECT = 6.00 km       │
 │   - SM-16 to SM-18 = 1.10 km  │                                         │
 │   TOTAL RAIL PATH = 4.30 km   │ DIRECT OPTICAL PATH = 6.00 km           │
 │                               │                                         │
 │   PARADOX: The straight optical chord is 1.70 km LONGER than the       │
 │            physical curved path connecting identical bedrock markers!   │
 +-------------------------------------------------------------------------+
 │ TRIANGLE INEQUALITY VIOLATION (Survey Stakes A, B, C across flat peat): │
 │   Leg A -> B = 3.20 km                                                  │
 │   Leg B -> C = 1.80 km  (Sum of two legs = 5.00 km)                    │
 │   Baseline A -> C Direct = 6.40 km                                      │
 │   Contradiction: 6.40 km > 5.00 km  [Violates metric space axiom]       │
 +-------------------------------------------------------------------------+
```

1. **The 6.4-Kilometer Azimuth Deflection Loop:**
   - Visual Phenomenon: A traveler traversing the flat, open peat marsh who strictly ignores magnetic compasses—instead maintaining a rigorous optical line of sight by aligning wooden ranging rods or tensioned piano wire—inevitably returns to their own starting stake after covering exactly **6.40 kilometers** of forward progress `[Design Recommendation]`.
   - The terrain is demonstrably level and unobstructed; no visual curvature or physical obstacle forces a turn `[Design Recommendation]`.
2. **Metric Non-Additivity (Defined Surveying Paradox):**
   - Monumentation: Two permanent bronze benchmark discs stamped `SM-14` (Kilometer 14.00) and `SM-18` (abandoned mining turnout) drilled and pinned into solid granite bedrock outcroppings `[Design Recommendation]`.
   - The Measurement Conflict:
     - Following the physical rail curve with a calibrated surveyor's wheel records **4.30 kilometers** total path `[Calculated]`.
     - Chaining a direct, unobstructed optical line-of-sight between the identical markers across flat open peat using a standardized 20m invar chain measures **6.00 kilometers** `[Calculated]`. The straight optical path is measurably **1.70 km longer** than the curved physical track `[Calculated]`.
   - Triangulation Axiom Failure: Three stable survey stakes ($A$, $B$, $C$) placed across the marsh yield measured legs of $A \to B = 3.20\text{ km}$ and $B \to C = 1.80\text{ km}$, yet the direct straight baseline $A \to C$ measures **$6.40\text{ km}$**, violating the metric space triangle inequality ($6.40 > 3.20 + 1.80 = 5.00$) `[Calculated]`.
3. **The 18-Minute Acoustic Recurrence:**
   - Any sharp, high-energy acoustic impulse produced in the marsh (e.g., striking an iron rail with a 14-lb sledgehammer) produces an immediate cliff echo (7 to 10 seconds), followed by faint, perfect acoustic replicas returning through the fog at exact **18-minute intervals**, repeating up to three times with decaying amplitude regardless of wind speed or atmospheric pressure `[Design Recommendation]`.
4. **Displaced Matter Counter-Anchors:**
   - In deep peat hollows at Kilometer 18, physical municipal relics from erased District 09 protrude from the mire: cast-iron municipal lampposts with intact glass lanterns, carved granite boundary stones with erased street numbers, and red cast-iron postal boxes `[Design Recommendation]`.
   - Within a **50-meter radius** of these physical relics, Euclidean spatial rules are restored: compass needles stabilize, optical distances match physical chained measurements, and the 6.4 km looping effect ceases `[Design Recommendation]`.

---

## 6. SURFACE MATERIALITY, COLOR SCHEMES & WEATHERING DYNAMICS

### 6.1 Master Chromatic Hex Palettes
To ensure rigorous visual cohesion, each macro-territory operates within a dedicated 5-color chromatic system:

```
┌──────────────────────────────────────────────────────────────────────────────────────────┐
│                             REGIONAL CHROMATIC HEX PALETTES                              │
├─────────────────┬───────────┬───────────┬───────────┬───────────┬───────────┬────────────┤
│ Environment     │ Color 1   │ Color 2   │ Color 3   │ Color 4   │ Color 5   │ Mood Tone  │
├─────────────────┼───────────┼───────────┼───────────┼───────────┼───────────┼────────────┤
│ District 01     │ #D8D4C8   │ #4A4E54   │ #1E2024   │ #A68038   │ #4A2E5B   │ Sterile,   │
│ (Civic Park)    │ Limestone │ Slate Grout│ Granite   │ Dial Brass│ Purple Ink│ Repressive │
├─────────────────┼───────────┼───────────┼───────────┼───────────┼───────────┼────────────┤
│ District 02     │ #42261D   │ #1C1D21   │ #6B3428   │ #8B2626   │ #D98C3A   │ Choking,   │
│ (Foundry Cut)   │ Eng. Brick│ Soot Iron │ Rust Web  │ Signal Red│ Coal Flare│ Industrial │
├─────────────────┼───────────┼───────────┼───────────┼───────────┼───────────┼────────────┤
│ District 03     │ #593529   │ #2D332F   │ #221C16   │ #7A8073   │ #1A2220   │ Damp, Rot, │
│ (Old Wharves)   │ Salt Brick│ Canal Muck│ Creosote  │ Lichen    │ Slick Scum│ Maritime   │
├─────────────────┼───────────┼───────────┼───────────┼───────────┼───────────┼────────────┤
│ District 04     │ #4F4B46   │ #2B2A28   │ #8C4035   │ #A89F91   │ #2E3844   │ Tenacious, │
│ (Tenements)     │ Ironstone │ Anthracite│ Firebrick │ Wash Wool │ Slate Roof│ Domestic   │
├─────────────────┼───────────┼───────────┼───────────┼───────────┼───────────┼────────────┤
│ The Deep        │ #2A2C2B   │ #141615   │ #B5884B   │ #5A695C   │ #8C9990   │ Pitch,     │
│ (Sunken Ward)   │ Wet Dolom.│ Sump Black│ Turbine Br│ Calcite   │ Lead Sheet│ Resonant   │
├─────────────────┼───────────┼───────────┼───────────┼───────────┼───────────┼────────────┤
│ Greyhaven       │ #8B9196   │ #543D2B   │ #283629   │ #682A2B   │ #A4AAB0   │ Weathered, │
│ (Coastal Marshes│ Shingle Ag│ Wet Peat  │ Pine Needl│ Falu Red  │ Sea Salt  │ Sanctuary  │
├─────────────────┼───────────┼───────────┼───────────┼───────────┼───────────┼────────────┤
│ The Outside     │ #A2A8AE   │ #1B1F1E   │ #3D281D   │ #4E5452   │ #C47A7A   │ Horizonless│
│ (Beyond Km 14)  │ Whiteout  │ Basalt    │ Peat Mire │ Cold Moss │ Faded Vane│ Void       │
└─────────────────┴───────────┴───────────┴───────────┴───────────┴───────────┴────────────┘
```

---

### 6.2 Master Materiality Specifications (OpenGL 3.3 Compatibility PBR)
Every environmental material is defined according to the Godot 4 Compatibility PBR standard (Albedo, Roughness, Metallic, Normal, and Ambient Occlusion) packed into an **ORM (Occlusion-Roughness-Metallic)** texture:

```
┌──────────────────────────────────────────────────────────────────────────────────────────┐
│                         MASTER ENVIRONMENTAL MATERIAL MATRIX                             │
├──────────────────────┬─────────────┬──────────────┬──────────────┬─────────────┬─────────┤
│ Material Name        │ Albedo Base │ Roughness    │ Metallic     │ Normal Str. │ Max Res │
├──────────────────────┼─────────────┼──────────────┼──────────────┼─────────────┼─────────┤
│ St. Jude's Ironstone │ #4F4B46     │ 0.85 – 0.95  │ 0.05 – 0.10  │ 1.2 (Deep)  │ 1024²   │
│ Honed Civic Limest.  │ #D8D4C8     │ 0.45 – 0.60  │ 0.00         │ 0.4 (Subtle)│ 1024²   │
│ Salt-Glazed Red Brick│ #593529     │ 0.30 – 0.70  │ 0.00         │ 1.0 (Rough) │ 1024²   │
│ Creosote Pine Timber │ #221C16     │ 0.70 – 0.85  │ 0.00         │ 0.8 (Grain) │ 512²    │
│ Soot-Caked Cast Iron │ #1C1D21     │ 0.80 – 0.90  │ 0.75 – 0.85  │ 0.9 (Pitted)│ 512²    │
│ Phosphor Turbine Brz │ #B5884B     │ 0.35 – 0.50  │ 0.90 – 0.95  │ 0.6 (Lathe) │ 512²    │
│ Rolled Sheet Lead    │ #5A6166     │ 0.55 – 0.70  │ 0.80 – 0.85  │ 0.5 (Dented)│ 512²    │
│ Coastal Marine Peat  │ #3D281D     │ 0.90 – 0.98  │ 0.00         │ 1.4 (Spongy)│ 512²    │
│ Polished Rail Crown  │ #C8CED4     │ 0.12 – 0.20  │ 0.98 – 1.00  │ 0.2 (Smooth)│ 256²    │
│ Calcite Stalactite   │ #E2E4DE     │ 0.40 – 0.65  │ 0.00         │ 1.1 (Fluted)│ 256²    │
└──────────────────────┴─────────────┴──────────────┴──────────────┴─────────────┴─────────┘
```

---

### 6.3 Wetness & Rainfall Accumulation Model
Because rainfall, damp air, and standing water are ubiquitous across Vesper Basin and The Deep, surfaces dynamically transition across three wetness states `[Design Recommendation]`:

```
   DRY SURFACE                  DAMP SURFACE                 FLOODED / PUDDLE
 ┌─────────────┐             ┌─────────────┐             ┌─────────────┐
 │ Roughness:  │  Rainfall   │ Roughness:  │ Saturation  │ Roughness:  │
 │ 0.80 - 0.95 │ ──────────> │ 0.35 - 0.55 │ ──────────> │ 0.02 - 0.05 │
 │ Albedo:     │ Attenuation │ Albedo:     │  Specular   │ Albedo:     │
 │ 100% Value  │             │ 70% Value   │  Dominance  │ Water Color │
 └─────────────┘             └─────────────┘             └─────────────┘
```

- **Albedo Darkening Coefficient:** Water film replaces air-mineral surface interfaces, reducing internal diffuse reflection. Porous stones (St. Jude's Ironstone, brick, mortar) darken their base albedo value by **30% to 40%** when fully wetted `[Design Recommendation]`.
- **Roughness Attenuation:** Surface micro-roughness is filled by water tension, reducing perceived roughness down to $0.35$ for damp stone and $0.05$ for standing water puddles, dramatically intensifying directional specular highlights from streetlamps and lanterns `[Design Recommendation]`.
- **Specular Response:** In Godot Compatibility mode, puddles are realized using simple 2D noise masks blended into the roughness channel, avoiding costly screen-space reflection passes `[Design Recommendation]`.

---

### 6.4 Environmental Weathering & Degradation Stains
Environmental credibility relies on physical weathering patterns layered over base architecture:
1. **Lime Efflorescence (Calcium Carbonate Leach):**
   - Appearance: Chalky, crusty white streaks (`#E5E8E2`) dripping vertically from masonry mortar joints, concrete over-slab seams, and brick retaining walls `[Design Recommendation]`.
   - Physics: Rainwater leaches calcium hydroxide from Portland cement, which reacts with atmospheric carbon dioxide at the wall face to deposit insoluble calcite crystals `[Design Recommendation]`.
2. **Bituminous Coal Soot Runoff:**
   - Appearance: Pitch-black, greasy vertical streaks (`#121314`) accumulating under architectural sills, cornice drip-edges, and downspout leaks across Districts 02 and 04 `[Design Recommendation]`.
3. **Ferric Oxide (Rust Bleed):**
   - Appearance: Brilliant burnt-orange to dark reddish-brown trails (`#823A1E`) originating from structural steel rivets, iron tie-rods, anchor plates, and window lintels, spreading downward across grey stone facades `[Design Recommendation]`.
4. **Creosote Leaching:**
   - Appearance: Dark amber-brown oily staining (`#261B12`) weeping from timber railway ties and wharf pilings, settling into surrounding gravel ballast and water surfaces `[Design Recommendation]`.
5. **Maritime Salt Encrustation & Lichen:**
   - Appearance: Crystalline white salt crusts coating windward timber shingle faces in Greyhaven, coupled with patches of crustose yellow-orange lichen (*Xanthoria parietina*, `#C28B2B`) and olive-green wall moss on shaded north-facing granite boulders `[Design Recommendation]`.

---

## 7. OCCLUSION ARCHITECTURE & DRAW-CALL BUDGET ENFORCEMENT

### 7.1 Street Grid Geometry & Sightline Breaking
To maintain the non-negotiable **180 to 250 draw call ceiling** on the NVIDIA GeForce G210 under Godot's OpenGL 3.3 Compatibility Renderer, environmental architecture is deliberately engineered to break long optical sightlines `[Design Recommendation]`:

```
                           SIGHTLINE BREAKING STREET GEOMETRY
                           
         ┌───────────────────┐               ┌───────────────────┐
         │                   │               │                   │
         │   BUILDING BLOCK  │               │   BUILDING BLOCK  │
         │                   │               │                   │
 ════════╪═══════════════════╧═══════════════╪═══════════════════╪════════
  Player │             [Z-BEND CHOKE POINT]  │   BLOCKED SIGHT   │
  Camera │ ───►                 \            │   (Culled Scene)  │
         │                       \ ───►      │                   │
 ════════╪═══════════════════╤═══════════════╪═══════════════════╪════════
         │                   │               │                   │
         │   BUILDING BLOCK  │               │   BUILDING BLOCK  │
         │                   │               │                   │
         └───────────────────┘               └───────────────────┘
```

- **Urban Choke Points:** No city street in Districts 02, 03, or 04 maintains an unobstructed linear sightline exceeding **45 meters**. Roads feature 30-degree dog-leg kinks, arched masonry gate portals, and railway overpasses that function as natural solid occluders `[Design Recommendation]`.
- **Porticoes & Deep Colonnades:** In District 01, monumental government ministries utilize deep 4.0-meter vaulted colonnades that block the camera's view of interior courtyards and perpendicular cross-streets, allowing Godot's frustum and occlusion culling systems to discard hidden city blocks `[Design Recommendation]`.
- **Tunnel Portals & Subterranean Curves:** In The Deep, subway tubes and freight spurs curve horizontally every 35 to 50 meters ($R = 120\text{m}$ to $180\text{m}$), preventing the engine from rendering more than two tunnel segments simultaneously `[Design Recommendation]`.

---

### 7.2 Occluder Polygon Placement Strategy in Godot
- **Implementation Mechanism:** Static occluder geometry is authored directly within Godot using `OccluderInstance3D` paired with low-polygon `ArrayOccluder3D` or `QuadOccluder3D` meshes `[Design Recommendation]`.
- **Occluder Rules:**
  - Occluders must never trace intricate architectural details (mouldings, window frames). They are authored as solid, convex rectangular boxes fitted strictly inside building cores and heavy retaining walls `[Design Recommendation]`.
  - In District 01, single horizontal quad occluders (100m x 100m) are positioned inside the over-slab deck to completely isolate the subterranean Sunken Ward from surface rendering passes `[Design Recommendation]`.
  - In The Deep, each of the 8 rock bastions contains an internal 6-sided frustum occluder, completely hiding props and caissons situated on the opposite side of the monolith `[Design Recommendation]`.

---

### 7.3 MultiMeshInstance3D Batching Strategy & Multi-Pass Draw-Call Architecture
*(Formally revised under Defect Remediation DEF-A7-001 / Directive Item R-01)*

#### 7.3.1 Retraction of Unconditional Claims & The Multi-Pass Draw-Call Reality
The preliminary assumption that 5,495 environmental instances across nine prop categories can be unconditionally collapsed into "exactly 9 draw calls" is **hereby formally retracted** `[Design Recommendation]`. Under the Godot 4.7.2 Compatibility Renderer (`gl_compatibility` / OpenGL 3.3 Core Profile) running on the target NVIDIA GeForce G210, a `MultiMeshInstance3D` does not produce an invariant single draw call. Instead, the runtime draw-call footprint is governed by the multi-pass rendering pipeline:

$$\text{DrawCalls} = \sum_{c \in \text{VisibleChunks}} \sum_{m \in \text{MultiMeshes}_c} \left[ M_{\text{surfaces}}(m) \times \left(1 + N_{\text{shadow\_cascades}}(m)\right) + \text{Passes}_{\text{lights}}(m) \right]$$

Where:
- $M_{\text{surfaces}}(m)$: The number of discrete sub-mesh surfaces (materials) bound to the underlying `Mesh` resource.
- $N_{\text{shadow\_cascades}}(m)$: The number of directional PSSM shadow cascades / splits whose view frustums intersect the MultiMesh's Axis-Aligned Bounding Box (AABB) when `cast_shadow != SHADOW_CASTING_SETTING_OFF`.
- $\text{Passes}_{\text{lights}}(m)$: Any secondary additive forward lighting passes incurred if non-directional lights intersect the geometry.

**The Surface & Shadow Multiplier Hazard [Engineering Estimate]:**  
If an environmental asset is authored with two distinct surfaces (for example, a cast-iron streetlamp housing with a separate emissive glass pane surface, so $M_{\text{surfaces}} = 2$), and its instances cross the boundary of both PSSM directional shadow splits ($N_{\text{shadow\_cascades}} = 2$):
$$\text{DrawCalls} = 2 \times (1 + 2) + 0 = 2 \times 3 = \mathbf{6\text{ draw calls per MultiMesh}}$$
If left unoptimized and un-chunked, nine multi-surface prop collections intersecting both shadow splits would generate between **27 and 54 draw calls**, completely destabilizing the frame budget on the 16 CUDA cores and 8.0 GB/s memory bus of the G210.

---

#### 7.3.2 Single-Surface Mesh Conformance & Offline Baking Protocol
To strictly control the surface multiplier ($M_{\text{surfaces}}$), all environmental assets designated for hardware instancing must adhere to two mandatory architectural gates:
1. **Single-Surface ArrayMesh Mandate ($M_{\text{surfaces}} = 1$) [Design Recommendation]:**
   - Every mesh utilized in a `MultiMeshInstance3D` must contain **exactly one surface** binding a single unified PBR material.
   - Imported meshes from AI generation pipelines (Meshy / Tripo GLB) or CC0 repositories (Poly Haven) containing multiple materials must be processed offline via automated Python scripts: geometry is combined into a single `ArrayMesh`, and all textures are merged onto a shared 512x512 or 1024x1024 texture trim sheet.
   - For assets requiring local illumination (e.g., streetlamps, lanterns), glass and emissive components must not exist as separate sub-mesh surfaces; emissive response is mapped directly via the emissive channel of the single ORM/PBR material, or decoupled into an unshaded, unshadowed billboard quad.
2. **Mesh Resource Pipeline Correction [Verified Capability]:**
   - Raw Godot CSG nodes (`CSGBox3D`, `CSGCylinder3D`, `CSGCombiner3D`) are procedural scene nodes, not static `Mesh` resources, and **cannot be assigned directly to the `mesh` property of a `MultiMeshInstance3D`**.
   - All CSG blockout components (cobblestones, track sleepers, rails, climbing rungs, stalactites) must be baked offline into static `.res` / `.tres` `ArrayMesh` resources prior to instancing.

---

#### 7.3.3 Shadow Casting Optimization & Flag Enforcement
Under Godot 4 Compatibility mode, each shadow-casting MultiMesh intersecting a PSSM split requires an independent depth rendering pass. To eliminate unnecessary shadow-depth draw calls, shadow casting is strictly bifurcated based on ground elevation and visual impact:
1. **Ground-Level Repeating Instances (`cast_shadow = SHADOW_CASTING_SETTING_OFF`) [Design Recommendation]:**
   - Assets: Granite Street Cobblestones, Railway Crushed Ballast Bed, Creosoted Track Sleepers, Caisson Wall Climbing Rungs, and Flat Debris Clusters.
   - Justification: Ground-coplanar elements lie directly on the horizontal terrain or floor slab. Casting shadows from individual 12-triangle cobblestones or ballast gravel introduces severe self-shadow acne on the G210, wastes pixel rasterization fill rate, and incurs 1 to 2 shadow draw calls per chunk with zero perceptible visual depth. 
   - These assets maintain `receive_shadows = true`, ensuring they receive full high-contrast shadows cast by buildings, characters, locomotives, and street furniture.
   - **Savings:** Completely eliminates shadow-pass overhead ($N_{\text{shadow\_cascades}} = 0$), fixing their draw-call cost to exactly **1 draw call per visible chunk** `[Engineering Estimate]`.
2. **Elevated & Structural Instances (`cast_shadow = SHADOW_CASTING_SETTING_ON`) [Design Recommendation]:**
   - Assets: Cast-Iron Streetlamps, Heavy Steel Rail Segments, Calcium Stalactites, and Elevated Debris Piles.
   - Justification: These objects possess prominent vertical silhouettes ($>0.5\text{m}$ relief) that cast essential ground shadows, reinforcing grounding and depth.
   - Because they conform to the single-surface rule ($M = 1$), their draw-call cost is strictly bounded to $1 \text{ (color)} + 1\text{ to }2 \text{ (shadow)} = \mathbf{2\text{ to }3\text{ draw calls per visible chunk}}$ `[Engineering Estimate]`.

---

#### 7.3.4 Spatial Grid Chunking Architecture ($32\text{m} \times 32\text{m}$)
In Godot 4, a `MultiMeshInstance3D` possesses a **single monolithic Axis-Aligned Bounding Box (AABB)** encompassing every instance assigned to it. The engine does NOT perform per-instance frustum or occlusion culling on the CPU or GPU under OpenGL 3.3.

```
 +─────────────────────────────────────────────────────────────────────────+
 │ SPATIAL CHUNKING ARCHITECTURE (32m x 32m GRID SECTORS)                  │
 │                                                                         │
 │  [ Monolithic AABB Failure ]                                            │
 │   Single 400m MultiMesh: Camera touches 1 corner ──► 5,495 instances   │
 │   (75,000 tris) submitted to G210, completely defeating 45m Z-bends!    │
 │                                                                         │
 │  [ Mandated Spatial Partitioning ]                                      │
 │   District partitioned into 32m x 32m spatial cells.                    │
 │  ┌──────────────┬──────────────┬──────────────┬──────────────┐          │
 │  │ Chunk [0, 0] │ Chunk [1, 0] │ Chunk [2, 0] │ Chunk [3, 0] │          │
 │  │ CULLED (100%)│ CULLED (100%)│ CULLED (100%)│ CULLED (100%)│          │
 │  ├──────────────┼──────────────┼──────────────┼──────────────┤          │
 │  │ Chunk [0, 1] │ Chunk [1, 1] │ Chunk [2, 1] │ Chunk [3, 1] │          │
 │  │ CULLED (100%)│ VISIBLE (45m)│ VISIBLE (45m)│ CULLED (100%)│          │
 │  │              │ (Active AABB)│ (Active AABB)│              │          │
 │  └──────────────┴──────────────┴──────────────┴──────────────┘          │
 │  Frustum & Occluder culling drops 75% to 85% of instances before GPU!   │
 +────────────────────────────────────────────────────────────────---------+
```

- **The Spatial Chunking Mandate [Design Recommendation]:**
  - All environmental MultiMeshes are strictly partitioned into localized spatial cells measuring **$32.0\text{ meters} \times 32.0\text{ meters}$** in the horizontal plane.
  - Each $32\text{m} \times 32\text{m}$ sector instantiates an independent `MultiMeshInstance3D` for only those prop types residing within its boundary, generating tight, localized AABBs `[Engineering Estimate]`.
- **Culling Synergy with Urban Geometry:**
  - Thanks to the 45-meter Z-bend choke points, porticoes, and tunnel curvatures established in Section 7.1, **no more than 2 to 4 spatial chunks are ever visible simultaneously** from any camera vantage point `[Engineering Estimate]`.
  - The remaining 12 to 20 spatial chunks are completely culled at the scene-tree boundary by Godot's CPU frustum and portal occlusion checks, submitting zero vertices and zero draw calls to the G210 `[Engineering Estimate]`.

---

#### 7.3.5 Reconciled MultiMesh Hardware Batching Schedule
The updated, empirically grounded batching schedule accounts for spatial chunking, single-surface baking, shadow flags, and multi-pass draw calls:

```
┌───────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
│                       RECONCILED MULTIMESH BATCHING & MULTI-PASS DRAW-CALL SCHEDULE                           │
├──────────────────────────────┬─────────────────────────────┬─────────────┬────────────┬─────────┬─────────────┤
│ Prop / Architectural Object  │ Verified Mesh Source        │ Tris / Inst │ Total World│ Shadow  │ Draw Calls  │
│                              │ (Single-Surface Mandate)    │             │ Instances  │ Setting │ (1 Chunk)   │
├──────────────────────────────┼─────────────────────────────┼─────────────┼────────────┼─────────┼─────────────┤
│ Granite Street Cobblestones  │ Baked ArrayMesh (from CSG)  │ 12 tris     │ 2,500 units│ OFF     │ 1 Draw Call │
│ Railway Crushed Ballast Bed  │ Baked ArrayMesh (Poly Haven)│ 36 tris     │ 1,200 units│ OFF     │ 1 Draw Call │
│ Creosoted Track Sleepers     │ Baked ArrayMesh (from CSG)  │ 12 tris     │ 450 units  │ OFF     │ 1 Draw Call │
│ Heavy Steel Rail Segments    │ Baked ArrayMesh (from CSG)  │ 48 tris     │ 150 units  │ ON (1-2)│ 2–3 D.Calls │
│ Sycamore Tree-Grates         │ Baked ArrayMesh (from CSG)  │ 24 tris     │ 80 units   │ OFF     │ 1 Draw Call │
│ Cast-Iron Streetlamps        │ Single-Surface GLB (Meshy)  │ 320 tris    │ 45 units   │ ON (1-2)│ 2–3 D.Calls │
│ Caisson Wall Climbing Rungs  │ Baked ArrayMesh (from CSG)  │ 16 tris     │ 600 units  │ OFF     │ 1 Draw Call │
│ Debris: Crushed Brick Piles  │ Single-Surface GLB (Tripo)  │ 180 tris    │ 120 units  │ ON (1-2)│ 2–3 D.Calls │
│ Calcium Stalactites          │ Baked ArrayMesh (from CSG)  │ 28 tris     │ 350 units  │ ON (1-2)│ 2–3 D.Calls │
├──────────────────────────────┴─────────────────────────────┴─────────────┴────────────┴─────────┴─────────────┤
│ TYPICAL VISIBLE SCENE DRAW-CALL FOOTPRINT (2 TO 4 ACTIVE 32m x 32m CHUNKS IN FRUSTUM) [Engineering Estimate]   │
│ - Color Pass (All 9 prop types across 2 to 4 active chunks):               18 to 36 draw calls                │
│ - Shadow Depth Passes (Only 4 elevated prop types across 1 to 2 splits):    4 to 12 draw calls                │
│ TOTAL ESTIMATED MULTIMESH DRAW CALLS PER FRAME:                            22 to 48 DRAW CALLS                │
└───────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
```

**Frame Budget Integration [Engineering Estimate]:**  
At 22 to 48 draw calls, the entire repeating environmental clutter suite consumes only **12% to 24%** of the hard 200–250 frame draw-call budget, leaving ample headroom (150+ draw calls) for unique modular architectural shells, character models (Thomas, Elena, NPCs), dynamic interactive clues, and 2D UI elements.

**Empirical Verification Protocol [Measured Result Gate]:**  
The final operational draw-call count must be empirically validated in `08_TESTING/` under Godot 4.7.2 running on the physical NVIDIA GeForce G210, querying `Performance.get_monitor(Performance.RENDER_TOTAL_DRAW_CALLS_IN_FRAME)` inside a representative 50-meter street test slice under both dry and wet weather conditions.

---

### 7.4 Geometric Budgets & Level-of-Detail (LOD) Rules
Strict compliance with the category-specific asset polygon budgets codified in `TECHNICAL_ASSUMPTION_AUDIT.md`:
- **Modular Architectural Panels (Walls, Entablatures, Slabs):**
  - LOD0: 100 to 400 triangles `[Design Recommendation]`.
  - LOD1 (Distance > 20m): 50 to 100 triangles `[Design Recommendation]`.
  - Texture: 1024x1024 shared architectural trim sheet `[Design Recommendation]`.
- **Ordinary Environment Props (Crates, Shacks, Hydrants, Barriers):**
  - LOD0: 250 to 800 triangles `[Design Recommendation]`.
  - LOD1 (Distance > 15m): 100 to 250 triangles `[Design Recommendation]`.
  - Texture: Strictly 1 material per prop, max 512x512 ORM `[Design Recommendation]`.
- **Vegetation & Debris Clusters (Ferns, Peat Tufts, Brick Piles):**
  - LOD0: 100 to 350 triangles `[Design Recommendation]`.
  - LOD1 (Distance > 12m): 30 to 80 triangles (cross-quad billboard cards) `[Design Recommendation]`.
- **Distant Backdrop Silhouettes (Bluffs, Factory Rooflines):**
  - LOD0: 200 to 600 triangles per 100-meter skyline segment `[Design Recommendation]`.

---

### 7.5 Lighting Model Constraints under Godot Compatibility Mode
- **Directional Sunlight / Moonlight:** Exactly 1 active `DirectionalLight3D` casting a single **1024x1024 16-bit depth shadow map** with orthogonal PSSM 2-split projection `[Verified Capability]`.
  - Sun color in Vesper: Cold pale winter grey (`#C8D0D8`, Energy: 0.85) `[Design Recommendation]`.
  - Sun color in The Outside: Directionless whiteout diffusion (Energy: 0.40, Shadows disabled during dense advection fog) `[Design Recommendation]`.
- **OmniLight3D & SpotLight3D Restraints:**
  - Real-time shadow maps for omni and spot lights are **strictly disabled globally** (`shadow_enabled = false`). Real-time multi-light point shadows instantly overwhelm the 16 CUDA cores and slow DDR3 bus of the G210 `[Engineering Estimate]`.
  - Local illumination (paraffin lamps, emergency red bulbs, streetlamps) is provided via unshadowed vertex-lit or low-radius fragment lights (max 4 overlapping lights per camera view) `[Design Recommendation]`.
- **Volumetric Light Simulation:** Volumetric fog is unavailable in the Compatibility Renderer. Fake light cones and atmospheric shafts are authored using transparent additive unshaded mesh cones (80 to 120 triangles) with soft edge vertex-color alpha gradients `[Design Recommendation]`.
- **Distance Fog Configuration in WorldEnvironment:**
  - Vesper Surface: Depth fog starting at 25.0 meters, reaching 100% density at 90.0 meters (Fog color: `#383D42`) `[Design Recommendation]`.
  - The Deep (Sunken Ward): Fog starting at 15.0 meters, reaching 100% density at 65.0 meters (Fog color: `#141615`, simulating complete light attenuation in subterranean darkness) `[Design Recommendation]`.
  - The Outside ("The Grey Sheet"): Fog starting at 3.0 meters, reaching 100% density at 18.0 meters (Fog color: `#A2A8AE`) `[Design Recommendation]`.

---

## 8. SUMMARY & HANDOFF AUDIT GATES

### 8.1 Specialist Handoff Matrix
This research specification feeds directly into the downstream production workflows of Department A and Department B:

```
┌──────────────────────────────────────────────────────────────────────────────────────────┐
│                           SPECIALIST HANDOFF & COUPLING MATRIX                           │
├────────────────────┬────────────────────────────────────┬────────────────────────────────┤
│ Downstream Role    │ Handed-off Deliverable             │ Critical Interface Requirement │
├────────────────────┼────────────────────────────────────┼────────────────────────────────┤
│ Specialist A2      │ District color & lighting backdrops│ Character silhouette contrast  │
│ (Character Art)    │ for Thomas, Elena, Vance, Vane     │ against limestone & soot brick │
├────────────────────┼────────────────────────────────────┼────────────────────────────────┤
│ Specialist A3      │ Architectural mounting points for  │ Lever frame footprint, track   │
│ (Prop & Industrial)│ signal gear, Locomotive #884 siding│ clearances, Black Registry desk│
├────────────────────┼────────────────────────────────────┼────────────────────────────────┤
│ Specialist A4      │ Master Material Matrix & ORM       │ Shader parameter mapping &     │
│ (Materials/Lighting│ channel packing definitions        │ Compatibility PBR uniformity   │
├────────────────────┼────────────────────────────────────┼────────────────────────────────┤
│ Specialist A5      │ Walkable slope limits, stair rises,│ Footstep sound triggers, camera│
│ (Animation/Camera) │ funicular cab clearances           │ occlusion avoidance in alleys  │
├────────────────────┼────────────────────────────────────┼────────────────────────────────┤
│ Specialist A6      │ Modular CSG dimensions & trim-sheet│ Automated Python PIL packing & │
│ (Asset Pipeline)   │ specifications for GLB kitbashing  │ polycount validation scripts   │
├────────────────────┼────────────────────────────────────┼────────────────────────────────┤
│ Specialist A7      │ Scene VRAM allocations, draw-call  │ Verification audit checklists &│
│ (Visual Quality)   │ budgets & occluder polygon layouts │ live Godot G210 frame profiling│
├────────────────────┼────────────────────────────────────┼────────────────────────────────┤
│ Dept B (B1/B3)     │ Physical coordinates, track curves,│ Collision hulls, trigger zones,│
│ (Game Engineering) │ portal occlusion geometries        │ kinematic path spline alignment│
└────────────────────┴────────────────────────────────────┴────────────────────────────────┘
```

### 8.2 Compliance Verification Checklist
- [x] **Strictly Blender-Free:** No `.blend` models, tools, or dependencies specified; relies on Godot CSG, CC0 Poly Haven, Meshy/Tripo AI, and Python PIL (DEC-0002).
- [x] **Hardware Profile Realism:** All parameters strictly bounded by the NVIDIA GeForce G210, 1024 MB VRAM, <= 750 MB game VRAM ceiling, and <= 250 draw calls per frame (DEC-0001, DEC-0009, DEC-0031).
- [x] **Godot 4 Compatibility Renderer:** PBR rules, single directional shadow map, distance fog, and absence of compute shaders, SSR, and volumetric fog respected throughout (DEC-0001).
- [x] **5-Tier Evidence Taxonomy:** Every single engineering figure, volume, and metric carries an explicit classification tag (DEC-0031).
- [x] **Complete Narrative Canon Harmony:** Quarry Pit 03 (15 ha, 4.2M m³ envelope, 3.38M m³ void, 8 bastions, 120 caissons, 210,000 m³ rubble), Greyhaven Split House, and The Outside surveying paradoxes match `01_STORY_BIBLE` verbatim (DEC-0015, DEC-0017, DEC-0021, DEC-0024).
- [x] **Non-Implementation Rule:** Pure research, visual design criteria, spatial dimensions, material definitions, and architectural layouts. Zero GDScript code or production scene trees written.
- [x] **Defect Remediation DEF-A7-001 Resolved (Item R-01):** Unconditional "9 draw calls" claim retracted; multi-pass draw call equation codified; $32\text{m} \times 32\text{m}$ spatial grid chunking mandated; `cast_shadow = OFF` enforced on ground clutter; single-surface `ArrayMesh` offline conformance established.

---
**END OF SPECIFICATION: CHAPTER 03 RESEARCH DELIVERABLE**  
*Document signed and locked for Department A visual bible integration.*
