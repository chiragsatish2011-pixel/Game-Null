# PROJECT NULL — BOOK 05: MASTER EXECUTION MANUAL
## CHAPTER 02: CROSS-DEPARTMENT DEPENDENCY GATING RUNBOOK

**Document ID:** PNL-B05-CH02  
**Document Version:** 1.0.0  
**Authority:** Production Director (Lead Production Agent)  
**Status:** Authored & Ratified  
**Target Engine:** Godot Engine 4.7.2 Stable (`gl_compatibility` / OpenGL 3.3 Core Profile)  
**Host Hardware:** Windows 11 Home 64-bit | Intel Core i5-12400F | 16 GB DDR4 RAM | NVIDIA GeForce G210 (1024 MB DDR3 VRAM)  

---

## 1. THE PRODUCTION HANDOFF ARCHITECTURE

Autonomous agents operate under strict dependency gating: no downstream agent may initiate execution until all upstream prerequisites have emitted deterministic verification evidence (`[Verified Capability]` or `[Measured Result]`).

```text
                                CROSS-DEPARTMENT PRODUCTION FLOW
                                
      +─────────────────────────────────────────────────────────────────────────────+
      │                         PHASE 2: BIBLE CONSOLIDATION & LOCK                 │
      │                         (Books 01, 02, 03, 04, 05 Certified)                │
      +──────────────────────────────────────┬──────────────────────────────────────+
                                             │ [Greenlight Gate Cleared]
                                             ▼
      +─────────────────────────────────────────────────────────────────────────────+
      │                   PHASE 4: STAGE 1 — ENGINE INITIALIZATION                  │
      │               Dept C: Scaffold 06_GAME_PROJECT & Pre-Commit Hooks           │
      │               Dept B: Compile EventBus, GameState & TelemetryAutoload       │
      +──────────────────────────────────────┬──────────────────────────────────────+
                                             │ [Headless Suite Pass: Exit 0]
                                             ▼
      +─────────────────────────────────────────────────────────────────────────────+
      │                   PHASE 4: STAGE 2 — PLAYER & CAMERA SUBSYSTEMS             │
      │               Dept B: Implement PlayerController, GaitPivot & CameraRig     │
      │               Dept A: Verify 1st/3rd Camera Framing & Procedural Limp       │
      +──────────────────────────────────────┬──────────────────────────────────────+
                                             │ [CameraRig Pass & LoS Occlusion Pass]
                                             ▼
      +─────────────────────────────────────────────────────────────────────────────+
      │                   PHASE 4: STAGE 3 — MODULAR BLOCKOUT & GRAYBOX             │
      │               Dept A: Construct CSG Modular District 01 Blockout            │
      │               Dept B: Set Collision Layers (1=World, 2=Props, 3=NPCs)       │
      │               Dept C: Execute Automated ArrayMesh Baking Script             │
      +──────────────────────────────────────┬──────────────────────────────────────+
                                             │ [ArrayMesh Baked; Draw Calls <= 120]
                                             ▼
      +─────────────────────────────────────────────────────────────────────────────+
      │                   PHASE 4: STAGE 4 — ASSET GENERATION & TEXTURE PACKING     │
      │               Dept C: Run Meshy/Tripo Pipeline -> inspect_glb.py (mode==4)  │
      │               Dept C: Run pack_orm.py (Pillow Lanczos ORM Atlases)          │
      │               Dept A: Assign Single StandardMaterial3D per Mesh             │
      +──────────────────────────────────────┬──────────────────────────────────────+
                                             │ [GLB Passed <= 1,500 tris; Atlases <= 1024]
                                             ▼
      +─────────────────────────────────────────────────────────────────────────────+
      │                   PHASE 4: STAGE 5 — INVESTIGATION & FORENSIC SYSTEMS       │
      │               Dept B: Compile ItemExaminer (Viewport Render Suppression)    │
      │               Dept B: Wire ClueRegistry, Hotspots & Contradiction Engine    │
      │               Dept A: Integrate PROP-HERO-01, 02, 08 Inspection Models      │
      +──────────────────────────────────────┬──────────────────────────────────────+
                                             │ [Viewport Suppress Pass; LEAD-01 Unlocked]
                                             ▼
      +─────────────────────────────────────────────────────────────────────────────+
      │                   PHASE 4: STAGE 6 — COMPATIBILITY LIGHTING & AUDIO         │
      │               Dept A: 1 DirectionalLight3D (1024 Shadow), 0 Omni Shadows    │
      │               Dept B: 3D Spatial Audio & Psychoacoustic Infrasound Buses    │
      +──────────────────────────────────────┬──────────────────────────────────────+
                                             │ [Draw Calls <= 220; VRAM <= 350 MB]
                                             ▼
      +─────────────────────────────────────────────────────────────────────────────+
      │                   PHASE 4: STAGE 7 — VERIFIED VERTICAL SLICE LOCK           │
      │               Dept E: Full Headless Suite + Live 60 FPS G210 Benchmark      │
      │               Lead Production Agent: Tag Release `v0.3.0-vertical-slice`    │
      +─────────────────────────────────────────────────────────────────────────────+
```

