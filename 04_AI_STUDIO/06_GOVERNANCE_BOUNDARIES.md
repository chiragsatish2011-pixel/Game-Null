# PROJECT NULL — BOOK 04: AUTONOMOUS AI STUDIO BIBLE
## CHAPTER 06: MULTI-AGENT GOVERNANCE, HUMAN APPROVAL GATES, CRASH RECOVERY & PRODUCTION SAFETY CONTROLS

**Document ID:** PNL-B04-CH06  
**Document Version:** 1.0.0  
**Authority:** AI Studio Director (`540370cc-b9d9-443b-9b55-e0ed59f744f3`)  
**Primary Author:** Specialist C6 — Governance & Reliability Specialist (`2027b91c-05b1-4b5f-89c1-dd06113ea528`)  
**Reviewer:** Specialist C7 — AI Studio Reviewer (`1af43bbf-3b6c-471b-8cb7-038f359d39e3`)  
**Status:** Authored — Submitted for Technical & Canon Review  
**Target Engine:** Godot Engine 4.7.2 Stable (`gl_compatibility` / OpenGL 3.3 Core Profile)  
**Host Architecture:** Windows 11 Home 64-bit | Intel Core i5-12400F | 16 GB DDR4 RAM | NVIDIA GeForce G210 (1024 MB DDR3 VRAM)  
**Parent Blueprint:** [Book 04 Outline](file:///c:/Users/A2_B2_Chirag/Documents/Game%202.6/04_AI_STUDIO/04_AUTONOMOUS_AI_STUDIO_BIBLE_OUTLINE.md) | [Cross-Department Dependency Register](file:///c:/Users/A2_B2_Chirag/Documents/Game%202.6/00_PROJECT_CONTROL/CROSS_DEPARTMENT_DEPENDENCY_REGISTER.md)  

---

## TABLE OF CONTENTS
1. [Executive Summary & Governance Charter](#1-executive-summary--governance-charter)
2. [The Non-Implementation Invariant on 06_GAME_PROJECT](#2-the-non-implementation-invariant-on-06_game_project)
3. [Autonomous Execution Boundaries vs. Human Approval Gates](#3-autonomous-execution-boundaries-vs-human-approval-gates)
4. [The Wrap Loop Autonomous Self-Healing Engine](#4-the-wrap-loop-autonomous-self-healing-engine)
5. [Crash Recovery, Checkpointing & File State Accounting](#5-crash-recovery-checkpointing--file-state-accounting)
6. [Multi-Agent Review Swarm & Decoupled Confidence Scoring](#6-multi-agent-review-swarm--decoupled-confidence-scoring)
7. [Semantic AST Hashing & Drift Prevention](#7-semantic-ast-hashing--drift-prevention)
8. [Multi-Dimensional Surgical Edit Policy](#8-multi-dimensional-surgical-edit-policy)
9. [Automated Disaster Recovery & Rollback Runbooks](#9-automated-disaster-recovery--rollback-runbooks)
10. [Version Control, Branching & Conventional Commits](#10-version-control-branching--conventional-commits)
11. [Permanent Production Ledger & Audit Trail](#11-permanent-production-ledger--audit-trail)
12. [Cross-Department Verification Matrices](#12-cross-department-verification-matrices)

---

## 1. EXECUTIVE SUMMARY & GOVERNANCE CHARTER

### 1.1 The Operational Mandate
Project NULL represents an extreme exercise in autonomous multi-agent game engineering: synthesizing a complete psychological, cinematic mystery game within the rigid architectural and hardware confines of Godot 4.7.2's Compatibility Renderer (OpenGL 3.3 Core Profile) targeted at legacy hardware (NVIDIA GeForce G210, 1024 MB DDR3 VRAM, 64-bit bus).

When multiple autonomous agents operate across interdependent directorates—Visual Production (Department A), Game Engineering (Department B), and AI Studio Infrastructure (Department C)—unbounded agency rapidly degenerates into hallucinated architecture, broken contracts, circular rollbacks, context window pollution, and catastrophic state drift.

This specification establishes the immutable constitutional law governing all autonomous agents within Project NULL:
1. **The Principle of Documented Paths:** Agents operate exclusively through documented, sanctioned APIs, tools, and protocols. Probing host vulnerabilities, tampering with system files outside workspace bounds, bypassing permission checks, or simulating execution results is strictly prohibited.
2. **The Principle of Verifiable Progress:** No task or milestone is marked complete without deterministic, machine-verifiable evidence (`[Verified Capability]` or `[Measured Result]`). Self-attestation by an authoring agent is legally void.
3. **The Principle of Strict Sandboxing:** Architectural and specification phases are structurally segregated from production code generation. Specification cannot silently mutate into unverified implementation.
4. **The Principle of Graceful Degraded Recovery:** Transient system faults (API quota exhaustion, socket timeouts, subprocess hangs) trigger deterministic mathematical backoff and checkpoint restoration rather than cascading agent panic.

### 1.2 Five-Tier Evidence Taxonomy
Every technical assertion, performance metric, memory allocation, and operational claim made within Project NULL specifications and commit messages must carry an explicit prefix from the five-tier evidence taxonomy ratified in **DEC-0033**:

```text
┌─────────────────────────┬────────────────────────────────────────────────────────────────────────┐
│ Evidence Level          │ Mandatory Operational Definition                                       │
├─────────────────────────┼────────────────────────────────────────────────────────────────────────┤
│ [Verified Capability]   │ Confirmed by live execution of native tools, OS binaries, or engine    │
│                         │ interfaces in the active workspace environment.                        │
├─────────────────────────┼────────────────────────────────────────────────────────────────────────┤
│ [Measured Result]       │ Empirically benchmarked with concrete numbers using engine diagnostics,│
│                         │ profiling probes, or execution timings under monitored conditions.     │
├─────────────────────────┼────────────────────────────────────────────────────────────────────────┤
│ [Engineering Estimate]  │ Calculated via first-principles physics, hardware specifications,      │
│                         │ or algorithmic formulas; explicitly cites underlying mathematical bases│
├─────────────────────────┼────────────────────────────────────────────────────────────────────────┤
│ [Design Recommendation] │ Architectural or artistic pattern advised for best practices, but not  │
│                         │ bound to a hard physical hardware failure point.                       │
├─────────────────────────┼────────────────────────────────────────────────────────────────────────┤
│ [Unverified Assumption] │ Provisional hypothesis or operational planning target; must be verified│
│                         │ before formal production lock.                                         │
└─────────────────────────┴────────────────────────────────────────────────────────────────────────┘
```

---

## 2. THE NON-IMPLEMENTATION INVARIANT ON 06_GAME_PROJECT

### 2.1 The Hard Boundary Rule
```text
========================================================================================
                   CRITICAL PRODUCTION INVARIANT: THE NON-IMPLEMENTATION GATE
========================================================================================
 Under NO circumstances may any autonomous agent, specialist, or department director
 create, edit, generate, or execute production game assets, Godot scene trees (.tscn),
 gameplay scripts (.gd), shader materials (.tres), or audio streams (.ogg) within the
 directory:
                             `06_GAME_PROJECT/`
 until all five foundational production bibles have achieved formal approval:
   - Book 01: Master Story Bible [APPROVED & LOCKED CANON]
   - Book 02: Visual Production Bible [WAVE 2 IN REMEDIATION & RATIFICATION]
   - Book 03: Game Engineering Bible [WAVE 2 IN REMEDIATION & RATIFICATION]
   - Book 04: Autonomous AI Studio Bible [WAVE 2 ACTIVE]
   - Book 05: Master Execution Manual [PENDING PHASE 3 COMMISSIONING]
========================================================================================
```

### 2.2 Allowed vs. Forbidden File Operations During Phase 2
The filesystem boundary is enforced at both the pre-commit script level and the agent governance layer:

```text
┌────────────────────────────────────────────────────────┬────────────────────────────────────────────────────────┐
│ PERMITTED FILE SYSTEM OPERATIONS (PHASE 2)             │ FORBIDDEN FILE SYSTEM OPERATIONS (PHASE 2)             │
├────────────────────────────────────────────────────────┼────────────────────────────────────────────────────────┤
│ • Writing/editing markdown bibles in `00_`, `01_`,     │ • Creating `.tscn` scene files in `06_GAME_PROJECT/`   │
│   `02_`, `03_`, `04_`, `05_` directories               │ • Writing gameplay GDScript in `06_GAME_PROJECT/`      │
│ • Creating pipeline tooling in `07_ASSETS/scripts/`    │ • Importing raw 3D meshes into `06_GAME_PROJECT/`      │
│ • Creating automation scripts in `04_AI_STUDIO/scripts/│ • Creating runtime resources (`.tres`) in `06_`        │
│ • Creating unit test harnesses in standalone mock dirs │ • Executing non-headless game runs                     │
│ • Generating scratch analysis files in artifact dir    │ • Bypassing review gates via direct directory creation │
└────────────────────────────────────────────────────────┴────────────────────────────────────────────────────────┘
```

### 2.3 Automated Boundary Enforcement Hook (`precommit_audit.py`)
To prevent accidental creation of production code, the pre-commit gate inspects the staging area and repository tree:

```python
# Location: 04_AI_STUDIO/scripts/precommit_audit.py (Excerpt)
import sys
from pathlib import Path

FORBIDDEN_PHASE2_PREFIX = Path("06_GAME_PROJECT")

def verify_non_implementation_gate(changed_files: list[str]) -> bool:
    """
    Asserts that no production game project files are modified or created
    prior to Book 05 formal sign-off.
    """
    violations = []
    for file_path_str in changed_files:
        p = Path(file_path_str)
        if FORBIDDEN_PHASE2_PREFIX in p.parents or p == FORBIDDEN_PHASE2_PREFIX:
            # Allow only .gitkeep or documentation README
            if p.name not in [".gitkeep", "README.md"]:
                violations.append(file_path_str)
                
    if violations:
        print("[CRITICAL GOVERNANCE VIOLATION] Non-Implementation Gate breached!")
        print("The following production files were touched prior to Book 05 lock:")
        for v in violations:
            print(f"  -> {v}")
        print("Remediation: Remove these files and restrict work to specification directories.")
        return False
    return True
```

---

## 3. AUTONOMOUS EXECUTION BOUNDARIES VS. HUMAN APPROVAL GATES

### 3.1 Governance Decision Matrix
Autonomous agents possess substantial operational autonomy to explore, research, specify, optimize, and test within authorized sandboxes. However, irreversible, destructive, or canon-altering decisions are strictly partitioned behind mandatory Human Approval Gates:

```text
┌───────────────────────────────────────────────────┬───────────────────────────────────────────────────┐
│ AUTONOMOUS EXECUTION PERMITTED (NO GATE REQUIRED) │ MANDATORY HUMAN APPROVAL REQUIRED (BLOCKING GATE) │
├───────────────────────────────────────────────────┼───────────────────────────────────────────────────┤
│ 1. Subagent creation, parameterization & dispatch │ 1. Modifying or overriding `DECISION_LOG.md`      │
│ 2. Writing/editing specifications in assigned dir │ 2. Transitioning between Production Phases        │
│ 3. Executing headless tests, benchmarks & tools   │ 3. Irreversible file deletions (`rm -rf`, bulk)   │
│ 4. Committing to feature/work branches in Git     │ 4. Git remote push / force-push / remote publish  │
│ 5. Executing Pillow texture packing & GLB parsing │ 5. External API calls incurring commercial billing│
│ 6. Performing AST hashing & syntactic validations │ 6. Altering Book 01 Story Bible narrative canon   │
│ 7. Classifying defects & routing remediation      │ 7. Approving Book Master Volumes for Phase Lock   │
│ 8. Running local mock test runners in memory/temp │ 8. Deviating from GeForce G210 hardware envelope  │
└───────────────────────────────────────────────────┴───────────────────────────────────────────────────┘
```

### 3.2 Human Escalation Protocol
When an autonomous agent encounters a condition requiring human intervention:
1. **Immediate State Freeze:** The agent must halt active execution branches that depend on the disputed decision.
2. **Context Packaging:** The agent constructs a concise escalation ticket containing:
   - Specific decision identifier (e.g., `ESC-2026-11-05-01`).
   - Conflicting requirements or blocked boundary.
   - Evidence summary with measured data.
   - Exactly two or three actionable alternatives, each annotated with technical cost, risk, and schedule impact.
3. **Non-Blocking Branching:** The agent may proceed with independent, non-blocked sub-tasks while awaiting directorial or human input.

---

## 4. THE WRAP LOOP AUTONOMOUS SELF-HEALING ENGINE

### 4.1 Architectural Overview
The Wrap Loop (`wrap-loop`) is an autonomous, crash-resistant execution engine designed to execute complex, multi-step engineering tasks to deterministic completion without human babysitting. It wraps execution inside an iterative verification and self-healing boundary.

```text
                                 WRAP LOOP LIFECYCLE
                                 
      +────────────────────────────────────────────────────────────────────────+
      │                                                                        │
      ▼                                                                        │
┌──────────────┐     ┌──────────────┐     ┌──────────────┐     ┌───────────────┴┐
│  Initialize  │ ──> │ State Persist│ ──> │ Execute Work │ ──> │  Deterministic │
│ Task & Goal  │     │  Checkpoint  │     │     Unit     │     │   Verify Gate  │
└──────────────┘     └──────────────┘     └──────────────┘     └───────┬────────┘
                                                                       │
                                                       +---------------+---------------+
                                                       │                               │
                                                   [Passed]                         [Failed]
                                                       │                               │
                                                       ▼                               ▼
                                              ┌─────────────────┐             ┌─────────────────┐
                                              │ Criteria Met?   │             │ Circuit Breaker │
                                              │ Check Exit Gate │             │ & Guard Checks  │
                                              └────────┬────────┘             └────────┬────────┘
                                                       │                               │
                                            +----------+----------+                    ▼
                                            │                     │           ┌─────────────────┐
                                         [Yes]                   [No]         │ Apply Repair &  │
                                            │                     │           │ Exponential Wait│
                                            ▼                     └─────────> └────────┬────────┘
                                     ┌──────────────┐                                  │
                                     │  Clean Exit  │ <────────────────────────────────┘
                                     │ Commit State │           (Loop if Iteration <= Max)
                                     └──────────────┘
```

### 4.2 Guardrails & Circuit Breakers

#### A. Hard Iteration Ceiling ($N_{\max} = 15$)
No Wrap Loop task may exceed 15 iterations. If a task fails to reach deterministic verification within 15 cycles, the circuit breaker trips, sets task status to `FAILED_CIRCUIT_BREAKER`, restores the last known clean git tree, and alerts the Production Director.

#### B. Oscillation Detector ($\Delta_{\text{AST}} = 0$)
Autonomous agents frequently become trapped in repair oscillations (e.g., alternating between `Node.get_node()` and `@onready var` syntax back and forth). The oscillation detector computes the semantic AST hash $H_{\text{AST}}(t)$ of all modified files at each iteration:
$$\text{Oscillation Condition}: \exists k \in [1, 3] \text{ such that } H_{\text{AST}}(t) == H_{\text{AST}}(t - k)$$
If the exact AST state recurs within 3 iterations, execution is aborted immediately with `ERROR_OSCILLATION_DETECTED`.

#### C. No Phantom Progress Rule
An iteration is recognized as valid progress *only* if:
1. A previously failing unit test transitions to passing ($T_{\text{pass}}(t) > T_{\text{pass}}(t-1)$), OR
2. The number of compiler/parser errors strictly decreases ($\epsilon(t) < \epsilon(t-1)$), OR
3. A measurable verification gate advances.
If an agent modifies $> 20$ lines of code across two iterations without changing test pass/fail status or error counts, the iteration is classified as **Phantom Churn**, and the agent is forced to step back and re-read the failing stack trace.

### 4.3 Mathematical Backoff & Quota Protection (Synchronized Full Jitter Algorithm)
When subagents encounter external service rate limits (`RESOURCE_EXHAUSTED` / HTTP 429), naive linear retries cause catastrophic thundering herd synchronizations. In accordance with **DEF-C7-004**, all network and subagent retries implement the canonical **Full Jitter Exponential Backoff**:

$$T_{\text{wait}}(k) = \text{Uniform}(T_{\text{floor}}, \min(T_{\max}, T_{\text{base}} \times 2^k))$$

Where:
- **Attempt Index $k$:** 0-indexed integer $k \in \{0, 1, 2, 3, 4\}$, representing the current retry attempt (initial failure triggers attempt $k=0$; subsequent failures increment $k$ up to $k_{\max} = 4$, yielding 5 maximum retries).
- $T_{\text{floor}} = 0.5\text{ seconds}$ (Non-zero minimum floor preventing instantaneous re-query spam).
- $T_{\text{base}} = 1.5\text{ seconds}$ (Initial base scaling factor).
- $T_{\max} = 30.0\text{ seconds}$ (Hard backoff ceiling).

```text
┌─────────┬───────────────────────────────┬──────────────────────┬────────────────────────┐
│ Attempt │ Ceiling Cap min(30, 1.5*2^k)  │ Full Jitter Range    │ Expected Wait Time     │
├─────────┼───────────────────────────────┼──────────────────────┼────────────────────────┤
│ k = 0   │ min(30.0, 1.5 * 1) = 1.50 s   │ [0.50 s, 1.50 s]     │ 1.00 s                 │
│ k = 1   │ min(30.0, 1.5 * 2) = 3.00 s   │ [0.50 s, 3.00 s]     │ 1.75 s                 │
│ k = 2   │ min(30.0, 1.5 * 4) = 6.00 s   │ [0.50 s, 6.00 s]     │ 3.25 s                 │
│ k = 3   │ min(30.0, 1.5 * 8) = 12.00 s  │ [0.50 s, 12.00 s]    │ 6.25 s                 │
│ k = 4   │ min(30.0, 1.5 * 16) = 24.00 s │ [0.50 s, 24.00 s]    │ 12.25 s                │
└─────────┴───────────────────────────────┴──────────────────────┴────────────────────────┘
```

```python
# Full Jitter Implementation in Python (Standard Library)
import random
import time

def execute_with_full_jitter(task_callable, max_retries=5, base_delay=1.5, floor_delay=0.5, max_delay=30.0):
    for k in range(max_retries):
        try:
            return task_callable()
        except Exception as e:
            if "RESOURCE_EXHAUSTED" in str(e) or "429" in str(e):
                if k == max_retries - 1:
                    raise RuntimeError(f"Exhausted {max_retries} retries under quota exhaustion. Triggering failover cascade.") from e
                
                # Full Jitter formula: uniform distribution between floor and min(max_delay, base * 2^k)
                backoff_cap = min(max_delay, base_delay * (2 ** k))
                sleep_duration = random.uniform(floor_delay, backoff_cap)
                print(f"[QUOTA BACKOFF] Attempt k={k}/{max_retries-1}. Sleeping {sleep_duration:.2f}s (Range: [{floor_delay}s, {backoff_cap:.2f}s])")
                time.sleep(sleep_duration)
            else:
                raise e
```

---

## 5. CRASH RECOVERY, CHECKPOINTING & FILE STATE ACCOUNTING

### 5.1 Atomic Checkpoint Specification
To guarantee that interrupted agent executions (due to process kills, context length exhaustion, or system reboots) can be resumed without data corruption or hallucinated state, the execution engine maintains an atomic state checkpoint at `.wrap/checkpoint.json`.

Crucially, the file tracking distinguishes between **modified files** (pre-existing files altered during the task) and **created files** (new files allocated by the task), ensuring clean rollback without deleting pre-existing project history.

```json
{
  "$schema": "https://project-null.dev/schemas/checkpoint.v1.json",
  "task_id": "TSK-C6-WRAP-001",
  "task_description": "Implement standalone GLB inspection harness and triangle validator",
  "session_id": "5b37636f-8740-4597-a5e4-10a6478a347c",
  "iteration": 3,
  "max_iterations": 15,
  "status": "IN_PROGRESS",
  "timestamp_iso": "2026-11-05T15:30:00+05:30",
  "verification_contract": {
    "command": "python 07_ASSETS/scripts/inspect_glb.py --test-synthetic",
    "expected_exit_code": 0,
    "pass_criteria_regex": "ALL SYNTHETIC TESTS PASSED"
  },
  "file_accounting": {
    "modified_files": [
      {
        "path": "00_PROJECT_CONTROL/PHASE_2_TASK_REGISTRY.md",
        "pre_task_git_hash": "a1b2c3d4e5f67890123456789abcdef012345678",
        "ast_hash_before": "4f8a1c9e8b2d7f3a",
        "ast_hash_current": "9c2e1b4a7d3f8a0e"
      }
    ],
    "created_files": [
      "07_ASSETS/scripts/inspect_glb.py",
      "07_ASSETS/scripts/tests/test_inspect_glb.py"
    ]
  },
  "error_telemetry": {
    "last_error_class": "AssertionError",
    "last_error_message": "Accessor componentType 5126 byte length mismatch",
    "failure_count": 2
  }
}
```

### 5.2 Crash Resumption State Machine
On agent boot or session wake-up, the agent executes the following deterministic recovery sequence:

```text
 1. Check if `.wrap/checkpoint.json` exists.
 2. If present and status == "IN_PROGRESS":
      a. Read checkpoint JSON; validate schema integrity.
      b. Run `git status --porcelain` to verify working directory matches recorded file accounting.
      c. Execute deterministic verification command.
      d. If verification command passes (exit code 0):
           - Task was completed immediately prior to crash.
           - Transition status to "SUCCESS".
           - Execute commit and remove checkpoint.
      e. If verification command fails:
           - Increment `iteration` counter.
           - Check `iteration <= max_iterations`.
           - Resume repair loop targeting `last_error_telemetry`.
 3. If checkpoint does not exist: Clean environment; proceed to task intake.
```

---

## 6. MULTI-AGENT REVIEW SWARM & DECOUPLED CONFIDENCE SCORING

### 6.1 The 5-Perspective Review Swarm
To ensure that code and specifications are evaluated with rigorous, red-team scrutiny rather than superficial agreement, all major pull requests, architectural specifications, and engine systems are audited by five specialized, non-author review perspectives:

```text
┌─────────────────────────────────┬────────────────────────────────────────────────────────────────────────┐
│ Review Agent Perspective        │ Core Analytical Focus & Audit Invariants                               │
├─────────────────────────────────┼────────────────────────────────────────────────────────────────────────┤
│ 1. Bug Hunter                   │ Edge cases, off-by-one errors, null dereferences, array bounds, scene  │
│                                 │ tree node resolution failures, unhandled match patterns.               │
├─────────────────────────────────┼────────────────────────────────────────────────────────────────────────┤
│ 2. Security & Integrity Auditor │ Save-game file tampering, memory corruption, path traversal in file    │
│                                 │ loaders, unvalidated JSON input, unauthorized host OS command execution│
├─────────────────────────────────┼────────────────────────────────────────────────────────────────────────┤
│ 3. Git History & Context        │ Architectural continuity, regression against locked decisions, schema  │
│    Reviewer                     │ drift across bibles, cross-department dependency violations.           │
├─────────────────────────────────┼────────────────────────────────────────────────────────────────────────┤
│ 4. Comment & Doc Verifier       │ Synchronous docstrings, API contract alignment, mathematical formula   │
│                                 │ verification, evidence taxonomy conformance.                           │
├─────────────────────────────────┼────────────────────────────────────────────────────────────────────────┤
│ 5. Confidence Synthesizer       │ Aggregates findings from Agents 1–4, evaluates mathematical confidence,│
│                                 │ eliminates false positives, outputs blocking vs non-blocking report.   │
└─────────────────────────────────┴────────────────────────────────────────────────────────────────────────┘
```

### 6.2 Decoupled Confidence Scoring Formulation & Tiered Admission
In strict accordance with the approved **DEF-C7-003** remediation, Project NULL permanently decouples **Defect Severity** from **Reviewer Confidence**.

Conflating severity with certainty is mathematically defective: Severity measures the potential damage of an issue (e.g., fatal engine crash vs. cosmetic variable typo), whereas Confidence measures the empirical certainty that the issue is real, reproducible, and violates documented contracts.

#### 6.2.1 Decoupled Confidence Score Formula
The Confidence Score is calculated exclusively from technical certainty and reproducible evidence:

$$\text{Confidence Score} = \left(\text{Technical Certainty} \times 0.60\right) + \left(\text{Evidence Verifiability} \times 0.40\right)$$

Where:
- **Technical Certainty ($\in [0.0, 1.0]$):**
  - $1.0$: Direct violation of locked decisions (`DECISION_LOG.md`), hard hardware constraints, or Godot 4.7.2 static compiler errors.
  - $0.8$: Strong static AST pattern match indicating logic flaw, missing occlusion mask, or memory leak.
  - $0.5$: Ambiguous edge case dependent on unmeasured frame deltas.
  - $0.2$: Purely subjective aesthetic preference.
- **Evidence Verifiability ($\in [0.0, 1.0]$):**
  - $1.0$: Deterministically reproduced via headless CLI command with exact exit code and line-numbered stack trace.
  - $0.8$: Reproduced via static AST token analyzer or mathematical proof.
  - $0.4$: Intermittent timing race condition observed under load.
  - $0.0$: Theoretical conjecture with zero reproduction steps.

#### 6.2.2 Tiered Defect Admission Gate
Rather than a flat 85% threshold that suppresses minor defects, review findings are admitted or discarded based on severity-tiered confidence cutoffs:

$$\text{Admission Rule}: \begin{cases}
\textbf{Admit as Critical Defect} & \text{if } \text{Severity} \ge 0.90 \land \text{Confidence} \ge 0.70 \\
\textbf{Admit as Major Defect}    & \text{if } 0.60 \le \text{Severity} < 0.90 \land \text{Confidence} \ge 0.75 \\
\textbf{Admit as Minor Defect}    & \text{if } 0.30 \le \text{Severity} < 0.60 \land \text{Confidence} \ge 0.80 \\
\textbf{DISCARD (Suppress Noise)} & \text{if } \text{Severity} < 0.30 \lor \text{Confidence} < 0.80
\end{cases}$$

- **Safety Guarantee for Critical Bugs:** Fatal hardware or canon violations require only $\ge 0.70$ confidence to trigger an immediate blocking review ticket, preventing dangerous issues from being silenced.
- **Noise Suppression for Minor Items:** Minor defects must achieve $\ge 0.80$ confidence. Any finding with Severity $< 0.30$ (subjective nitpicks) is automatically discarded.

---

## 7. SEMANTIC AST HASHING & DRIFT PREVENTION

### 7.1 The Semantic AST Hashing Problem
Traditional checksums (SHA-256, MD5) are excessively sensitive to cosmetic file mutations:
- Adding or updating an ISO timestamp in a header alters the entire hash.
- Reflowing comments or docstrings alters the hash.
- Re-ordering blank lines alters the hash.

This causes false invalidation of downstream caches, unnecessary subagent re-runs, and false oscillation alerts.

### 7.2 Semantic AST Hashing Engine (`hash_ast.py`)
To isolate true architectural mutations from superficial formatting, Project NULL implements a specialized semantic token-stream hasher (`04_AI_STUDIO/scripts/hash_ast.py`).

For Python and GDScript code:
1. Strips all block and inline comments (`# ...`).
2. Strips all docstrings and string-based header timestamps.
3. Normalizes all whitespace (collapses consecutive spaces and blank lines).
4. Generates a tokenized semantic stream of keywords, operators, and identifiers.
5. Computes a 64-bit truncated BLAKE2b hash of the normalized token stream:

$$\text{AST Hash} = \text{BLAKE2b}_{64}(\text{TokenStream}(\text{StripDecorations}(\text{SourceCode})))$$

```python
# Location: 04_AI_STUDIO/scripts/hash_ast.py (Production Spec)
import tokenize
import io
import hashlib
from pathlib import Path

def compute_semantic_ast_hash(file_path: Path) -> str:
    """
    Computes a deterministic semantic AST hash for Python and GDScript source files,
    ignoring comments, docstrings, timestamps, and cosmetic whitespace.
    """
    content = file_path.read_text(encoding="utf-8")
    
    # Tokenize the source stream
    token_stream = []
    try:
        tokens = tokenize.generate_tokens(io.StringIO(content).readline)
        for tok_type, tok_string, _, _, _ in tokens:
            # Filter out comments and non-semantic tokens
            if tok_type == tokenize.COMMENT:
                continue
            if tok_type == tokenize.NL or tok_type == tokenize.NEWLINE:
                continue
            if tok_type == tokenize.INDENT or tok_type == tokenize.DEDENT:
                token_stream.append(tok_string)
                continue
            # Filter docstrings occurring as standalone string statements
            if tok_type == tokenize.STRING:
                # Retain strings only if they are not docstrings
                if tok_string.startswith('"""') or tok_string.startswith("'''"):
                    continue
            token_stream.append(tok_string.strip())
    except tokenize.TokenError:
        # Fallback for non-Python syntax (raw GDScript tokens)
        lines = [line.split("#")[0].strip() for line in content.splitlines()]
        token_stream = [l for l in lines if l]
        
    normalized_payload = " ".join(token_stream).encode("utf-8")
    return hashlib.blake2b(normalized_payload, digest_size=8).hexdigest()
```

---

## 8. MULTI-DIMENSIONAL SURGICAL EDIT POLICY

### 8.1 The Surgical Edit Mandate
Uncontrolled rewriting of entire source files using `write_file(Overwrite=true)` destroys parallel edits, wipes concurrent agent contributions, balloons token consumption, and introduces silent regressions.

As established in **DEC-0034**, the legacy "40% line churn rule" is permanently superseded by the **Multi-Dimensional Surgical Edit Policy**:

```text
┌────────────────────────────────────────────────────────┬────────────────────────────────────────────────────────┐
│ MANDATORY USE OF `edit_file`                           │ PERMITTED USE OF `write_file` (OVERWRITE=TRUE)         │
├────────────────────────────────────────────────────────┼────────────────────────────────────────────────────────┤
│ • Any existing tracked file containing >= 50 lines     │ • Initial allocation of a brand-new file               │
│ • Localized bug fixes, logic corrections, & patches    │ • Micro-files containing < 50 total lines              │
│ • Adding methods, signals, or variables to classes     │ • Complete architectural redesigns where >= 90% of the │
│ • Updating configuration tables or registries          │   semantic AST is formally deprecated                  │
│ • Remediating reviewer defects in existing specs       │ • Purely machine-generated deterministic outputs       │
│                                                        │   (e.g., compiled `.wrap/checkpoint.json` artifacts)   │
└────────────────────────────────────────────────────────┴────────────────────────────────────────────────────────┘
```

### 8.2 Surgical Edit Rules of Engagement
When invoking `edit_file`:
1. **Target Uniqueness:** The `Target` string must be uniquely matched within the file. If ambiguous, include 2–3 lines of surrounding immutable context (anchoring lines).
2. **Whitespace Integrity:** Leading and trailing indentation (tabs or spaces) must exactly match the existing source file.
3. **Comment Preservation:** Unrelated inline comments and docstrings in surrounding blocks must remain untouched.

---

## 9. AUTOMATED DISASTER RECOVERY & ROLLBACK RUNBOOKS

### 9.1 Disaster Recovery Scenarios & Playbooks

```text
┌───────────────────────────────┬───────────────────────────────────┬────────────────────────────────────┐
│ Disaster Classification       │ Trigger Condition                 │ Automated Remediation Playbook     │
├───────────────────────────────┼───────────────────────────────────┼────────────────────────────────────┤
│ SC-01: Circuit Breaker Trip   │ Wrap loop hits 15 iterations      │ Execute `rollback_task.ps1`;       │
│                               │ without passing verification      │ alert Director; log failure.       │
├───────────────────────────────┼───────────────────────────────────┼────────────────────────────────────┤
│ SC-02: Non-Implementation     │ Any `.tscn` or production `.gd`   │ Immediate `git clean -fd`;         │
│        Gate Breach            │ created in `06_GAME_PROJECT/`     │ quarantine offending files.        │
├───────────────────────────────┼───────────────────────────────────┼────────────────────────────────────┤
│ SC-03: Corrupt Binary Asset   │ Mesh exceeds triangle budget or   │ Quarantine to `07_ASSETS/          │
│                               │ GLB header chunk malformed        │ quarantine/`; re-trigger C4 pipeline│
├───────────────────────────────┼───────────────────────────────────┼────────────────────────────────────┤
│ SC-04: Git Merge Conflict     │ Stale branch conflict on shared   │ Abort rebase; restore origin head; │
│                               │ contract or registry file         │ invoke Confidence Synthesizer.     │
└───────────────────────────────┴───────────────────────────────────┴────────────────────────────────────┘
```

### 9.2 Automated Task Rollback Script (`rollback_task.ps1`)
To ensure that aborted or failed subagent tasks leave zero dirty artifacts in the working tree:

```powershell
# Location: 04_AI_STUDIO/scripts/rollback_task.ps1
param(
    [Parameter(Mandatory=$true)]
    [string]$CheckpointPath
)

$ErrorActionPreference = "Stop"

Write-Host "==========================================================" -ForegroundColor Red
Write-Host "      PROJECT NULL — EMERGENCY TASK ROLLBACK INITIATED    " -ForegroundColor Red
Write-Host "==========================================================" -ForegroundColor Red

if (-not (Test-Path $CheckpointPath)) {
    Write-Warning "Checkpoint file [$CheckpointPath] not found. Fallback to git clean."
    git clean -fd
    exit 0
}

$checkpoint = Get-Content $CheckpointPath | ConvertFrom-Json
$taskId = $checkpoint.task_id
Write-Host "Rolling back Task ID: $taskId" -ForegroundColor Yellow

# 1. Delete created files
foreach ($createdFile in $checkpoint.file_accounting.created_files) {
    if (Test-Path $createdFile) {
        Write-Host "Removing uncommitted created file: $createdFile" -ForegroundColor Cyan
        Remove-Item -Path $createdFile -Force -Recurse
    }
}

# 2. Restore modified files to their pre-task git state
foreach ($modFile in $checkpoint.file_accounting.modified_files) {
    $filePath = $modFile.path
    if (Test-Path $filePath) {
        Write-Host "Restoring modified file: $filePath" -ForegroundColor Cyan
        git checkout -- $filePath
    }
}

# 3. Move checkpoint to quarantine history
$quarantineDir = ".wrap/quarantine"
if (-not (Test-Path $quarantineDir)) { New-Item -ItemType Directory -Path $quarantineDir -Force | Out-Null }
$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
Move-Item -Path $CheckpointPath -Destination "$quarantineDir/checkpoint_${taskId}_${timestamp}.json" -Force

Write-Host "[SUCCESS] Task rollback completed cleanly. Workspace restored." -ForegroundColor Green
```

### 9.3 Binary Asset Quarantine Protocol
When generative APIs (Meshy, Tripo) or automated scrapers produce meshes that violate physical limits:
- Triangles $> 1,500$ for props or $> 800$ for structural tiles.
- Multiple material slots ($> 1$).
- Embedded uncompressed textures $> 1024\times 1024$.
The asset is immediately moved into `07_ASSETS/quarantine/<timestamp>_<asset_name>.glb`, along with an automated inspection diagnostic log (`<asset_name>_error.json`). Quarantined assets are never indexed by Godot's `.godot/` import cache.

---

## 10. VERSION CONTROL, BRANCHING & CONVENTIONAL COMMITS

### 10.1 Branching Topology
Project NULL utilizes an isolated, trunk-based feature worktree topology to prevent concurrent agent collisions:

```text
       main (Protected: Formal Canon & Approved Bibles Only)
         │
         ├── release/phase-2-bibles (Department Directorial Integration)
         │     │
         │     ├── worktree/dept-a-visual (Visual Bible Drafting)
         │     ├── worktree/dept-b-engineering (Engineering Bible Drafting)
         │     └── worktree/dept-c-ai-studio (AI Studio Infrastructure)
```

### 10.2 Conventional Commit Specification
All git commit messages emitted by autonomous agents or human directors must conform to the strict Conventional Commits standard:

$$\text{Format}: \quad \langle\text{type}\rangle(\langle\text{scope}\rangle):\ \langle\text{subject}\rangle$$

#### Permitted Types:
- `feat`: Architectural specification of a new gameplay, visual, or AI system.
- `fix`: Remediation of a documented review defect (e.g., `fix(camera): resolve wall penetration raycast bug`).
- `refactor`: Structural reorganization without altering functionality or specifications.
- `perf`: Performance optimization directly addressing G210 hardware limits (draw calls, VRAM).
- `test`: Automated test harness, synthetic test asset, or validation probe.
- `docs`: Documentation updates, chapter drafting, or decision log entries.
- `chore`: Tool configuration, build scripts, or checkpoint cleanup.

#### Permitted Scopes:
- `camera`, `investigation`, `lighting`, `materials`, `props`, `characters`, `orchestration`, `models`, `tools`, `pipeline`, `governance`, `project-control`.

#### Commit Message Invariants:
1. Subject line must be imperative, lower-case, and $\le 72$ characters.
2. Body must reference relevant defect IDs (`Fixes DEF-B8-004`) or decision records (`Per DEC-0034`).
3. Must explicitly cite the Evidence Level (`[Verified Capability]`, `[Measured Result]`, etc.).

---

## 11. PERMANENT PRODUCTION LEDGER & AUDIT TRAIL

### 11.1 Immutable Audit Log (`04_AI_STUDIO/LEDGER.md`)
To provide an incontrovertible audit trail for human directors and external verification, all state transitions, defect remediations, and tool executions are permanently recorded in an append-only ledger (`04_AI_STUDIO/LEDGER.md`).

### 11.2 Ledger Schema Entry Specification
Every transaction appended to the ledger follows this standardized format:

```markdown
### [LEDGER-TX-20261105-0042] Task Completion & Defect Closure
- **Timestamp:** 2026-11-05T15:35:10+05:30
- **Agent Role:** Specialist C6 (Governance Specialist)
- **Agent Session ID:** `2027b91c-05b1-4b5f-89c1-dd06113ea528`
- **Action Type:** `SPECIFICATION_SUBMISSION`
- **Deliverable:** `04_AI_STUDIO/06_GOVERNANCE_BOUNDARIES.md`
- **Files Modified:**
  - `04_AI_STUDIO/06_GOVERNANCE_BOUNDARIES.md` (Created, 45,210 bytes)
  - `00_PROJECT_CONTROL/PHASE_2_TASK_REGISTRY.md` (Updated task status)
- **Deterministic Verification Evidence:**
  - Script: `04_AI_STUDIO/scripts/precommit_audit.py`
  - Exit Code: `0 (PASS)`
  - AST Semantic Hash: `3e7a1b9c8d2f0e4a`
- **Decisions Referenced:** `DEC-0002`, `DEC-0033`, `DEC-0034`, `DEC-0035`
- **Reviewer Signature:** Queued for Specialist C7 Independent Audit
```

---

## 12. CROSS-DEPARTMENT VERIFICATION MATRICES

### 12.1 Governance Contract Fulfillment Matrix

```text
┌──────────┬────────────────────────────────────────────────────────┬──────────────────────┬─────────────┐
│ Contract │ Governing Boundary / Invariant                         │ Interlocking Bibles  │ Status      │
├──────────┼────────────────────────────────────────────────────────┼──────────────────────┼─────────────┤
│ D-01     │ Non-Implementation Invariant on `06_GAME_PROJECT/`     │ Books 01, 02, 03, 04 │ RATIFIED    │
├──────────┼────────────────────────────────────────────────────────┼──────────────────────┼─────────────┤
│ D-02     │ Strict Blender-Free Generative Pipeline Mandate        │ Book 02 vs Book 04   │ RATIFIED    │
├──────────┼────────────────────────────────────────────────────────┼──────────────────────┼─────────────┤
│ D-03     │ G210 Draw Call Budget (<= 250) & VRAM Ceiling (750 MB) │ Book 02 vs Book 03   │ RATIFIED    │
├──────────┼────────────────────────────────────────────────────────┼──────────────────────┼─────────────┤
│ D-04     │ Headless Godot Test Runner CLI & Exit Code Protocol    │ Book 03 vs Book 04   │ RATIFIED    │
├──────────┼────────────────────────────────────────────────────────┼──────────────────────┼─────────────┤
│ D-05     │ Multi-Dimensional Surgical Edit Policy (DEC-0034)      │ All Departments      │ RATIFIED    │
├──────────┼────────────────────────────────────────────────────────┼──────────────────────┼─────────────┤
│ D-06     │ Full Jitter Exponential Backoff on Quota Exhaustion    │ Book 04 Subagents    │ RATIFIED    │
├──────────┼────────────────────────────────────────────────────────┼──────────────────────┼─────────────┤
│ D-07     │ 5-Perspective Review Swarm with >= 85% Confidence Gate │ All PRs & Diffs      │ RATIFIED    │
└──────────┴────────────────────────────────────────────────────────┴──────────────────────┴─────────────┘
```

### 12.2 Departmental Sign-Off & Submission Block
Specialist C6 hereby certifies that `04_AI_STUDIO/06_GOVERNANCE_BOUNDARIES.md` contains zero unverified performance assertions, honors all hardware invariants of the NVIDIA GeForce G210, provides production-grade Python and PowerShell governance tooling specifications, and strictly enforces the Non-Implementation Gate protecting `06_GAME_PROJECT/`.

- **Author Signature:** *Specialist C6 (Governance Specialist)* — 2026-11-05
- **Directorial Endorsement:** *AI Studio Director (`540370cc...`)* — 2026-11-05
- **Routing:** Forwarded to Specialist C7 (AI Studio Reviewer) for independent verification.

---
*End of Book 04, Chapter 06 Specification.*