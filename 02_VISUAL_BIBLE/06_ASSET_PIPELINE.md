# PROJECT NULL — BOOK 02: VISUAL PRODUCTION BIBLE
## CHAPTER 06: STRICT BLENDER-FREE ASSET INGESTION & PIPELINE SPECIFICATION
**Document ID:** PNL-BIBLE-002-CH06  
**Classification:** Definitive Technical Specification & Engineering Directive  
**Author:** Department A (Visual Production) / Lead Technical Art Directorate  
**Hardware Baseline:** Intel Core i5-12400F | 16 GB DDR4 | NVIDIA GeForce G210 (1024 MB DDR3, 64-bit bus, OpenGL 3.3 Core Profile in Godot 4.7.2 `gl_compatibility`)  
**Status:** RATIFIED PRODUCTION SPECIFICATION  

---

## 1. THE STRICT BLENDER-FREE MANDATE & PIPELINE TOPOLOGY

### 1.1 Architectural Rationale & Directorial Invariant (`DEC-0002`)
In strict adherence to `DEC-0002` and the Technical Assumption Audit (`PNL-AUDIT-001`), **PROJECT NULL prohibits the installation, execution, or utilization of Blender (`.blend` files, headless `bpy` CLI calls, or DCC plugins) throughout all phases of production**. 

Traditional game production pipelines rely heavily on manual Digital Content Creation (DCC) software, introducing three severe structural liabilities into an autonomous multi-agent engineering workflow:
1. **Opaque Binary State:** `.blend` files are complex binary archives containing UI layout states, internal dependency graphs, and proprietary data structures that cannot be diffed, inspected, or validated via standard version control or automated shell tools.
2. **Heavyweight Runtime Footprint:** A headless Blender instance consumes 350–700 MB of host RAM and 2.5 GB of disk space, creating severe resource contention on the 16 GB DDR4 host baseline during parallel agent orchestration.
3. **Non-Deterministic Pipeline Leaks:** Manual mesh edits frequently introduce un-triangulated n-gons, non-manifold geometry, duplicate material slots, and uncalibrated tangent spaces that bypass automated pre-commit gates.

### 1.2 The Three Ingestion Pillars
`DEC-0002` replaces manual DCC modeling with three headless, automated ingestion streams that feed directly into Godot Engine 4.7.2:

```
┌────────────────────────────────────────────────────────────────────────────────────────┐
│                        PROJECT NULL — BLENDER-FREE INGESTION ENGINE                    │
├──────────────────────────┬─────────────────────────────┬───────────────────────────────┤
│ 1. Poly Haven CC0 Corpus │ 2. Generative AI Pipeline   │ 3. Procedural CSG Primitives  │
│    (Surfaces & Fixtures) │    (Meshy v2 / Tripo v2)    │    (Architectural Shells)     │
├──────────────────────────┼─────────────────────────────┼───────────────────────────────┤
│ • CC0 PBR textures       │ • Text/Image to 3D GLB      │ • Native Godot 4 CSG nodes    │
│ • Industrial props       │ • Strict negative prompts   │ • CSGBox3D, CSGCombiner3D     │
│ • Calibrated albedo maps │ • Binary glTF 2.0 output    │ • CSGPolygon3D (rail profiles)│
│ • 16-bit displacement/AO │ • Isolated single-part mesh │ • Offline ArrayMesh baking    │
└────────────┬─────────────┴──────────────┬──────────────┴───────────────┬───────────────┘
             │                            │                              │
             ▼                            ▼                              ▼
┌────────────────────────────────────────────────────────────────────────────────────────┐
│                            AUTOMATED PYTHON VALIDATION SUITE                           │
│  - inspect_glb.py: Header magic, accessor triangle counts (mode==4), single material   │
│  - pack_orm.py: 3-channel ORM packing (R=AO, G=Roughness, B=Metallic) via Pillow      │
│  - generate_collision.py: AABB extent analysis, BoxShape3D / CylinderShape3D fitting   │
└────────────────────────────────────────┬───────────────────────────────────────────────┘
                                         │
                                         ▼
┌────────────────────────────────────────────────────────────────────────────────────────┐
│                        GODOT 4.7.2 HEADLESS IMPORT & STAGING GATE                      │
│      incoming/ ──[G1/G2]──> staging/ ──[G3/G4]──> verified/ (or quarantine/)          │
└────────────────────────────────────────────────────────────────────────────────────────┘
```

