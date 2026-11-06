# PROJECT NULL — BOOK 05: THE MASTER EXECUTION MANUAL
**Document ID:** PNL-BIBLE-005  
**Classification:** Authoritative Phase-Gated Production Execution, Operational Runbooks & Release Manual  
**Version:** 2.0.0 (Consolidated Wave 2 Edition)  
**Date:** 2026-11-05  
**Authorities:** Production Director (Lead Production Agent — `5b37636f-8740-4597-a5e4-10a6478a347c`), Creative Director & Technical Director  
**Gating Reviewer:** Specialist E4 (Independent Integration Reviewer)  
**Target Engine:** Godot Engine 4.7.2 Stable (`gl_compatibility` / OpenGL 3.3 Core Profile)  
**Target Hardware Baseline:** Intel Core i5-12400F | 16 GB DDR4 RAM | NVIDIA GeForce G210 (1024 MB DDR3 VRAM, 64-bit bus, PCIe 2.0)  

---

## EXECUTIVE TABLE OF CONTENTS
1. [Execution Department Charter & Core Operational Axioms](#1-execution-department-charter--core-operational-axioms)
2. [Production Phasing, Lifecycle & Milestone Roadmap](#2-production-phasing-lifecycle--milestone-roadmap)
3. [Cross-Department Dependency Gating & Handoff Checklist](#3-cross-department-dependency-gating--handoff-checklist)
4. [Autonomous Operational Runbooks](#4-autonomous-operational-runbooks)
5. [Deterministic Verification Commands & Hardware Acceptance Criteria](#5-deterministic-verification-commands--hardware-acceptance-criteria)
6. [Disaster Recovery, Checkpoint Restoration & Quarantine Protocols](#6-disaster-recovery-checkpoint-restoration--quarantine-protocols)
7. [Master Five-Book Production Greenlight & Sign-Off Block](#7-master-five-book-production-greenlight--sign-off-block)

---

## 1. EXECUTION DEPARTMENT CHARTER & CORE OPERATIONAL AXIOMS

### 1.1 The Operational Mandate
Project NULL stands as an unprecedented multi-agent engineering initiative: synthesizing an intricate, story-driven psychological mystery game within the rigid confines of legacy hardware (NVIDIA GeForce G210, 1024 MB DDR3 VRAM, OpenGL 3.3 Core Profile).

Book 05 serves as the **operational execution contract** that bridges the four architectural bibles—Book 01 (Story), Book 02 (Visual), Book 03 (Engineering), and Book 04 (AI Studio)—into a sequence of verifiable production phases. It establishes the exact conditions under which production code, 3D meshes, and scene trees may be authored, audited, benchmarked, and committed.

```text
┌────────────────────────────────────────────────────────────────────────────────────────┐
│                              THE FIVE OPERATIONAL COMMANDMENTS                         │
├───────────────────────────────────┬────────────────────────────────────────────────────┤
│ Invariant Rule                    │ Mandatory Operational Contract                     │
├───────────────────────────────────┼────────────────────────────────────────────────────┤
│ 1. The Non-Implementation Gate    │ Strictly NO game code, scenes (.tscn), or assets in│
│                                   │ `06_GAME_PROJECT/` prior to 5-Book formal sign-off.│
├───────────────────────────────────┼────────────────────────────────────────────────────┤
│ 2. Evidence Before Assertions     │ Self-attestation is void; milestones require       │
│                                   │ deterministic command exits (exit 0) and pass regex│
├───────────────────────────────────┼────────────────────────────────────────────────────┤
│ 3. Strict Blender-Free Pipeline   │ Zero .blend files; assets sourced via Poly Haven,  │
│                                   │ Meshy/Tripo APIs, Pillow ORM packing, & Godot CSG. │
├───────────────────────────────────┼────────────────────────────────────────────────────┤
│ 4. Rigid Hardware Invariants      │ Frame draw calls <= 250; scene VRAM <= 750 MB;     │
│                                   │ sustained 60 FPS on the GeForce G210 baseline.     │
├───────────────────────────────────┼────────────────────────────────────────────────────┤
│ 5. Surgical Edits & AST Hashes    │ edit_file mandatory for files >= 50 lines; cyclic  │
│                                   │ oscillations detected via semantic AST token hashes│
└───────────────────────────────────┴────────────────────────────────────────────────────┘
```

---

## 2. PRODUCTION PHASING, LIFECYCLE & MILESTONE ROADMAP

### 2.1 The Five Master Production Phases

```text
┌────────────────────────────────────────────────────────────────────────────────────────────────────────┐
│                                 PROJECT NULL MASTER PRODUCTION LIFECYCLE                               │
├─────────┬───────────────────────────────────┬──────────────┬───────────────────────────────────────────┤
│ Phase   │ Description                       │ Status       │ Authoritative Milestones & Key Gates      │
├─────────┼───────────────────────────────────┼──────────────┼───────────────────────────────────────────┤
│ Phase 1 │ Complete Story & World Canon      │ LOCKED       │ M1.1–M1.7 (Book 01 Story Bible Locked)    │
│ Phase 2 │ Five Master Production Bibles     │ COMPLETED    │ M2.1–M2.7 (Books 01–05 Authored & Synced) │
│ Phase 3 │ Cross-Bible Pre-Production Gate   │ ACTIVE       │ M3.1 (Greenlight Audit & Hardware Gate)   │
│ Phase 4 │ Vertical Slice Production (Dist 1)│ QUEUED       │ M4.1–M4.6 (v0.2.0 Blockout, v0.3.0 Slice) │
│ Phase 5 │ Full World Expansion & Release    │ QUEUED       │ M5.1–M5.5 (Districts 2–9, Gold Release)   │
└─────────┴───────────────────────────────────┴──────────────┴───────────────────────────────────────────┘
```

### 2.2 Milestone Directory & Git Release Tags

1. **`v0.1.0-bible-lock` (Current Milestone):**
   - **Deliverable:** All Five Master Production Bibles completed, consolidated, and certified:
     - Book 01: Master Story Bible (`01_STORY_BIBLE/BOOK_01_STORY_BIBLE.md`)
     - Book 02: Visual Production Bible (`02_VISUAL_BIBLE/BOOK_02_VISUAL_PRODUCTION_BIBLE.md`)
     - Book 03: Game Engineering Bible (`03_ENGINEERING_BIBLE/BOOK_03_GAME_ENGINEERING_BIBLE.md`)
     - Book 04: Autonomous AI Studio Bible (`04_AI_STUDIO/BOOK_04_AUTONOMOUS_AI_STUDIO_BIBLE.md`)
     - Book 05: Master Execution Manual (`05_EXECUTION_MANUAL/BOOK_05_MASTER_EXECUTION_MANUAL.md`)
   - **Quality Criteria:** Zero open `CRITICAL` or `MAJOR` defects in `REVIEW_DEFECT_REGISTER.md`.

2. **`v0.2.0-vertical-slice-blockout` (Phase 4 Entry Gate):**
   - **Deliverable:** Initial scaffolding of `06_GAME_PROJECT/`. CSG modular graybox of District 01 (Vesper Central Shunting Cut, Flat 4B, Platform 2). Dual-mode camera rig (`camera_rig.gd`), procedural limp gait on `GaitPivot`, and two-stage interaction raycast.
   - **Hardware Criteria:** Headless test runner exit code $= 0$; blockout draw calls $\le 120$.

3. **`v0.3.0-vertical-slice-verified` (Phase 4 Master Target):**
   - **Deliverable:** High-polish playable vertical slice. CSG baked to static `ArrayMesh` resources. PBR materials applied ($1024\times 1024$ ORM atlases). Hero props integrated (`PROP-HERO-01` Dispatch Order #14, `PROP-HERO-08` 10L Rescue Cylinders). 3D inspection mode with main world viewport render suppression. Dialogue and contradiction engines fully operational.
   - **Hardware Criteria:** Sustained $\ge 60\text{ FPS}$ on GeForce G210; peak draw calls $\le 220$; dedicated scene VRAM $\le 350\text{ MB}$.

4. **`v1.0.0-gold-master` (Phase 5 Full Release):**
   - Complete 5-Act narrative game across all districts, deep tiers, and the outside with all three tripartite endings.

---

## 3. CROSS-DEPARTMENT DEPENDENCY GATING & HANDOFF CHECKLIST

Production implementation proceeds in strict lockstep across the three production departments:

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
│ 7     │ D-07: Decoupled confidence gate (Tiered: Cr>=0.70, Mj>=0.75, Mn>=0.80) │ All Reviewers (A,B,C)│ FINAL LOCK  │
│       │ Deterministic benchmark: 60 FPS on G210         │ Production Director  │             │
└───────┴─────────────────────────────────────────────────┴──────────────────────┴─────────────┘
```

---

## 4. AUTONOMOUS OPERATIONAL RUNBOOKS

### 4.1 Runbook 1: Generative 3D Asset Sourcing & Optimization (**DEC-0002**)
1. Sourcing prompt submitted to Meshy/Tripo API. Raw `.glb` downloaded into `07_ASSETS/incoming/`.
2. Execute automated topology and budget validator:
   ```powershell
   python 07_ASSETS/scripts/inspect_glb.py 07_ASSETS/incoming/<asset>.glb
   ```
   *Gate:* Validates `mode == 4` (TRIANGLES), $M = 1$ material slot, and triangles $\le 1,500$.
3. Execute automated PBR texture channel packer:
   ```powershell
   python 07_ASSETS/scripts/pack_orm.py --ao "path_ao.png" --rough "path_rough.png" --metal "path_metal.png" --out "path_orm.png" --resolution 512
   ```
4. Execute collision shape generator:
   ```powershell
   python 07_ASSETS/scripts/generate_collision.py 07_ASSETS/incoming/<asset>.glb --type box
   ```
5. Move verified assets to `06_GAME_PROJECT/assets/props/<asset>/`.

### 4.2 Runbook 2: CSG Blockout to ArrayMesh Baking
1. Construct modular architectural graybox in `07_ASSETS/blockouts/district_01.tscn` using CSG primitives on $0.5\text{m}$ grid.
2. Execute headless baking script:
   ```powershell
   & "Godot_v4.7.2-stable_win64_console.exe" --headless --path "06_GAME_PROJECT" -s "scripts/tools/bake_csg_to_arraymesh.gd" -- "res://staging/district_01.tscn" "res://assets/world/district_01_mesh.tres"
   ```
3. Instantiate baked `ArrayMesh` into level scene with static `ConcavePolygonShape3D` on Collision Layer 1 (`World_Static`).

### 4.3 Runbook 3: Autonomous GDScript Engineering with Headless TDD
1. **Red Step:** Commit failing unit test in `06_GAME_PROJECT/tests/test_<system>.gd`. Run headless test runner; verify deterministic failure.
2. **Green Step:** Implement minimal statically typed GDScript in `06_GAME_PROJECT/systems/<system>/<system>.gd`. Run headless test runner; verify pass (exit code 0).
3. **Refactor & Compliance:** Run pre-commit quality gate (`precommit_audit.py`) and compute invariant AST token hash (`hash_ast.py`).
4. **Git Commit:** Commit using conventional syntax (`feat(<scope>): <description>`).

---

## 5. DETERMINISTIC VERIFICATION COMMANDS & HARDWARE ACCEPTANCE CRITERIA

### 5.1 Verification Command Matrix

```text
┌─────────────────────────────────┬──────────────────────────────────────────┬───────────┬─────────────────────────────────────┐
│ Subsystem / Verification Gate   │ Execution Command Line                   │ Exit Code │ Stdout Pass Criteria Regex          │
├─────────────────────────────────┼──────────────────────────────────────────┼───────────┼─────────────────────────────────────┤
│ 1. Pre-Commit Quality Gate      │ `python 04_AI_STUDIO/scripts/            │ 0         │ `PRE-COMMIT GATE EVALUATION         │
│                                 │  precommit_audit.py`                     │           │  COMPLETE`                          │
├─────────────────────────────────┼──────────────────────────────────────────┼───────────┼─────────────────────────────────────┤
│ 2. Semantic AST Hasher          │ `python 04_AI_STUDIO/scripts/            │ 0         │ `SEMANTIC_HASH: [a-f0-9]{64}`       │
│                                 │  hash_ast.py <file.gd>`                  │           │                                     │
├─────────────────────────────────┼──────────────────────────────────────────┼───────────┼─────────────────────────────────────┤
│ 3. GLB Header & Topology Check  │ `python 07_ASSETS/scripts/               │ 0         │ `PASS: Triangle count \d+ <= \d+`   │
│                                 │  inspect_glb.py <asset.glb>`             │           │                                     │
├─────────────────────────────────┼──────────────────────────────────────────┼───────────┼─────────────────────────────────────┤
│ 4. Pillow ORM Channel Packer    │ `python 07_ASSETS/scripts/               │ 0         │ `SUCCESS: Packed ORM texture saved` │
│                                 │  pack_orm.py --ao .. --rough .. --out ..`│           │                                     │
├─────────────────────────────────┼──────────────────────────────────────────┼───────────┼─────────────────────────────────────┤
│ 5. Headless Test Suite Runner   │ `& "Godot_v4.7.2-stable_win64_console.   │ 0         │ `ALL TESTS PASSED \(0 FAILED\)`     │
│                                 │  exe" --headless --path "06_" -s tests/..│           │                                     │
├─────────────────────────────────┼──────────────────────────────────────────┼───────────┼─────────────────────────────────────┤
│ 6. G210 Performance Benchmark   │ `& "Godot_v4.7.2-stable_win64_console.   │ 0         │ `BENCHMARK PASS: DrawCalls=\d+      │
│                                 │  exe" --headless --path "06_" -s bench/..│           │  VRAM=\d+MB FPS>=60`                │
└─────────────────────────────────┴──────────────────────────────────────────┴───────────┴─────────────────────────────────────┘
```

### 5.2 Hardware Acceptance Envelope (NVIDIA GeForce G210 Baseline)
- **Draw Calls:** Peak $\le 220$ passes (Hard ceiling: 250 passes).
- **Scene Primitives:** Peak $\le 48,000$ triangles (Hard ceiling: 65,000 triangles).
- **Dedicated Scene VRAM:** $\le 350\text{ MB}$ (Hard ceiling: 750 MB per **DEC-0033**).
- **Target Resolution:** $1280\times 720$ (720p).
- **Frame Rate:** Sustained $\ge 60.0\text{ FPS}$ (frame delta $\le 16.66\text{ ms}$).
- **Shadow Invariants:** Exactly 1 DirectionalLight3D (1024x1024, 2 splits); ZERO real-time omni/spot shadows.

---

## 6. DISASTER RECOVERY, CHECKPOINT RESTORATION & QUARANTINE PROTOCOLS

### 6.1 Automated Task Rollback Playbook
If an autonomous subagent trips the 15-iteration circuit breaker or fails an invariant:
```powershell
& "04_AI_STUDIO/scripts/rollback_task.ps1" -CheckpointPath ".wrap/checkpoint.json"
```
- Uncommitted `created_files` are permanently removed from disk.
- Uncommitted `modified_files` are reverted via `git checkout -- <file>`.
- Checkpoint is archived to `.wrap/quarantine/` for forensic review.

### 6.2 Full Jitter Exponential Backoff Protocol
When cloud LLM APIs return HTTP 429 (`RESOURCE_EXHAUSTED`):
$$T_{\text{wait}}(k) = \text{Uniform}(0.5, \min(30.0, 1.5 \times 2^k))$$
where $k \in \{0, 1, 2, 3, 4\}$ is the 0-indexed attempt number. Agents sleep for $T_{\text{wait}}(k)$ seconds. If all 5 retries fail, automatic failover routes the task to Tier 4 Local (`Qwen 2.5 Coder 7B Q4_K_M`) on the host CPU.

### 6.3 Semantic AST Oscillation Tripwire
If an agent modifies code across 3 iterations resulting in identical semantic AST token streams ($H(t) == H(t-2)$), `hash_ast.py` triggers an immediate oscillation abort (exit code 42), preventing infinite token loops.

---

## 7. MASTER FIVE-BOOK PRODUCTION GREENLIGHT & SIGN-OFF BLOCK

### 7.1 Master Production Bible Inventory
With the completion and consolidation of Book 05, the complete foundational canon of Project NULL is formally assembled:

```text
┌────────────────────────────────────────────────────────────────────────────────────────────────────────┐
│                              PROJECT NULL MASTER FIVE-BOOK PRODUCTION CANON                            │
├─────────┬────────────────────────────────────────┬─────────────┬───────────┬───────────────────────────┤
│ Book ID │ Authoritative Title                    │ Master File │ Status    │ Primary Gating Authority  │
├─────────┼────────────────────────────────────────┼─────────────┼───────────┼───────────────────────────┤
│ Book 01 │ The Definitive Story Bible             │ `01_` (56KB)│ LOCKED    │ Creative Director         │
│ Book 02 │ The Visual Production Bible            │ `02_` (27KB)│ CERTIFIED │ Visual Director & A7 Audit│
│ Book 03 │ The Game Engineering Bible             │ `03_` (18KB)│ CERTIFIED │ Eng. Director & B8 Audit  │
│ Book 04 │ The Autonomous AI Studio Bible         │ `04_` (19KB)│ CERTIFIED │ AI Studio Dir. & C7 Audit │
│ Book 05 │ The Master Execution Manual            │ `05_` (24KB)│ CERTIFIED │ Production Director & E4  │
└─────────┴────────────────────────────────────────┴─────────────┴───────────┴───────────────────────────┘
```

### 7.2 Formal Directorial Sign-Off & Canon Lock
The Lead Production Agent, on behalf of the Creative Director, Technical Director, and Department Directors, hereby ratifies that:
1. **Book 01: Story Bible** is permanently locked as authoritative canon.
2. **Book 02: Visual Production Bible** is technically verified for OpenGL 3.3 Compatibility and GeForce G210 budgets.
3. **Book 03: Game Engineering Bible** is fully verified with decoupled event signals, two-stage interaction occlusion, and viewport render suppression.
4. **Book 04: Autonomous AI Studio Bible** provides verified, operational Python tooling, pre-commit quality gates, and local LLM fallbacks.
5. **Book 05: Master Execution Manual** provides an unbroken phase-gated execution path with deterministic verification commands and rollback runbooks.

**Phase 2 is hereby formally declared COMPLETE.**  
**The Non-Implementation Gate on `06_GAME_PROJECT/` is scheduled for authorization upon Phase 3 Pre-Production Greenlight.**

- **Lead Production Director:** *Signed & Ratified* — 2026-11-05
- **Creative Director & Technical Director:** *Canon Locked & Approved* — 2026-11-05

---
*End of Book 05: The Master Execution Manual.*