---

## 2. STEP-BY-STEP DEPENDENCY HANDOFF CHECKLIST

Every transition between stages requires formal verification of the corresponding inter-departmental contracts ratified in `CROSS_DEPARTMENT_DEPENDENCY_REGISTER.md`:

```text
┌───────┬─────────────────────────────────────────────────┬──────────────────────┬─────────────┐
│ Stage │ Handoff Milestone & Contract Verification       │ Validating Roles     │ Gate Status │
├───────┼─────────────────────────────────────────────────┼──────────────────────┼─────────────┤
│ 1     │ D-01: Non-Implementation Gate lifted for 06_    │ Lead Director        │ BLOCKING    │
│       │ D-04: Headless test runner operational (exit 0) │ Specialist E2, B1    │             │
├───────┼─────────────────────────────────────────────────┼──────────────────────┼─────────────┤
│ 2     │ D-03: Two-stage LoS raycast occluded by Layer 1 │ Specialist B2, B8    │ BLOCKING    │
│       │ D-12: Perspective freedom preserved (1st/3rd)   │ Specialist A5, B2    │             │
├───────┼─────────────────────────────────────────────────┼──────────────────────┼─────────────┤
│ 3     │ D-02: Zero Blender dependencies in CSG assembly │ Specialist A6, C4    │ BLOCKING    │
│       │ D-03: ArrayMeshes baked; draw calls <= 120      │ Specialist A1, B1    │             │
├───────┼─────────────────────────────────────────────────┼──────────────────────┼─────────────┤
│ 4     │ D-02: GLB inspection validates mode==4 topology │ Specialist C4, E3    │ BLOCKING    │
│       │ D-03: ORM packing verified; textures <= 1024x   │ Specialist A4, C4    │             │
├───────┼─────────────────────────────────────────────────┼──────────────────────┼─────────────┤
│ 5     │ D-03: Main world viewport render suppressed     │ Specialist B3, B8    │ BLOCKING    │
│       │ D-13: Black Registry & 10L rescue cyls present  │ Specialist A3, B3    │             │
├───────┼─────────────────────────────────────────────────┼──────────────────────┼─────────────┤
│ 6     │ D-03: 1 Directional light, 0 omni shadows       │ Specialist A4, B8    │ BLOCKING    │
│       │ D-03: Dual-channel WDDM VRAM <= 350 MB          │ Specialist B7, E2    │             │
├───────┼─────────────────────────────────────────────────┼──────────────────────┼─────────────┤
│ 7     │ D-07: Decoupled review score >= 85%             │ All Reviewers (A,B,C)│ FINAL LOCK  │
│       │ Deterministic benchmark: 60 FPS on G210         │ Production Director  │             │
└───────┴─────────────────────────────────────────────────┴──────────────────────┴─────────────┘
```

---
*End of Chapter 02 Specification.*