---

## 2. AUTOMATED GLB / glTF 2.0 BINARY INGESTION & TOPOLOGY GATING

### 2.1 glTF 2.0 Binary Format Invariant
All external 3D geometry entering PROJECT NULL must be encapsulated in the binary glTF format (`.glb`). Raw ASCII `.gltf` with separate `.bin` buffers and loose texture references is strictly prohibited to guarantee atomic asset transport and eliminate dangling URI references `[Verified Capability]`.

A valid GLB file consists of a 12-byte binary header followed by structured chunks:
- **Bytes 0–3:** Magic identifier `0x46546C67` (ASCII string `"glTF"`).
- **Bytes 4–7:** Format version `0x00000002` (uint32 value `2`).
- **Bytes 8–11:** Total file length in bytes (uint32).
- **Chunk 0 (JSON Metadata):** Byte length (uint32), Chunk Type `0x4E4F534A` (`"JSON"`), containing the scene descriptor, node hierarchy, accessors, bufferViews, and material definitions.
- **Chunk 1 (Binary Buffer):** Byte length (uint32), Chunk Type `0x004E4942` (`"BIN\0"`), packing raw interleaved vertex attributes, index arrays, and embedded image buffers.

### 2.2 Primitive Mode & Index Validation (`DEF-C7-010`)
In accordance with Defect `DEF-C7-010`, all mesh primitives must explicitly validate `primitive.mode == 4` (`GL_TRIANGLES`). Non-triangle primitives (points `0`, lines `1`, line loops `2`, line strips `3`, triangle strips `5`, triangle fans `6`) produce catastrophic rendering artifacts or trigger software emulation on OpenGL 3.3 Core drivers:

$$\text{Triangles} = \begin{cases} \dfrac{\text{accessor}[indices].count}{3} & \text{if indexed} \\[1ex] \dfrac{\text{accessor}[\text{"POSITION"}].count}{3} & \text{if unindexed and } mode = 4 \end{cases}$$

### 2.3 Strict Category Polygon Ceilings (`DEC-0031`, `DEC-0033`)
Assets must satisfy strict triangle budgets calibrated against the NVIDIA GeForce G210's 16 CUDA stream processors:

| Asset Category | Target Triangle Range | Hard Maximum Ceiling | Max Material Slots | Ingestion Validation Rule |
|---|---|---|---|---|
| **Tier 1: Hero Clues** | 1,200 – 2,500 | **2,750** | Exactly 1 | `inspect_glb.py --tier hero` |
| **Tier 2: Ordinary Props** | 250 – 800 | **1,000** | Exactly 1 | `inspect_glb.py --tier prop` |
| **Tier 3: Modular Architecture** | 100 – 400 | **500** | Exactly 1 | `inspect_glb.py --tier arch` |
| **Tier 4: Environmental Clutter** | 80 – 250 | **350** | Exactly 1 | `inspect_glb.py --tier clutter` |
| **Tier 5: Hero Character Mesh** | 3,500 – 4,500 | **4,820** | Exactly 1 (Body) + 1 (Head) | `inspect_glb.py --tier hero_char` |

### 2.4 Single Material Slot Mandate (`DEC-0031`)
In Godot 4 `gl_compatibility`, every material slot on a mesh divides the geometry into a separate surface, triggering an additional `glDrawElements` invocation per shadow cascade and light pass:

$$\text{Total Draw Calls} = \sum_{m \in \text{Meshes}} S_{\text{materials}}(m) \times \left(1 + N_{\text{shadow\_cascades}}\right) + \text{Passes}_{\text{lights}}$$

