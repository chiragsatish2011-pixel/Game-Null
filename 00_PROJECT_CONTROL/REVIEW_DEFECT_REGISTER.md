# PROJECT NULL — REVIEW DEFECT & QUALITY AUDIT REGISTER
**Document ID:** PNL-DEF-001  
**Authority:** Creative Director & Technical Director  
**Maintained By:** Production Director (Lead Production Agent)  
**Date:** 2026-11-05  
**Status:** ACTIVE DEFECT TRACKING REGISTER

---

## 1. PURPOSE & QUALITY GATING PROTOCOL

This register logs all architectural defects, technical contradictions, missing implementation details, hardware budget overruns, and narrative inconsistencies discovered during Phase 2 reviews.

No book may proceed past Wave 5 Quality Gate with any unaddressed `CRITICAL` or `MAJOR` severity defect.

---

## 2. DEFECT LOG & RESOLUTION TRACKING

```
┌──────────────────────────────────────────────────────────────────────────────────────────────────────────┐
│                               PHASE 2 REVIEW DEFECT & AUDIT LOG                                          │
├─────┬────────┬──────────────────────────┬──────────┬─────────────────────────────────┬───────────────────┤
│ ID  │ Dept   │ Defect Description       │ Severity │ Corrective Action / Resolution  │ Status            │
├─────┼────────┼──────────────────────────┼──────────┼─────────────────────────────────┼───────────────────┤
│ X-01│ Dept A │ Universal 1,500-triangle │ MAJOR    │ Replaced with category budgets: │ [RESOLVED / DEC31]│
│     │        │ limit degrades character │          │ Characters (3.5k-5k), hero props│                   │
│     │        │ silhouettes.             │          │ (1.2k-2.5k), minor (250-800).   │                   │
├─────┼────────┼──────────────────────────┼──────────┼─────────────────────────────────┼───────────────────┤
│ X-02│ Dept A │ Claimed ORM packing      │ MAJOR    │ Corrected in PNL-AUDIT-001:     │ [RESOLVED / DEC31]│
│     │        │ saves "66% VRAM" auto-   │          │ Saves sampler units (1 vs 3) and│                   │
│     │        │ matically without nuance.│          │ memory fetch cache lines.       │                   │
├─────┼────────┼──────────────────────────┼──────────┼─────────────────────────────────┼───────────────────┤
│ X-03│ Dept B │ Blanket 850 MB VRAM cap  │ MAJOR    │ Subdivided into scene tiers:    │ [RESOLVED / DEC31]│
│     │        │ ignores 150-250 MB OS /  │          │ UI ≤350MB, Interior ≤550MB,     │                   │
│     │        │ DWM driver overhead.     │          │ Complex Exterior ≤750MB max.    │                   │
├─────┼────────┼──────────────────────────┼──────────┼─────────────────────────────────┼───────────────────┤
│ X-04│ Dept B │ Attempting multi-body    │ MAJOR    │ Decoupled runtime gameplay from │ [RESOLVED / DEC31]│
│     │        │ train dynamic physics    │          │ narrative canon: kinematic      │                   │
│     │        │ simulation on G210 CPU.  │          │ PathFollow3D spline traversal.  │                   │
├─────┼────────┼──────────────────────────┼──────────┼─────────────────────────────────┼───────────────────┤
│ X-05│ Dept B │ Claiming raw 18.4 Hz     │ CRITICAL │ Corrected: Inaudible to human   │ [RESOLVED / DEC31]│
│     │        │ audio erases memories    │          │ ears; sound design uses audible │                   │
│     │        │ directly on speakers.    │          │ harmonics (36.8, 55.2, 73.6Hz). │                   │
├─────┼────────┼──────────────────────────┼──────────┼─────────────────────────────────┼───────────────────┤
│ R-01│ Dept A │ MultiMesh unconditional  │ MAJOR    │ Remove unconditional 9 draw call│ [RESOLVED & CLOSED]│
│     │ Dept B │ 9 draw-call claim lacks  │          │ claim. Document batching rules, │ (A7/B8 Verified)  │
│     │        │ material/surface nuances.│          │ shadow passes, and visibility.  │                   │
├─────┼────────┼──────────────────────────┼──────────┼─────────────────────────────────┼───────────────────┤
│ R-02│ Dept A │ Banning blend shapes     │ MAJOR    │ Investigate Godot 4.7.2 Compa-  │ [RESOLVED & CLOSED]│
│     │ Dept B │ without empirical memory │          │ tibility handling of morphs vs  │ (Hybrid 8-bone +  │
│     │        │ bus bandwidth profiling. │          │ skeletal rigs; compare hybrid.  │ 2-morph ratified) │
├─────┼────────┼──────────────────────────┼──────────┼─────────────────────────────────┼───────────────────┤
│ R-03│ Dept C │ Arbitrary 40% mutation   │ MAJOR    │ Revoke 40% rule; establish      │ [RESOLVED & CLOSED]│
│     │        │ threshold forces code    │          │ surgical edit policy based on   │ (DEC-0034 ratified│
│     │        │ distortion or bloat.     │          │ scope, preservation, and risk.  │ Multi-Dim Policy) │
├─────┼────────┼──────────────────────────┼──────────┼─────────────────────────────────┼───────────────────┤
│ R-04│ Dept B │ Hardware claims blur     │ MAJOR    │ Separate manufacturer specs,    │ [RESOLVED & CLOSED]│
│     │ Dept C │ specs, driver reports,   │          │ driver reports, engine docs, and│ (5-tier taxonomy  │
│     │        │ and measured results.    │          │ measured live execution data.   │ DEC-0033 applied) │
├─────┼────────┼──────────────────────────┼──────────┼─────────────────────────────────┼───────────────────┤
│ R-05│ Dept B │ Player controller 2-ray- │ MINOR    │ Re-evaluate 2-raycast global cap│ [RESOLVED & CLOSED]│
│     │        │ cast limit and ShapeCast │          │ and ShapeCast sizing; provide   │ (Two-Stage LoS &  │
│     │        │ size lack gameplay basis.│          │ gameplay justification.         │ Layer 1 occluded) │
├─────┼────────┼──────────────────────────┼──────────┼─────────────────────────────────┼───────────────────┤
│ R-06│ Dept A │ Character continuity and │ MAJOR    │ Verify Elena's illness (V3.4    │ [RESOLVED & CLOSED]│
│     │ Dept B │ injury presentation must │          │ nasal cannula, no deathbed spec-│ (A2/A3/B3 Synced; │
│     │        │ match Book 01 precisely. │          │ tacle) & Thomas's limp across   │ PROP-HERO-08 locked)
├─────┼────────┼──────────────────────────┼──────────┼─────────────────────────────────┼───────────────────┤
│A7-01│ Dept A │ Unconditional 9 draw-call│ MAJOR    │ Replace with chunked formula    │ [RESOLVED & CLOSED]│
│(R01)│ (01_ENV│ MultiMesh claim ignores  │          │ (32mx32m cells), cast_shadow    │ (A7 Certified)    │
│     │        │ surfaces & shadow splits.│          │ rules, and baked ArrayMesh.     │                   │
├─────┼────────┼──────────────────────────┼──────────┼─────────────────────────────────┼───────────────────┤
│A7-02│ Dept A │ Blend shape DDR3 bus     │ MAJOR    │ Retract bus saturation claim;   │ [RESOLVED & CLOSED]│
│(R02)│ (02_CHA│ claim false (0.27%);     │          │ replace 4-bone rig with 8-bone  │ (A7 Certified)    │
│     │        │ 4-bone rig lacks eyelids.│          │ hybrid rig for blinks/phonemes. │                   │
├─────┼────────┼──────────────────────────┼──────────┼─────────────────────────────────┼───────────────────┤
│A7-03│ Dept A │ Omission of Elena nasal  │ MAJOR    │ Add nasal cannula hero prop spec│ [RESOLVED & CLOSED]│
│(R06)│ (02/03)│ cannula & 10L cylinders; │          │ (1.8 L/min) in A2; add PROP-    │ (A7 Certified)    │
│     │        │ age errors Vance 61/72.  │          │ HERO-08 in A3 prop design.      │                   │
├─────┼────────┼──────────────────────────┼──────────┼─────────────────────────────────┼───────────────────┤
│A7-04│ Dept A │ Missing quantitative IK  │ MINOR    │ Add max right knee flexion (35°)│ [RESOLVED & CLOSED]│
│     │ (02_CHA│ limits for Thomas's limp.│          │ and stance timing (0.35s/0.55s).│ (A7 Certified)    │
├─────┼────────┼──────────────────────────┼──────────┼─────────────────────────────────┼───────────────────┤
│C7-01│ Dept C │ 32B Local LLM requires   │ CRITICAL │ Replace Qwen 32B with Qwen 2.5  │ [RESOLVED & CLOSED]│
│     │ (02_MOD│ ~20 GB RAM; host has 16GB│          │ Coder 7B Q4_K_M (4.5GB RAM,     │ (C7 Certified)    │
│     │        │ DDR4. Max speed ~1.8 t/s.│          │ 7-10.5 t/s on i5-12400F).       │                   │
├─────┼────────┼──────────────────────────┼──────────┼─────────────────────────────────┼───────────────────┤
│C7-02│ Dept C │ 40% file mutation cutoff │ MAJOR    │ Strike down 40% rule; institute │ [RESOLVED & CLOSED]│
│(R03)│ (01/02)│ creates perverse bloat   │          │ Multi-Dimensional Surgical Edit │ (C7 Certified)    │
│     │        │ and destroys git blame.  │          │ Policy (edit_file for files≥50L)│                   │
├─────┼────────┼──────────────────────────┼──────────┼─────────────────────────────────┼───────────────────┤
│C7-03│ Dept C │ Confidence formula with  │ MAJOR    │ Decouple Severity from Certainty│ [RESOLVED & CLOSED]│
│     │ (01_ORC│ 0.85 cap suppresses 100% │          │ Tiered cutoffs: Critical ≥0.70, │ (C7 Certified)    │
│     │        │ of Minor defects.        │          │ Major ≥0.75, Minor ≥0.80.       │                   │
├─────┼────────┼──────────────────────────┼──────────┼─────────────────────────────────┼───────────────────┤
│C7-04│ Dept C │ Backoff jitter desync    │ MAJOR    │ Standardize on Full Jitter:     │ [RESOLVED & CLOSED]│
│     │ (01/02)│ between Ch 01 and Ch 03. │          │ Uniform(0.5, min(30, 1.5 * 2^k))│ (C7 Certified)    │
├─────┼────────┼──────────────────────────┼──────────┼─────────────────────────────────┼───────────────────┤
│C7-05│ Dept C │ Wrap-Loop raw hash blinded│ MAJOR   │ Implement AST/semantic hashing  │ [RESOLVED & CLOSED]│
│     │ (01_ORC│ by dynamic ISO timestamps│          │ and track created_files cleanup.│ (C7 Certified)    │
├─────┼────────┼──────────────────────────┼──────────┼─────────────────────────────────┼───────────────────┤
│C7-06│ Dept C │ Vendor claims labeled as │ MINOR    │ Downgrade unmeasured claims to  │ [RESOLVED & CLOSED]│
│(R04)│ (02_MOD│ [Measured Result].       │          │ [Engineering Estimate].         │ (C7 Certified)    │
├─────┼────────┼──────────────────────────┼──────────┼─────────────────────────────────┼───────────────────┤
│C7-07│ Dept C │ Budget sensitive to cache│ MINOR    │ Add explicit 52% cache retention│ [RESOLVED & CLOSED]│
│     │ (02_MOD│ retention below 52%.     │          │ boundary to projections.        │ (C7 Certified)    │
├─────┼────────┼──────────────────────────┼──────────┼─────────────────────────────────┼───────────────────┤
│C7-08│ Dept C │ Resurfacing of 40% churn │ MAJOR    │ Surgically replace with Multi-  │ [RESOLVED & CLOSED]│
│(R03)│ (03_TOO│ rule in Ch 04 tool audit │          │ Dimensional Surgical Edit Policy│ (C7 Certified)    │
├─────┼────────┼──────────────────────────┼──────────┼─────────────────────────────────┼───────────────────┤
│C7-09│ Dept C │ Ambiguous proposed MCP   │ MINOR    │ Harmonize name godot-engine-mcp │ [RESOLVED & CLOSED]│
│     │ (03_TOO│ server naming & call risk│          │ (Proposed) & add warning callout│ (C7 Certified)    │
├─────┼────────┼──────────────────────────┼──────────┼─────────────────────────────────┼───────────────────┤
│C7-10│ Dept C │ GLB inspector mode check │ MINOR    │ Add mode==4 check prior to      │ [RESOLVED & CLOSED]│
│     │ (03_TOO│ missing in inspect_glb.py│          │ unindexed triangle division     │ (C7 Certified)    │
├─────┼────────┼──────────────────────────┼──────────┼─────────────────────────────────┼───────────────────┤
│B8-01│ Dept B │ MultiMesh 4 draw-call    │ MAJOR    │ Retract 4 draw-call claim; doc  │ [RESOLVED & CLOSED]│
│(R01)│ (01_GOD│ claim ignores 2-split    │          │ PSSM shadow cascades, single    │ (B8 Certified)    │
│     │        │ PSSM & multi-surface.    │          │ surface trim sheets & chunking. │                   │
├─────┼────────┼──────────────────────────┼──────────┼─────────────────────────────────┼───────────────────┤
│B8-02│ Dept B │ Transform feedback morph │ MAJOR    │ Specify hybrid rig: 48 body + 6 │ [RESOLVED & CLOSED]│
│(R02)│ (01_GOD│ bottleneck & sync stalls │          │ facial bones + max 2 blendshapes│ (B8 Certified)    │
│     │        │ on G210 64-bit DDR3 bus. │          │ on 1-surface head mesh (<2.5m). │                   │
├─────┼────────┼──────────────────────────┼──────────┼─────────────────────────────────┼───────────────────┤
│B8-03│ Dept B │ 750 MB VRAM target not   │ MAJOR    │ Reclassify to [Unverified       │ [RESOLVED & CLOSED]│
│(R04)│ (01_GOD│ reclassified per DEC-0033│          │ Assumption] per DEC-0033; add   │ (B8 Certified)    │
│     │        │ & missing VRAM measuring.│          │ dual-channel counter methodology│                   │
├─────┼────────┼──────────────────────────┼──────────┼─────────────────────────────────┼───────────────────┤
│B8-04│ Dept B │ ShapeCast penetrates     │ CRITICAL │ Mask omitted Layer 1; add two-  │ [RESOLVED & CLOSED]│
│(R05)│ (02_PLA│ walls/doors; no LoS check│          │ stage LoS ray against Layer 1;  │ (B8 Verified)     │
│     │        │ allowing wall exploits.  │          │ reduce radius to 0.15-0.20m.    │                   │
├─────┼────────┼──────────────────────────┼──────────┼─────────────────────────────────┼───────────────────┤
│B8-05│ Dept B │ Broken tree lookup crash │ CRITICAL │ Fix line 672 node path from     │ [RESOLVED & CLOSED]│
│     │ (02_PLA│ in player_controller.gd  │          │ 3x get_parent() to CameraMount  │ (B8 Verified)     │
├─────┼────────┼──────────────────────────┼──────────┼─────────────────────────────────┼───────────────────┤
│B8-06│ Dept B │ Missing input lock signal│ MAJOR    │ Connect to player_input_lock;   │ [RESOLVED & CLOSED]│
│(DEP)│ (02_PLA│ & camera toggle locked.  │          │ freeze translation but keep V/R3│ (B8 Verified)     │
│     │        │                          │          │ camera mode toggle 100% unlocked│                   │
├─────┼────────┼──────────────────────────┼──────────┼─────────────────────────────────┼───────────────────┤
│B8-07│ Dept B │ Folio weight speed cut   │ MAJOR    │ Implement phenomenological limp │ [RESOLVED & CLOSED]│
│(DEP)│ (02_PLA│ is gamified, not physical│          │ depth (Ar -0.052m), roll (3.2°),│ (B8 Verified)     │
│     │        │                          │          │ 40% inertia reduction & 1-arm.  │                   │
├─────┼────────┼──────────────────────────┼──────────┼─────────────────────────────────┼───────────────────┤
│B8-08│ Dept B │ Main world viewport not  │ MAJOR    │ Suspend main viewport rendering │ [RESOLVED & CLOSED]│
│     │ (03_INV│ suspended during examine │          │ in item_examiner.gd; fix table  │ (B8 Verified)     │
├─────┼────────┼──────────────────────────┼──────────┼─────────────────────────────────┼───────────────────┤
│B8-09│ Dept B │ Clue DOC-007 and CONT-04 │ MAJOR    │ Add DOC-007 to clue table 3.4 & │ [RESOLVED & CLOSED]│
│     │ (03_INV│ missing from registry    │          │ register CONT-04 contradiction  │ (B8 Verified)     │
├─────┼────────┼──────────────────────────┼──────────┼─────────────────────────────────┼───────────────────┤
│B8-10│ Dept B │ In-world clue anchor and │ MAJOR    │ Define ClueWorldAnchor Area3D on│ [RESOLVED & CLOSED]│
│     │ (03_INV│ LoS occlusion missing    │          │ Layer 2; specify LoS ray to L1  │ (B8 Verified)     │
├─────┼────────┼──────────────────────────┼──────────┼─────────────────────────────────┼───────────────────┤
│B8-11│ Dept B │ close_inspection ID bug  │ MINOR    │ Cache ID before clearing active │ [RESOLVED & CLOSED]│
│     │ (03_INV│ emits empty StringName   │          │ clue data; emit actual ID       │ (B8 Verified)     │
├─────┼────────┼──────────────────────────┼──────────┼─────────────────────────────────┼───────────────────┤
│B8-12│ Dept B │ Hardware evidence not    │ MINOR    │ Stratify Section 1.3 into 4-tier│ [RESOLVED & CLOSED]│
│     │ (03_INV│ stratified in Section 1.3│          │ taxonomy                        │ (B8 Verified)     │
├─────┼────────┼──────────────────────────┼──────────┼─────────────────────────────────┼───────────────────┤
│AUD01│ Dept C │ Flat 85% confidence rule │ MAJOR    │ Reconciled to decoupled Certainty│ [RESOLVED & CLOSED]│
│(P03)│ (06/B04│ suppressed minor defects │          │ Tiered cutoffs: Cr>=.70, Mj>=.75│ (E4 Verified)     │
├─────┼────────┼──────────────────────────┼──────────┼─────────────────────────────────┼───────────────────┤
│AUD02│ Dept C │ Full Jitter desync: 2s/60│ MAJOR    │ Standardized to Uniform(0.5s,   │ [RESOLVED & CLOSED]│
│(P03)│ (06/B04│ vs 1.5s/30s attempt index│          │ min(30s, 1.5s*2^k)) k in [0,4]  │ (E4 Verified)     │
├─────┼────────┼──────────────────────────┼──────────┼─────────────────────────────────┼───────────────────┤
│AUD03│ Dept C │ inspect_glb.py failed exit│ CRITICAL│ Implemented --test-synthetic;   │ [RESOLVED & CLOSED]│
│(P03)│ (07_ASS│ code 1 on synthetic test │          │ verified glTF 2.0 binary exit 0 │ (Live Tested)     │
├─────┼────────┼──────────────────────────┼──────────┼─────────────────────────────────┼───────────────────┤
│AUD04│ Root   │ git status failed exit 1;│ CRITICAL │ Initialized git repo (main);    │ [RESOLVED & CLOSED]│
│(P03)│ Worksp.│ not a git repository     │          │ verified clean tracking exit 0  │ (Live Tested)     │
├─────┼────────┼──────────────────────────┼──────────┼─────────────────────────────────┼───────────────────┤
│AUD05│ Dept C │ Missing incoming/quaran- │ MINOR    │ Created 07_ASSETS/incoming and  │ [RESOLVED & CLOSED]│
│(P03)│ (07_ASS│ tine dirs broke scripts  │          │ quarantine dirs; verified writes│ (Live Tested)     │
├─────┼────────┼──────────────────────────┼──────────┼─────────────────────────────────┼───────────────────┤
│AUD06│ Root   │ .gitignore ignored       │ CRITICAL │ Removed *.import from gitignore;│ [RESOLVED & CLOSED]│
│(P03)│ Worksp.│ *.import sidecar files   │          │ preserves VRAM block compression│ (Live Verified)   │
├─────┼────────┼──────────────────────────┼──────────┼─────────────────────────────────┼───────────────────┤
│AUD07│ Dept C │ NameError: block_reasons │ CRITICAL │ Returned can_commit, blocking_  │ [RESOLVED & CLOSED]│
│(P03)│ (04_AI)│ in precommit_audit.py    │          │ defects; guarded JSON loading   │ (Live Tested)     │
├─────┼────────┼──────────────────────────┼──────────┼─────────────────────────────────┼───────────────────┤
│AUD08│ Dept C │ vertex_count key mismatch│ CRITICAL │ Checked total_vertices & tris   │ [RESOLVED & CLOSED]│
│(P03)│ (07_ASS│ in generate_collision.py │          │ from inspect_glb geometry dict  │ (Live Tested)     │
├─────┼────────┼──────────────────────────┼──────────┼─────────────────────────────────┼───────────────────┤
│AUD09│ Dept C │ Planar mesh crash (dz=0) │ MAJOR    │ Clamped thin dimensions to      │ [RESOLVED & CLOSED]│
│(P03)│ (07_ASS│ in generate_collision.py │          │ minimum 0.01m thickness         │ (Live Tested)     │
├─────┼────────┼──────────────────────────┼──────────┼─────────────────────────────────┼───────────────────┤
│AUD10│ Dept C │ pack_orm.py silent pass  │ MAJOR    │ Added missing file warning &    │ [RESOLVED & CLOSED]│
│(P03)│ (07_ASS│ on missing texture paths │          │ --strict flag for CI exit 1     │ (Live Tested)     │
├─────┼────────┼──────────────────────────┼──────────┼─────────────────────────────────┼───────────────────┤
│AUD11│ Dept C │ pack_orm.py lossy WebP   │ MAJOR    │ Configured lossless=True for    │ [RESOLVED & CLOSED]│
│(P03)│ (07_ASS│ artifacts on PBR masks   │          │ WebP PBR mask export            │ (Live Tested)     │
├─────┼────────┼──────────────────────────┼──────────┼─────────────────────────────────┼───────────────────┤
│AUD12│ Dept C │ dy/2 offset displacement │ MAJOR    │ Computed center offset from     │ [RESOLVED & CLOSED]│
│(P03)│ (07_ASS│ on origin-centered models│          │ (min_bound + max_bound) / 2.0   │ (Live Tested)     │
└─────┴────────┴──────────────────────────┴──────────┴─────────────────────────────────┴───────────────────┘
```

---

## 3. WAVE 5 REVIEW CRITERIA

All independent reviewers (Specialists A7, B8, C7) must evaluate deliverables against the following non-negotiable gates:
1. **OpenGL 3.3 Strict Compatibility:** Zero Vulkan or compute shader calls.
2. **G210 VRAM & Draw Call Budget:** Visible geometry must fit within 250 draw calls and 750 MB VRAM ceiling under worst-case camera frustums.
3. **Blender-Free Workflow:** Zero `.blend` files or manual DCC modeling steps in asset pipelines.
4. **Narrative Canon Fidelity:** Complete consistency with locked Book 01 Story Bible.
