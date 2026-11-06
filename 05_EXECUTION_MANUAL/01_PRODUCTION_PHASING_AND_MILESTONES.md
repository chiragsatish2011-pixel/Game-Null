# PROJECT NULL — BOOK 05: MASTER EXECUTION MANUAL
## CHAPTER 01: PRODUCTION PHASING, LIFECYCLE & MILESTONE DEFINITIONS

**Document ID:** PNL-B05-CH01  
**Document Version:** 1.0.0  
**Authority:** Production Director (Lead Production Agent)  
**Status:** Authored & Ratified  
**Target Engine:** Godot Engine 4.7.2 Stable (`gl_compatibility` / OpenGL 3.3 Core Profile)  
**Host Hardware:** Windows 11 Home 64-bit | Intel Core i5-12400F | 16 GB DDR4 RAM | NVIDIA GeForce G210 (1024 MB DDR3 VRAM)  

---

## 1. PRODUCTION LIFECYCLE ROADMAP

Project NULL executes across five strictly bounded production phases:

```text
┌────────────────────────────────────────────────────────────────────────────────────────────────────────┐
│                                 PROJECT NULL MASTER PRODUCTION LIFECYCLE                               │
├─────────┬───────────────────────────────────┬──────────────┬───────────────────────────────────────────┤
│ Phase   │ Description                       │ Status       │ Authoritative Milestones & Key Gates      │
├─────────┼───────────────────────────────────┼──────────────┼───────────────────────────────────────────┤
│ Phase 1 │ Complete Story & World Canon      │ LOCKED       │ M1.1–M1.7 (Book 01 Story Bible Locked)    │
│ Phase 2 │ Five Master Production Bibles     │ ACTIVE       │ M2.1–M2.7 (Books 02, 03, 04, 05 Finalized)│
│ Phase 3 │ Cross-Bible Pre-Production Gate   │ QUEUED       │ M3.1 (Greenlight Audit & Hardware Gate)   │
│ Phase 4 │ Vertical Slice Production (Dist 1)│ QUEUED       │ M4.1–M4.6 (v0.2.0 Blockout, v0.3.0 Slice) │
│ Phase 5 │ Full World Expansion & Release    │ QUEUED       │ M5.1–M5.5 (Districts 2–9, Gold Release)   │
└─────────┴───────────────────────────────────┴──────────────┴───────────────────────────────────────────┘
```

---

## 2. PRODUCTION MILESTONE DEFINITIONS & REPOSITORY TAGS

All milestone deliveries correspond to signed Git release tags in the project repository:

### Milestone 1: `v0.1.0-bible-lock` (Current Production Target)
- **Scope:** All five foundational production bibles authored, technically audited, canon reconciled, defect-free, and formally approved.
  - Book 01: Master Story Bible (`01_STORY_BIBLE/BOOK_01_STORY_BIBLE.md`)
  - Book 02: Visual Production Bible (`02_VISUAL_BIBLE/BOOK_02_VISUAL_PRODUCTION_BIBLE.md`)
  - Book 03: Game Engineering Bible (`03_ENGINEERING_BIBLE/BOOK_03_GAME_ENGINEERING_BIBLE.md`)
  - Book 04: Autonomous AI Studio Bible (`04_AI_STUDIO/BOOK_04_AUTONOMOUS_AI_STUDIO_BIBLE.md`)
  - Book 05: Master Execution Manual (`05_EXECUTION_MANUAL/BOOK_05_MASTER_EXECUTION_MANUAL.md`)
- **Acceptance Criteria:**
  - Zero open `CRITICAL` or `MAJOR` review defects in `REVIEW_DEFECT_REGISTER.md`.
  - All automated Python pipeline scripts passing synthetic test suites.
  - Formal sign-off by Creative Director, Technical Director, and Lead Production Agent.

### Milestone 2: `v0.2.0-vertical-slice-blockout` (Phase 4 Entry Gate)
- **Scope:** Initializing the Godot 4.7.2 project in `06_GAME_PROJECT/`.
  - Directory structure initialized with strict typing configurations.
  - Core singletons compiled: `EventBus.gd`, `GameState.gd`, `ClueRegistry.gd`, `TelemetryMonitor.gd`.
  - Graybox CSG layout of District 01: Vesper Central Shunting Cut, Mercer's Tenement Flat 4B, and S-Bahn Platform 2.
  - Player controller compiled: switchable 1st/3rd person camera rig (`camera_rig.gd`), procedural limp gait on `GaitPivot`, and two-stage interaction raycast.
  - Headless test harness verifying camera modes and movement.