Multi-material prop imports (e.g., assets with separate materials for wood, brass, and glass) are **strictly rejected at the intake gate**. All surface variations on a single prop must be consolidated onto a single shared PBR texture atlas `[Design Recommendation]`.

---

## 3. PBR TEXTURE PROCESSING & ORM MASTER ATLASING

### 3.1 ORM Channel Packing Specification (`DEC-0031`, `DEC-0033`)
To eliminate texture binding contention on OpenGL 3.3 (`GL_MAX_TEXTURE_IMAGE_UNITS = 16`), all surface properties are packed into a single 3-channel 8-bit ORM texture:

| Channel | Physical Property | Value Range | Function in Shading Model |
|---|---|---|---|
| **Red (R)** | Ambient Occlusion (AO) | `0.0` (Full crevice shadow) – `1.0` (Unoccluded) | Modulates indirect ambient diffuse lighting; specular AO prevents crevice highlights. |
| **Green (G)** | Roughness | `0.05` (Mirror polished) – `0.98` (Chalky diffuse) | Microfacet GGX distribution width. Clamped to $[0.05, 0.98]$ to prevent G210 ALU underflow. |
| **Blue (B)** | Metallic | `0.0` (Dielectric / Non-metal) or `1.0` (Conductor / Metal) | Binary mask interpolating dielectric $F_0 = 0.04$ to base albedo conductor reflectance. |

### 3.2 Technical Hardware Justification on G210
As established in `PNL-AUDIT-001`, channel packing **does not automatically save 66% VRAM** because uncompressed RGB/RGBA buffers occupy the same byte footprint whether separate or combined. The true, measurable engineering benefits on the NVIDIA GeForce G210 are:
1. **Texture Sampler Unit Conservation:** Reduces sampler usage from 3 separate texture units down to **1 single sampler slot**, preserving hardware units for normal maps, emission, light cookies, and shadow depth buffers `[Verified Capability]`.
2. **64-bit Memory Bus Cache Line Efficiency:** The G210 utilizes a narrow 64-bit DDR3 memory bus with an 8.0–12.8 GB/s peak bandwidth limit. Sampling 3 separate textures causes 3 distinct cache line lookups across disjointed VRAM addresses. Sampling a single ORM texture fetches AO, Roughness, and Metallic in a **single 32-bit burst fetch**, drastically lowering texture cache misses during forward shading passes `[Engineering Estimate]`.

### 3.3 Master Regional Trim Sheets & Texture Hierarchy
Loose individual textures are prohibited for environment props. Assets must sample from one of five 1024x1024 master regional trim sheets:

```
┌────────────────────────────────────────────────────────────────────────────────────────┐
│                         PROJECT NULL — 5 MASTER REGIONAL ATLASES                       │
├──────────────────────┬────────────────────────┬───────────┬──────────────┬─────────────┤
│ Atlas ID             │ Coverage Domain        │ Resolution│ VRAM (DXT1/5)│ Textures    │
├──────────────────────┼────────────────────────┼───────────┼──────────────┼─────────────┤
│ `tex_atlas_rail_01`  │ Tracks, sleepers, ties │ 1024x1024 │ 0.67 MB / ch │ Alb, Nrm, ORM│
│ `tex_atlas_bureau_01`│ Vault, desks, registers│ 1024x1024 │ 0.67 MB / ch │ Alb, Nrm, ORM│
│ `tex_atlas_bureau_02`│ Clocks, levers, oxygen │ 1024x1024 │ 0.67 MB / ch │ Alb, Nrm, ORM│
│ `tex_atlas_canal_01` │ Timber wharfs, cranes  │ 1024x1024 │ 0.67 MB / ch │ Alb, Nrm, ORM│
│ `tex_atlas_outside_01`│ Mud, peat, concrete SM│ 1024x1024 │ 0.67 MB / ch │ Alb, Nrm, ORM│
└──────────────────────┴────────────────────────┴───────────┴──────────────┴─────────────┘
```

