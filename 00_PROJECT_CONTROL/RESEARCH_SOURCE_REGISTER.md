# PROJECT NULL — RESEARCH SOURCE & BENCHMARK REGISTER
**Document ID:** PNL-SRC-001  
**Authority:** Creative Director & Technical Director  
**Maintained By:** Production Director (Lead Production Agent)  
**Date:** 2026-11-05  
**Status:** ACTIVE AUDIT TRAIL

---

## 1. PURPOSE & RESEARCH PROVENANCE

This register records the empirical evidence, official documentation, hardware benchmarks, and verified skill references supporting all technical and artistic decisions across Books 02, 03, and 04.

---

## 2. HARDWARE ENVIRONMENT & PROFILING BENCHMARKS

```
┌──────────────────────────────────────────────────────────────────────────────────────────┐
│                             HARDWARE PROFILING REGISTER                                  │
├─────────────────┬───────────────────────────────┬──────────────────────┬─────────────────┤
│ Component       │ Physical Specification        │ Driver / API Version │ Evidence Tag    │
├─────────────────┼───────────────────────────────┼──────────────────────┼─────────────────┤
│ CPU             │ Intel Core i5-12400F          │ 12 Cores / Threads   │ [Measured]      │
│ System RAM      │ 16.0 GB DDR4-3200             │ Dual Channel         │ [Measured]      │
│ GPU             │ NVIDIA GeForce G210           │ Driver 21.21.13.4201 │ [Measured]      │
│ GPU VRAM        │ 1024 MB DDR3 (64-bit bus)     │ Bandwidth 12.8 GB/s  │ [Measured]      │
│ Graphics API    │ OpenGL 3.3 Core Profile       │ GLSL 330             │ [Verified]      │
│ Game Engine     │ Godot Engine 4.7.2 Stable     │ gl_compatibility     │ [Verified]      │
└─────────────────┴───────────────────────────────┴──────────────────────┴─────────────────┘
```

---

## 3. ENGINE CONSTRAINTS & CODEBASE REFERENCES

1. **Godot 4 Compatibility Renderer Capabilities:**
   - *Source Reference:* Godot 4.x Official Documentation (`rendering/renderer/rendering_method="gl_compatibility"`).
   - *Verified Incompatibilities:* Compute shaders unavailable; SDFGI/VoxelGI unavailable; Screen-Space Reflections (SSR) unsupported; Volumetric fog unsupported.
   - *Verified Mitigations:* Single directional shadow map (1024x1024); exponential distance fog in `WorldEnvironment`; unshaded quad billboard planes with alpha blend for god rays.
2. **PBR Material & ORM Channel Packing Standards:**
   - *Source Reference:* Khronos glTF 2.0 Specification & S3TC/DXT Texture Compression Standard.
   - *Implementation Standard:* Pillow (`PIL.Image`) automated script merging Ambient Occlusion (R), Roughness (G), and Metallic (B) into a single 3-channel RGB texture. Saves 2 texture image unit samplers and maximizes fragment cache hit rates on G210.
3. **Generative 3D Mesh Ingestion:**
   - *Source Reference:* Tripo AI / Meshy Generative APIs (GLB export standard).
   - *Enforcement Script:* `inspect_glb.py` verifying vertex count, primitive count, and embedded texture dimensions prior to engine import.

---

## 4. HISTORICAL & MECHANICAL RECONCILIATION REFERENCES

1. **DRB Class 52 2-10-0 Steam Locomotive:**
   - *Weight & Consist:* 140.0 tonnes total weight ($1,373\text{ kN}$). Adhesive wheelbase: 75 tonnes ($735.5\text{ kN}$).
   - *Static Resistance:* $18.0\text{ N/kN}$ plain brass journal stiction = $24.71\text{ kN}$.
   - *1:48 Grade Ascent:* Grade resistance = $28.61\text{ kN}$. Starting breakout effort = $53.32\text{ kN}$ [Calculated].
   - *Damp Rail Adhesion:* $\mu = 0.15 \to 110.4\text{ kN}$. Calculated adhesion margin against breakout resistance = $2.07$ [Calculated].
2. **The Outside Bedrock Anomaly:**
   - *Endpoints:* Bronze survey discs `SM-14` and `SM-18` anchored in granite bedrock.
   - *Metric Contradiction:* Continuous rail odometry = $4.30\text{ km}$; direct line-of-sight chained chord = $6.00\text{ km}$.
   - *Triangulation Violation:* $A \to B = 3.20\text{ km}$, $B \to C = 1.80\text{ km}$, baseline $A \to C = 6.40\text{ km}$ ($6.40 > 5.00$, violating Euclidean triangle inequality).
