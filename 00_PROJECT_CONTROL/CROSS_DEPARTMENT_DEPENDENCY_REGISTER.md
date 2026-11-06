# PROJECT NULL — CROSS-DEPARTMENT DEPENDENCY REGISTER
**Document ID:** PNL-DEP-001  
**Authority:** Creative Director & Technical Director  
**Maintained By:** Production Director (Lead Production Agent)  
**Date:** 2026-11-05  
**Status:** ACTIVE BINDING CONTRACT

---

## 1. PURPOSE & INTER-DEPARTMENTAL ARCHITECTURE

This register identifies, tracks, and enforces technical and visual contracts across the three core production departments:
- **Department A:** Visual Production (Book 02)
- **Department B:** Game Engineering (Book 03)
- **Department C:** Autonomous AI Studio (Book 04)

No department may unilaterally alter a shared parameter without a formal logged decision in `DECISION_LOG.md`.

---

## 2. CROSS-DEPARTMENT DEPENDENCY MATRIX

```
┌──────────────────────────────────────────────────────────────────────────────────────────────────────────┐
│                               CROSS-DEPARTMENT DEPENDENCY MATRIX                                         │
├─────┬──────────────────────┬─────────────┬─────────────┬─────────────────────────────────┬───────────────┤
│ ID  │ Parameter / Contract │ Provider    │ Consumer    │ Technical Specification         │ Status        │
├─────┼──────────────────────┼─────────────┼─────────────┼─────────────────────────────────┼───────────────┤
│ D-01│ Texture Budgets &    │ Dept B      │ Dept A      │ Max 1024x1024 atlas, 512x512 std│ [Enforced]    │
│     │ VRAM Allocation      │ (Eng/G210)  │ (Visual/PBR)│ Target VRAM ≤ 750 MB provisional│               │
│     │                      │             │             │ [Unverified Target]; empirical  │               │
│     │                      │             │             │ benchmark required on G210      │               │
├─────┼──────────────────────┼─────────────┼─────────────┼─────────────────────────────────┼───────────────┤
│ D-02│ ORM Channel Packing  │ Dept A/C    │ Dept B      │ Standardized RGB channel packing│ [Enforced]    │
│     │ Texture Format       │ (Asset/AI)  │ (Engine)    │ (R=AO, G=Roughness, B=Metallic) │               │
│     │                      │             │             │ Saves sampler slots (1 vs 3);   │               │
│     │                      │             │             │ memory reduction unverified     │               │
├─────┼──────────────────────┼─────────────┼─────────────┼─────────────────────────────────┼───────────────┤
│ D-03│ Camera Rig Hierarchy │ Dept B      │ Dept A      │ SpringArm3D dual 1st/3rd mode;  │ [Enforced]    │
│     │ & Motion Offsets     │ (Controller)│ (Animation) │ 1st: len 0.0m (0, 1.65, 0);     │               │
│     │                      │             │             │ 3rd: len 2.2m (0.35, 1.55, 0);  │               │
│     │                      │             │             │ Procedural limp on GaitPivot    │               │
├─────┼──────────────────────┼─────────────┼─────────────┼─────────────────────────────────┼───────────────┤
│ D-04│ 3D Item Inspection   │ Dept B      │ Dept A      │ Center screen pivot, mesh zoom, │ [Enforced]    │
│     │ Interaction Frame    │ (Systems)   │ (Props)     │ Max 2,500 tris, 1 material;     │               │
│     │                      │             │             │ Raking light orbit support      │               │
├─────┼──────────────────────┼─────────────┼─────────────┼─────────────────────────────────┼───────────────┤
│ D-05│ CSG Level Streaming  │ Dept B      │ Dept A      │ Modular wall chunks ≤ 250 draw  │ [Enforced]    │
│     │ & Chunk Occlusion    │ (World)     │ (Env Art)   │ calls, baked static collision   │               │
├─────┼──────────────────────┼─────────────┼─────────────┼─────────────────────────────────┼───────────────┤
│ D-06│ Infrasound Acoustic  │ Dept A      │ Dept B      │ Psychoacoustic harmonics:       │ [Enforced]    │
│     │ & Screen Shake Sync  │ (Atmosphere)│ (Audio)     │ 36.8Hz, 55.2Hz, 73.6Hz + shake  │               │
├─────┼──────────────────────┼─────────────┼─────────────┼─────────────────────────────────┼───────────────┤
│ D-07│ Blender-Free 3D      │ Dept C      │ Dept A      │ Tripo/Meshy AI generation into  │ [Enforced]    │
│     │ Ingestion Pipeline   │ (AI Studio) │ (Asset Pipe)│ binary GLB, validated by Python │               │
├─────┼──────────────────────┼─────────────┼─────────────┼─────────────────────────────────┼───────────────┤
│ D-08│ Automated TDD Head-  │ Dept C      │ Dept B      │ Headless command-line Godot 4.7 │ [Enforced]    │
│     │ less Test Harness    │ (AI Studio) │ (QA/Eng)    │ test runner validating state    │               │
├─────┼──────────────────────┼─────────────┼─────────────┼─────────────────────────────────┼───────────────┤
│ D-09│ Train Ascent Runtime │ Dept B      │ Dept A      │ Kinematic PathFollow3D spline   │ [Enforced]    │
│     │ Motion vs Cinematic  │ (Physics)   │ (Cinematics)│ (narrative stiction 53.32 kN)   │               │
├─────┼──────────────────────┼─────────────┼─────────────┼─────────────────────────────────┼───────────────┤
│ D-10│ Spatial Anomaly Loop │ Dept B      │ Dept A      │ Silent origin rebasing at 6.4km;│ [Enforced]    │
│     │ Math & Visual Assets │ (Engine)    │ (Landscapes)│ SM-14 & SM-18 bedrock models    │               │
├─────┼──────────────────────┼─────────────┼─────────────┼─────────────────────────────────┼───────────────┤
│ D-11│ Character Facial     │ Dept A      │ Dept B      │ Hybrid Facial Architecture:     │ [Enforced]    │
│     │ Rigging & Animation  │ (Character) │ (Controller)│ 8-bone skeletal rig (Jaw, Lips, │ (R-02 / DEC34)│
│     │                      │             │             │ Brows, Eyelids) + max 2 morphs  │               │
│     │                      │             │             │ on 1-surface head (<2.5m framing│               │
├─────┼──────────────────────┼─────────────┼─────────────┼─────────────────────────────────┼───────────────┤
│ D-12│ Dialogue Camera      │ Dept B      │ Dept A      │ Perspective Preservation:       │ [Enforced]    │
│     │ Framing (DEP-Q2)     │ (Narrative/ │ (Cinematics/│ Dialogue preserves active mode; │ (DEC-0010)    │
│     │                      │ Controller) │ Animation)  │ translation locked, camera toggle│              │
│     │                      │             │             │ (V / R3) 100% unlocked          │               │
├─────┼──────────────────────┼─────────────┼─────────────┼─────────────────────────────────┼───────────────┤
│ D-13│ Black Registry       │ Dept B      │ Dept A      │ Phenomenological Embodiment:    │ [Enforced]    │
│     │ Embodiment (DEP-Q3)  │ (Controller)│ (Animation) │ Deepened limp dip (Ar -0.052m), │ (DEC-0035)    │
│     │                      │             │             │ roll (3.2°), 40% inertia drop,  │               │
│     │                      │             │             │ left arm cradles 24.2 kg folios │               │
└─────┴──────────────────────┴─────────────┴─────────────┴─────────────────────────────────┴───────────────┘
```

---

## 3. CONFLICT ARBITRATION PROTOCOLS

1. **VRAM Exhaustion Conflict:** If Department A's visual assets exceed the $750\text{ MB}$ peak VRAM threshold in any scene, Department B holds veto authority to demand immediate texture downsampling (e.g., from 1024 to 512) or LOD simplification.
2. **Draw Call Conflict:** If a scene exceeds 250 draw calls, Department A must merge modular static geometries or share material trim sheets; dynamic multi-pass rendering is prohibited.
3. **Generative Asset Fidelity Conflict:** If an AI-generated mesh from Department C exceeds polygon ceilings or contains degenerate UVs, it is rejected by Department A's pipeline script and returned for re-prompting or CSG replacement.