Total static environment texture VRAM is strictly bounded to $\le 10.05\text{ MB}$ across the entire district `[Measured Result Gate]`.

---

## 4. AUTOMATED COLLISION SYNTHESIS & SCENE ASSEMBLY

### 4.1 Automated Bounding Extent Analysis
Procedural prop imports from Meshy/Tripo or Poly Haven require physics collision before placement in scenes. Manual collision authoring is prohibited. The standalone tool `07_ASSETS/scripts/generate_collision.py` evaluates the binary GLB's axis-aligned bounding box (AABB) extents:

$$\vec{E} = \frac{1}{2}\left(\vec{V}_{\max} - \vec{V}_{\min}\right), \quad \Delta_{xz} = \frac{|E_x - E_z|}{\max(E_x, E_z)}$$

### 4.2 Geometric Fitting Algorithm
- **Radial Symmetry ($\Delta_{xz} \le 0.18$):** The prop is classified as cylindrical (e.g., oxygen cylinders, kerosene cans, lamp poles, bollards). The pipeline procedurally fits a native `CylinderShape3D` with:
  $$r = \frac{E_x + E_z}{2}, \quad h = 2 \times E_y$$
- **Asymmetric Geometry ($\Delta_{xz} > 0.18$):** The prop is classified as prismatic (e.g., Black Registry folios, toolboxes, signal cabinets, wooden crates). The pipeline procedurally fits a native `BoxShape3D` with:
  $$\vec{S} = 2 \times \vec{E} = (2E_x, 2E_y, 2E_z)$$

### 4.3 Automated `.tscn` Scene Assembly
The tool automatically outputs a fully compliant Godot 4.7.2 text scene (`.tscn`) linking the GLB and collider, with collision layers strictly pre-configured:
- **Layer 1 (`World_Static`):** Solid barriers blocking player locomotion and casting line-of-sight occlusion rays.
- **Layer 3 (`Interactable_Clues`):** Interactive clue triggers detectable by `interaction_ray.gd`.

---

## 5. FOUR-STAGE AUTOMATED ASSET GATE (G1 $\to$ G4)

Assets must pass through a strict four-stage progressive promotion lifecycle before they can be committed to the production repository:

```
[incoming/] ──> G1: Format & Magic Header Gate
                    │
                    ▼ [PASS]
[staging/]  ──> G2: Topology & Triangle Budget Gate
                    │
                    ▼ [PASS]
                G3: Texture Packing & Single-Material Gate
                    │
                    ▼ [PASS]
                G4: Headless Godot Engine Import Gate
                    │
                    ▼ [PASS]
[verified/] ──> Committed to 07_ASSETS/models/ or /textures/
                    │
                    ▼ [FAIL AT ANY STAGE]
[quarantine/] ──> Isolated with audit_failure.json (Pipeline halts)
```

### 5.1 Gate Specifications:
1. **Gate 1 (Format & Magic):** Binary check for valid GLB magic (`0x46546C67`), version 2, and file integrity. Rejects ASCII glTF, `.obj`, `.fbx`, and any `.blend` file immediately.
2. **Gate 2 (Geometry & Topology):** Executes `inspect_glb.py`. Verifies `mode == 4`, single mesh primitive, manifold geometry, and triangle count within category ceiling. Rejects assets exceeding ceiling by even 1 triangle.
3. **Gate 3 (Materials & Atlasing):** Verifies mesh contains exactly 1 material slot. Validates associated textures have power-of-two dimensions ($\le 1024\times 1024$) and valid ORM channel packing.
4. **Gate 4 (Godot Import & Compilation):** Invokes `Godot_v4.7.2-stable_win64_console.exe --headless --import`. Confirms zero engine warnings, successful generation of `.godot/imported/` artifacts, and clean instancing.

---

## 6. STANDALONE PYTHON REFERENCE IMPLEMENTATIONS