- **Hardware Acceptance:**
  - Headless test execution exit code $= 0$.
  - Draw calls $\le 120$ in untextured blockout.

### Milestone 3: `v0.3.0-vertical-slice-verified` (Phase 4 Gold Slice)
- **Scope:** Complete, playable vertical slice of District 01.
  - CSG blockouts baked into static `ArrayMesh` resources.
  - PBR materials applied: $1024\times 1024$ ORM architectural atlases, $512\times 512$ prop atlases.
  - Hero props integrated: `PROP-HERO-01` (Dispatch Order #14), `PROP-HERO-02` (Black Registry Vol I), `PROP-HERO-08` (10L Rescue Oxygen Cylinders).
  - 3D inspection mode functional with main world viewport render suppression.
  - Dialogue engine operational with Elena Mercer and Inspector Janos Vance.
  - Contradiction engine operational: uncovering `LEAD-01` and `LEAD-04`.
- **Hardware Acceptance:**
  - Sustained $\ge 60\text{ FPS}$ on Intel Core i5-12400F + NVIDIA GeForce G210.
  - Peak draw calls $\le 220$ (strictly beneath 250 ceiling).
  - Peak dedicated scene VRAM $\le 350\text{ MB}$ (well within 750 MB provisional ceiling).

### Milestone 4: `v1.0.0-gold-master` (Phase 5 Full Release)
- **Scope:** Complete 5-Act narrative game spanning Districts 01–05, District 09 (The Sunken Ward), The Deep Tiers 1–3, and The Outside. All three tripartite endings playable.

---

## 3. VERTICAL SLICE SCOPE BOUNDARIES (VESPER — DISTRICT 01)

To prevent scope creep and ensure uncompromised quality, Phase 4 is strictly confined to the following physical and forensic boundaries:

```text
┌────────────────────────────────────────────────────────────────────────────────────────┐
│                             VERTICAL SLICE BOUNDARY SPECIFICATION                      │
├────────────────────┬─────────────────────────────┬─────────────────────────────────────┤
│ Boundary Dimension │ Included in Vertical Slice  │ Strictly Excluded (Phase 5 Scope)   │
├────────────────────┼─────────────────────────────┼─────────────────────────────────────┤
│ 1. Exterior World  │ • Vesper Central Shunting   │ • District 02–05 Municipal Streets  │
│                    │   Cut (120m linear street)  │ • District 09 Sunken Ward Over-Slab │
│                    │ • Arch Viaduct & Rail Spur  │ • The Outside (Km 14 to Km 20)      │
├────────────────────┼─────────────────────────────┼─────────────────────────────────────┤
│ 2. Interior Spaces │ • Thomas Mercer's Flat 4B   │ • Bureau 4 Interrogation Chambers   │
│                    │ • Signal Box 04 Control Rm  │ • Konrad Hess Printshop Vaults      │
│                    │ • S-Bahn Station Vestibule  │ • The Deep Shaft 7 Drainage Gallery │
├────────────────────┼─────────────────────────────┼─────────────────────────────────────┤
│ 3. Forensic Loop   │ • 6 Discoverable Clues      │ • Act III–V Clue Catalogs           │
│                    │ • 2 Contradiction Rules     │ • Locomotive #884 Spline Sequence   │
│                    │ • 1 Unlocked Master Lead    │ • Post-Settlement Tribunal Dossiers │
├────────────────────┼─────────────────────────────┼─────────────────────────────────────┤
│ 4. Characters      │ • Thomas Mercer (Player)    │ • Aldous Vane (Civil Magistrate)    │
│                    │ • Elena Mercer (Full Rig)   │ • Konrad Hess (Bookbinder)          │
│                    │ • Inspector Vance (NPC)     │ • 814 Subterranean Deportees        │
└────────────────────┴─────────────────────────────┴─────────────────────────────────────┘
```

---
*End of Chapter 01 Specification.*