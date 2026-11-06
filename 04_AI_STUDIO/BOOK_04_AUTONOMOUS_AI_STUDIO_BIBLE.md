# PROJECT NULL — BOOK 04: THE AUTONOMOUS AI STUDIO BIBLE
**Document ID:** PNL-BIBLE-004  
**Classification:** Authoritative Autonomous AI Multi-Agent Systems & Infrastructure Specification  
**Version:** 2.0.0 (Consolidated Wave 2 Edition)  
**Date:** 2026-11-05  
**Authorities:** AI Studio Director (`540370cc-b9d9-443b-9b55-e0ed59f744f3`), Lead Technical Director & Creative Director  
**Gating Reviewer:** Specialist C7 (AI Studio Reviewer — Certified in `PNL-AUDIT-C7-FINAL-001`)  
**Target Engine:** Godot Engine 4.7.2 Stable (`gl_compatibility` / OpenGL 3.3 Core Profile)  
**Host Architecture:** Windows 11 Home 64-bit | Intel Core i5-12400F | 16 GB DDR4 RAM | NVIDIA GeForce G210 (1024 MB DDR3 VRAM)  

---

## EXECUTIVE TABLE OF CONTENTS
1. [AI Studio Department Charter & Autonomous Mandate](#1-ai-studio-department-charter--autonomous-mandate)
2. [Hierarchical Multi-Agent Orchestration & Context Window Hygiene](#2-hierarchical-multi-agent-orchestration--context-window-hygiene)
3. [Model Routing Tiers, Quota Economics & Local LLM Baseline](#3-model-routing-tiers-quota-economics--local-llm-baseline)
4. [Antigravity Tools, MCP Contracts & Execution Sandboxing](#4-antigravity-tools-mcp-contracts--execution-sandboxing)
5. [Strict Blender-Free Generative 3D Asset Pipeline](#5-strict-blender-free-generative-3d-asset-pipeline)
6. [Autonomous GDScript Engineering, Headless TDD & Review Swarm](#6-autonomous-gdscript-engineering-headless-tdd--review-swarm)
7. [Governance Boundaries, Wrap Loop Self-Healing & Disaster Recovery](#7-governance-boundaries-wrap-loop-self-healing--disaster-recovery)
8. [Permanent Production Ledger & Audit Trail](#8-permanent-production-ledger--audit-trail)
9. [Cross-Department Ratification & Master AI Studio Sign-Off](#9-cross-department-ratification--master-ai-studio-sign-off)

---

## 1. AI STUDIO DEPARTMENT CHARTER & AUTONOMOUS MANDATE

### 1.1 The Operational Mandate
Project NULL represents an unprecedented synthesis of autonomous multi-agent software engineering and game development. Unlike superficial agent scripts that generate isolated snippets or chat responses, Department C establishes an industrial-grade autonomous studio infrastructure capable of:
1. Coordinating 20+ specialized agents across parallel visual, engineering, and narrative disciplines.
2. Managing context length constraints through strict hierarchical summarization and token-efficient surgical edits.
3. Operating without Blender, using automated Python geometry processors, Pillow texture packers, and generative 3D cloud APIs.
4. Enforcing test-driven development (TDD) via headless Godot 4.7.2 CLI execution and pre-commit multi-agent review swarms.
5. Guaranteeing deterministic crash recovery, oscillation prevention, and rollback capabilities via atomic checkpoints.

### 1.2 The Five Core Studio Axioms
- **Axiom 1: The Documented Path Principle.** Agents operate strictly through documented, sanctioned APIs, tools, and protocols. Probing host vulnerabilities, tampering with system files outside workspace bounds, or fabricating execution results is strictly prohibited.
- **Axiom 2: The Non-Implementation Gate.** Strictly zero production gameplay scenes, scripts, or final assets may be created in `06_GAME_PROJECT/` until all five production bibles achieve formal sign-off.
- **Axiom 3: Multi-Dimensional Surgical Edits.** `edit_file` is strictly mandatory for existing tracked files $\ge 50$ lines. `write_file(Overwrite=true)` is restricted to new files, micro-files $< 50$ lines, or total redesigns ($\ge 90\%$ AST deprecation).
- **Axiom 4: Decoupled Confidence Scoring.** Review findings are evaluated via decoupled technical certainty and evidence verifiability with tiered severity gates (Critical $\ge 0.70$, Major $\ge 0.75$, Minor $\ge 0.80$), eliminating false positives while admitting critical bugs.
- **Axiom 5: Synchronized Full Jitter Backoff.** Network retries and API rate-limit errors implement the canonical Full Jitter exponential backoff $T_{\text{wait}}(k) = \text{Uniform}(0.5, \min(30.0, 1.5 \times 2^k))$, preventing thundering-herd API locks.

---

## 2. HIERARCHICAL MULTI-AGENT ORCHESTRATION & CONTEXT WINDOW HYGIENE

### 2.1 Directorial Command Hierarchy
Project NULL deploys a three-tiered hierarchical orchestration model:

```text
                     CREATIVE DIRECTOR / TECHNICAL DIRECTOR
                                       │
                               PRODUCTION DIRECTOR
                             (Lead Production Agent)
                                       │
            ┌──────────────────────────┼──────────────────────────┐
            ▼                          ▼                          ▼
     VISUAL DIRECTOR          ENGINEERING DIRECTOR        AI STUDIO DIRECTOR
   (Dept A: Book 02)          (Dept B: Book 03)           (Dept C: Book 04)
            │                          │                          │
   ┌────────┴────────┐        ┌────────┴────────┐        ┌────────┴────────┐
   │ Specialists A1–6│        │ Specialists B1–7│        │ Specialists C1–6│
   │ Reviewer A7     │        │ Reviewer B8     │        │ Reviewer C7     │
   └─────────────────┘        └─────────────────┘        └─────────────────┘
```

### 2.2 Context Window Hygiene & Distillation Protocols
To prevent context window saturation and hallucinations:
1. **Bounded File Reads:** Mandatory use of `StartLine` and `EndLine` on files exceeding 100 lines.
2. **Context Distillation:** Long compiler traces or 500-line test outputs are summarized by Tier 1 Flash subagents into actionable 20-line summaries before forwarding to Tier 2 reasoning agents.
3. **Artifact-First Knowledge:** Persistent research, detailed analysis, and diffs are maintained in markdown artifacts rather than polluting conversational memory.

---

## 3. MODEL ROUTING TIERS, QUOTA ECONOMICS & LOCAL LLM BASELINE

### 3.1 Four-Tier Model Routing Architecture

```text
┌───────┬──────────────────────────┬─────────────────────────────┬────────────────────────────────────────┐
│ Tier  │ Engine / Model           │ Primary Role & Use Cases    │ Economics / Quota Profile              │
├───────┼──────────────────────────┼─────────────────────────────┼────────────────────────────────────────┤
│ 1     │ Gemini 2.5 Flash /       │ High-speed drafting, search,│ Ultra-low token cost; high RPM quota;  │
│       │ Claude 3.5 Haiku         │ syntax check, distillation  │ non-reasoning fast path                │
├───────┼──────────────────────────┼─────────────────────────────┼────────────────────────────────────────┤
│ 2     │ Gemini 2.5 Pro /         │ Deep architectural reasoning│ High reasoning capacity; bounded quota;│
│       │ Claude 3.5 Sonnet        │ bible drafting, code review │ primary departmental engine            │
├───────┼──────────────────────────┼─────────────────────────────┼────────────────────────────────────────┤
│ 3     │ Heavy Context / Multi-   │ Cross-department audits,    │ Heavy context window (1M+ tokens);     │
│       │ Perspective Reasoning    │ bible-wide consistency check│ reserved for master volume integration │
├───────┼──────────────────────────┼─────────────────────────────┼────────────────────────────────────────┤
│ 4     │ Local LLM Baseline:      │ Offline fallback, local AST │ 100% offline; zero API cost; 5.5 GB    │
│       │ Qwen 2.5 Coder 7B Q4_K_M │ analysis, pre-commit checks │ host RAM; 7.0–10.5 tok/s on i5-12400F  │
└───────┴──────────────────────────┴─────────────────────────────┴────────────────────────────────────────┘
```

### 3.2 The Calibrated Local LLM Baseline (**DEF-C7-001 Resolved**)
Initial proposals specifying 32B parameter models locally were struck down: running a 32B model requires $\approx 20\text{ GB}$ of RAM, crashing the 16 GB host platform.
- **Calibrated Standard:** **Qwen 2.5 Coder 7B (Q4_K_M)**
- **Host Footprint:** $4.5\text{ GB}$ weights $+ 1.0\text{ GB}$ context $= 5.5\text{ GB}$ total RAM, fitting comfortably within the 16 GB host DDR4 pool.
- **Throughput:** $7.0\text{ to }10.5\text{ tok/s}$ sustained CPU throughput on the Intel Core i5-12400F.
- **Prompt Cache Sensitivity:** Cache hit rate must remain $\ge 52.0\%$ to preserve operational budget targets.

---

## 4. ANTIGRAVITY TOOLS, MCP CONTRACTS & EXECUTION SANDBOXING

### 4.1 Native Antigravity Tools Specification
Agents operate through standardized native tool contracts:
- `invoke_subagent`: Explicit specification of `TypeName`, `Role`, `Prompt`, `Model`, and `Workspace` (`inherit`, `branch`, `share`).
- `run_command`: Strict execution under Windows PowerShell with timeouts (`WaitMsBeforeAsync: 5000-10000` for synchronous; `500` for background tasks).
- `write_file` vs `edit_file`: Multi-Dimensional Surgical Edit Policy strictly enforced.
- `search_marketplace` & `list_plugin_accounts`: Governs plugin discovery and credential validation.

### 4.2 MCP Server Ecosystem
- **`chrome-devtools` & `playwright`:** Headless browser automation for reviewing HTML dashboards, verifying WebGL prototypes, and testing documentation.
- **`godot-engine-mcp` (Proposed):** Evaluated specification for an MCP server communicating with a running Godot debug instance over TCP/JSON-RPC to query node trees, draw calls, and VRAM in real time.

---

## 5. STRICT BLENDER-FREE GENERATIVE 3D ASSET PIPELINE

### 5.1 The Complete Automation Suite (**DEC-0002**)
To eliminate Blender operational overhead, Department C provides three verified, production-grade Python automation scripts in `07_ASSETS/scripts/`:

1. **GLB Header & Primitive Inspector (`inspect_glb.py`):**
   - Parses binary GLB chunks (`0x46546C67`).
   - Verifies primitive topology (`mode == 4` / `TRIANGLES`).
   - Counts index buffers and enforces triangle limits:
     $$\text{Triangles} = \frac{\text{Index Count}}{3} \le 1,500$$
   - Fails pre-commit gate if multiple material slots or excessive triangles are detected.

2. **PBR Texture ORM Channel Packer (`pack_orm.py`):**
   - Ingests separate Ambient Occlusion, Roughness, and Metallic grayscale images.
   - Resamples using high-fidelity Lanczos filtering to $512\times 512$ or $1024\times 1024$.
   - Merges channels into composite RGB: Red = AO, Green = Roughness, Blue = Metallic.
   - Saves optimized PNG with 85% compression quality, saving 2 sampler units and 66% texture bandwidth.

3. **Collision Shape Generator (`generate_collision.py`):**
   - Reads GLB vertex accessor bounding boxes (AABB).
   - Fits optimal primitive collision shapes (`BoxShape3D` vs `CylinderShape3D`).
   - Emits Godot `.tscn` node snippets with exact extents.

---

## 6. AUTONOMOUS GDSCRIPT ENGINEERING, HEADLESS TDD & REVIEW SWARM

### 6.1 Headless Test-Driven Development (TDD) Cycle
All GDScript engineering follows the strict Red-Green-Refactor cycle:
1. **Red Step:** Agent writes unit test in `tests/test_<feature>.gd` asserting contract. Runs headless test runner and verifies deterministic failure.
2. **Green Step:** Agent writes the minimum viable GDScript implementation. Verifies test passes (exit code 0).
3. **Refactor Step:** Agent optimizes code using static typing and zero-allocation rules without breaking test pass status.
- **Mandatory Regression Rule:** Every bug fix must commit an automated test that fails on the unpatched code and passes on the patch.

### 6.2 Pre-Commit Code Review Gate (`precommit_audit.py`)
Prior to committing any GDScript or Python changes, `precommit_audit.py` executes three compliance gates:
1. Headless GDScript static compilation check.
2. Headless unit test suite watchdog (30s execution ceiling).
3. Review defect confidence scoring check.

### 6.3 Decoupled Confidence Scoring Formulation & Tiered Gating (**DEF-C7-003 Resolved**)
To eliminate trivial false-positive blockers while guaranteeing zero critical bugs escape detection, review swarm findings are evaluated by decoupling **Defect Severity** from **Reviewer Confidence**:

$$\text{Confidence Score} = \left(\text{Technical Certainty} \times 0.60\right) + \left(\text{Evidence Verifiability} \times 0.40\right)$$

- **Tiered Admission Gate:**
  - **Critical Defect ($S \ge 0.90$):** Admitted if Confidence $\ge 0.70$. Blocks merge.
  - **Major Defect ($0.60 \le S < 0.90$):** Admitted if Confidence $\ge 0.75$. Blocks merge.
  - **Minor Defect ($0.30 \le S < 0.60$):** Admitted if Confidence $\ge 0.80$. Remediated before phase lock.
  - **Trivial / Noise ($S < 0.30$ or Confidence $< 0.80$):** Automatically discarded.

---

## 7. GOVERNANCE BOUNDARIES, WRAP LOOP SELF-HEALING & DISASTER RECOVERY

### 7.1 Autonomous Agency Boundaries vs Human Gates
```text
┌────────────────────────────────────────────────────────┬────────────────────────────────────────────────────────┐
│ AUTONOMOUS EXECUTION PERMITTED                         │ MANDATORY HUMAN APPROVAL REQUIRED                      │
├────────────────────────────────────────────────────────┼────────────────────────────────────────────────────────┤
│ • Subagent creation, parameterization & dispatch       │ • Modifying or overriding `DECISION_LOG.md`            │
│ • Writing/editing specifications in assigned dirs      │ • Moving between major Production Phases               │
│ • Executing headless tests, benchmarks & Python tools  │ • Irreversible destructive file deletions (`rm -rf`)   │
│ • Git commits to working feature branches              │ • Git push / force-push / remote repository publishing │
│ • Executing Pillow texture packing & GLB validation    │ • External API calls incurring commercial billing      │
│ • Applying technical rulings within verified envelopes │ • Altering Book 01 Story Bible narrative canon         │
│ • Remediating reviewer defects in existing specs       │ • Breaching Non-Implementation Gate on `06_`           │
└────────────────────────────────────────────────────────┴────────────────────────────────────────────────────────┘
```

### 7.2 The Wrap Loop Autonomous Self-Healing Engine
Complex multi-step tasks are executed within the **Wrap Loop** (`wrap-loop`):
- **Atomic Checkpoint:** State persisted in `.wrap/checkpoint.json` separating `modified_files` from `created_files`.
- **Hard Iteration Cap:** Maximum 15 iterations; trips circuit breaker if verification fails.
- **Oscillation Detector:** Semantic AST hashing (`hash_ast.py`) detects cyclic repair ping-pongs across 3 iterations and aborts execution.
- **No Phantom Progress:** Churn without test advancement is classified as an error.
- **Full Jitter Exponential Backoff:** Network/API retries wait $T_{\text{wait}}(k) = \text{Uniform}(0.5, \min(30.0, 1.5 \times 2^k))$ where $k \in \{0, 1, 2, 3, 4\}$.

### 7.3 Disaster Recovery & Rollback Playbook
- **Automated Rollback:** `rollback_task.ps1` deletes uncommitted `created_files` and restores `modified_files` via `git checkout -- <file>`.
- **Binary Asset Quarantine:** Assets with $> 1,500$ triangles, multiple materials, or corrupt GLB chunks are quarantined to `07_ASSETS/quarantine/`.

---

## 8. PERMANENT PRODUCTION LEDGER & AUDIT TRAIL

### 8.1 The Audit Trail Protocol (`04_AI_STUDIO/LEDGER.md`)
All autonomous operations, tool executions, defect remediations, and state handoffs are recorded in an append-only transaction ledger (`04_AI_STUDIO/LEDGER.md`) containing:
- Unique transaction ID (`LEDGER-TX-YYYYMMDD-XXXX`).
- Timestamp and executing agent session ID.
- Action type, files modified, and semantic AST hash.
- Verification command output and exit code.
- Referenced decision records.

---

## 9. CROSS-DEPARTMENT RATIFICATION & MASTER AI STUDIO SIGN-OFF

### 9.1 Inter-Departmental Dependency Ratification
The AI Studio specifications in Book 04 strictly honor all interlocking contracts:
- **Contract D-01:** Non-Implementation Invariant on `06_GAME_PROJECT/` strictly enforced.
- **Contract D-02:** Strict Blender-Free generative pipeline validated via automated Python scripts.
- **Contract D-04:** Headless Godot test runner CLI and exit code protocol validated.
- **Contract D-05:** Multi-Dimensional Surgical Edit Policy ratified across all departments.
- **Contract D-06:** Full Jitter exponential backoff operational on all subagent calls ($0.5\text{s}$ floor, $1.5\text{s} \times 2^k$, $30\text{s}$ cap).
- **Contract D-07:** 5-Perspective Review Swarm with Decoupled Confidence Scoring (Tiered cutoffs: Critical $\ge 0.70$, Major $\ge 0.75$, Minor $\ge 0.80$) ratified.

### 9.2 Master Sign-Off Block
The AI Studio Director and Specialist C7 (AI Studio Reviewer) hereby certify that Book 04: Autonomous AI Studio Bible represents the definitive, verified infrastructure law of Project NULL.

- **AI Studio Director:** *Certified & Approved* — 2026-11-05
- **Specialist C7 (AI Studio Reviewer):** *Formally Signed Off (`PNL-AUDIT-C7-FINAL-001`)* — 2026-11-05
- **Lead Production Director:** *Ingested & Consolidated for Master Archive* — 2026-11-05

---
*End of Book 04: The Autonomous AI Studio Bible.*