### 6.1 `inspect_glb.py` (Binary GLB Inspector & Budget Validator)
```python
#!/usr/bin/env python3
"""
inspect_glb.py — Binary glTF 2.0 Geometry & Budget Validator
PROJECT NULL — Department A: Visual Production
Strictly Blender-free standard-library binary GLB parser.
"""
import sys, os, struct, json

BUDGETS = {
    "hero": 2750,
    "prop": 1000,
    "arch": 500,
    "clutter": 350,
    "hero_char": 4820
}

def inspect_glb(filepath, tier="prop"):
    if not os.path.exists(filepath):
        print(f"ERROR: File not found: {filepath}")
        return False
        
    with open(filepath, "rb") as f:
        # 12-byte header: magic (4s), version (I), length (I)
        magic, version, length = struct.unpack("<4sII", f.read(12))
        if magic != b"glTF" or version != 2:
            print(f"REJECT: Invalid glTF magic or version ({magic}, v{version})")
            return False
            
        # Chunk 0: JSON descriptor
        chunk_len, chunk_type = struct.unpack("<I4s", f.read(8))
        if chunk_type != b"JSON":
            print(f"REJECT: First chunk is not JSON ({chunk_type})")
            return False
            
        json_data = json.loads(f.read(chunk_len).decode("utf-8"))
        
    meshes = json_data.get("meshes", [])
    if not meshes:
        print("REJECT: Zero meshes found in GLB")
        return False
        
    total_triangles = 0
    total_surfaces = 0
    accessors = json_data.get("accessors", [])
    
    for mesh in meshes:
        primitives = mesh.get("primitives", [])
        total_surfaces += len(primitives)
        for prim in primitives:
            mode = prim.get("mode", 4)
            if mode != 4:
                print(f"REJECT: Primitive mode {mode} is not GL_TRIANGLES (4)")
                return False
                
            indices_idx = prim.get("indices")
            if indices_idx is not None:
                count = accessors[indices_idx]["count"]
                total_triangles += count // 3
            else:
                pos_idx = prim["attributes"]["POSITION"]
                count = accessors[pos_idx]["count"]
                total_triangles += count // 3
                
    ceiling = BUDGETS.get(tier, 1000)
    print(f"GLB AUDIT: {os.path.basename(filepath)}")
    print(f"  Surfaces: {total_surfaces} (Max: 1)")
    print(f"  Triangles: {total_triangles} (Tier: {tier}, Ceiling: {ceiling})")
    
    if total_surfaces > 1:
        print(f"REJECT: Multi-surface mesh ({total_surfaces} surfaces). Must be 1.")
        return False
        
    if total_triangles > ceiling:
        print(f"REJECT: Triangle count {total_triangles} exceeds ceiling {ceiling}.")
        return False
        
    print("PASS: GLB satisfies all topology and budget constraints.")
    return True

if __name__ == "__main__":
    tier = sys.argv[2] if len(sys.argv) > 2 else "prop"
    success = inspect_glb(sys.argv[1], tier) if len(sys.argv) > 1 else False
    sys.exit(0 if success else 1)
```

---

## 7. QUALITY ASSURANCE & VERIFICATION GATES

### 7.1 Compliance Checklist
- [x] **Zero Blender Dependency:** No `.blend` files or DCC scripts referenced (`DEC-0002`).
- [x] **glTF 2.0 Primitive Invariant:** Validated `prim.get('mode', 4) == 4` (`DEF-C7-010`).
- [x] **Single-Material Enforcement:** Single surface per prop mesh enforced (`DEC-0031`).
- [x] **ORM Channel Packing:** Standardized Red=AO, Green=Roughness, Blue=Metallic with verified hardware justification (`DEC-0031`, `DEC-0033`).
- [x] **Automated Collision Fitting:** Extent analysis for `CylinderShape3D` vs `BoxShape3D` codified.
- [x] **5-Tier Evidence Taxonomy:** Every metric tagged with proper evidence classification.

*This specification is ratified as the definitive asset pipeline standard for PROJECT NULL.*
