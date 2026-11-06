# PROJECT NULL — BOOK 05: MASTER EXECUTION MANUAL
## CHAPTER 00: EXECUTION & INTEGRATION DEPARTMENT CHARTER

**Document ID:** PNL-B05-CH00  
**Document Version:** 1.0.0  
**Authority:** Production Director (Lead Production Agent — `5b37636f-8740-4597-a5e4-10a6478a347c`)  
**Department:** Department E (Production Execution & Systems Integration)  
**Status:** Authored & Ratified  
**Target Engine:** Godot Engine 4.7.2 Stable (`gl_compatibility` / OpenGL 3.3 Core Profile)  
**Host Architecture:** Windows 11 Home 64-bit | Intel Core i5-12400F | 16 GB DDR4 RAM | NVIDIA GeForce G210 (1024 MB DDR3 VRAM, 64-bit bus)  

---

## 1. PURPOSE & MANDATE

Department E (Execution & Integration) serves as the operational enforcement arm of Project NULL. While Books 01 through 04 established the narrative canon, visual aesthetics, engineering architecture, and autonomous studio infrastructure, Book 05 translates these specifications into an ironclad, phase-gated execution roadmap.

Department E owns:
1. **The Production Gates:** Enforcing strict sequencing so that no gameplay implementation occurs out of order or prior to prerequisite verification.
2. **Operational Runbooks:** Providing step-by-step, reproducible execution procedures for autonomous coding agents, asset generation pipelines, and headless test runners.
3. **Verification Command Sequences:** Standardizing exact command-line calls, exit codes, and pass/fail thresholds for every stage of vertical slice production.
4. **Hardware Compliance Enforcement:** Guaranteeing that every compiled scene adheres to the $\le 250$ draw call ceiling and $\le 750\text{ MB}$ provisional scene VRAM budget on the NVIDIA GeForce G210.
5. **Disaster Recovery & Worktree Hygiene:** Managing automated rollback, quarantine isolation, and conventional git commit history.

---

## 2. DEPARTMENTAL ROSTER & RESPONSIBILITIES

```text
┌────────────────────────────────────────────────────────────────────────────────────────┐
│                        DEPARTMENT E: EXECUTION & INTEGRATION ROSTER                    │
├─────────────────────────┬──────────────────────┬───────────────────────────────────────┤
│ Role                    │ Agent / Authority    │ Core Operational Responsibilities     │
├─────────────────────────┼──────────────────────┼───────────────────────────────────────┤
│ Production Director     │ Lead Agent           │ Overall production gating, milestone  │
│ (Integration Lead)      │                      │ sign-offs, and final quality gates.   │
├─────────────────────────┼──────────────────────┼───────────────────────────────────────┤
│ Systems Integration     │ Specialist E1        │ Cross-department dependency handoffs, │
│ Engineer                │                      │ node tree assembly, scene integration.│
├─────────────────────────┼──────────────────────┼───────────────────────────────────────┤
│ Verification & CI/CD    │ Specialist E2        │ Headless test harnesses, performance  │
│ Automation Specialist   │                      │ profiling probes, telemetry counters. │
├─────────────────────────┼──────────────────────┼───────────────────────────────────────┤
│ Asset Integration &     │ Specialist E3        │ Ingestion, GLB inspection, ORM packing│
│ Pipeline Coordinator    │                      │ validation, and ArrayMesh baking.     │
├─────────────────────────┼──────────────────────┼───────────────────────────────────────┤
│ Independent Integration │ Specialist E4        │ Red-team verification of executed     │
│ Reviewer                │                      │ milestones against Books 01–04 bibles.│
└─────────────────────────┴──────────────────────┴───────────────────────────────────────┘
```

---

## 3. CORE OPERATIONAL INVARIANTS

### Invariant 1: The Non-Implementation Invariant
Implementation in `06_GAME_PROJECT/` is strictly unlocked only upon formal completion and approval of all Five Master Production Bibles. No rogue scripts or unverified scenes may exist.

### Invariant 2: Evidence-Gated Progression
Progress between production phases requires deterministic, machine-verifiable evidence. An authoring agent cannot self-certify completion. Every milestone must be validated by an independent reviewer and pass automated CLI test suites.

### Invariant 3: Single-Branch Trunk Integration with Worktree Isolation
Autonomous agents execute tasks in isolated Git worktrees. Merge to `main` requires a 100% clean pre-commit audit (`precommit_audit.py`), semantic AST hashing check (`hash_ast.py`), and decoupled review score $\ge 85\%$.

---
*End of Chapter 00 Charter.*