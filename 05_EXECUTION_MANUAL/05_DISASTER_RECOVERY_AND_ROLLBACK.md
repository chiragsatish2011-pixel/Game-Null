# PROJECT NULL — BOOK 05: MASTER EXECUTION MANUAL
## CHAPTER 05: DISASTER RECOVERY, ISOLATION & ROLLBACK RUNBOOKS

**Document ID:** PNL-B05-CH05  
**Document Version:** 1.0.0  
**Authority:** Production Director (Lead Production Agent)  
**Status:** Authored & Ratified  
**Target Engine:** Godot Engine 4.7.2 Stable (`gl_compatibility` / OpenGL 3.3 Core Profile)  
**Host Hardware:** Windows 11 Home 64-bit | Intel Core i5-12400F | 16 GB DDR4 RAM | NVIDIA GeForce G210 (1024 MB DDR3 VRAM)  

---

## 1. DISASTER RECOVERY PROTOCOLS OVERVIEW

Autonomous production agents operate with high autonomy but are constrained by deterministic fail-safe procedures to prevent state corruption, unrecoverable merge conflicts, context window explosions, or corrupted repository trees:

```text
┌───────────────────────────────┬───────────────────────────────────┬────────────────────────────────────┐
│ Disaster Classification       │ Trigger Condition                 │ Automated Remediation Playbook     │
├───────────────────────────────┼───────────────────────────────────┼────────────────────────────────────┤
│ DR-01: Circuit Breaker Trip   │ Wrap loop hits 15 iterations      │ Execute `rollback_task.ps1`;       │
│                               │ without passing verification      │ alert Director; log failure.       │
├───────────────────────────────┼───────────────────────────────────┼────────────────────────────────────┤
│ DR-02: Rate Limit / Quota Exh.│ External API returns 429 /        │ Full Jitter Exponential Backoff    │
│                               │ RESOURCE_EXHAUSTED                │ (0.5s to 60s); fallback to Tier 4  │
├───────────────────────────────┼───────────────────────────────────┼────────────────────────────────────┤
│ DR-03: Cyclic AST Oscillation │ `hash_ast.py` detects matching    │ Abort repair loop; print diff of   │
│                               │ semantic token stream within 3 it.│ conflicting states; invoke review  │
├───────────────────────────────┼───────────────────────────────────┼────────────────────────────────────┤
│ DR-04: Non-Implementation     │ Any `.tscn` or gameplay `.gd`     │ Immediate `git clean -fd`;         │
│        Gate Breach            │ created in `06_` before Book 05   │ quarantine offending files.        │
├───────────────────────────────┼───────────────────────────────────┼────────────────────────────────────┤
│ DR-05: Binary Asset Corruption│ Mesh > 1,500 tris, M > 1, or      │ Immediate move to `07_ASSETS/      │
│                               │ GLB chunk header malformed        │ quarantine/`; re-prompt API.       │
└───────────────────────────────┴───────────────────────────────────┴────────────────────────────────────┘
```

---

## 2. RUNBOOK DR-01: AUTOMATED TASK ROLLBACK RUNBOOK

When an autonomous subagent fails a verification gate or trips the 15-iteration circuit breaker, the environment must be restored to a pristine git state without manual intervention.

### Execution Command:
```powershell
& "04_AI_STUDIO/scripts/rollback_task.ps1" -CheckpointPath ".wrap/checkpoint.json"
```

### Script Execution Logic:
1. **Reads Checkpoint JSON:** Parses `.wrap/checkpoint.json` to identify active task ID and file accounting lists.
2. **Deletes Created Files:** Iterates over `checkpoint.file_accounting.created_files` and permanently deletes each uncommitted file using `Remove-Item -Force`.
3. **Restores Modified Files:** Iterates over `checkpoint.file_accounting.modified_files` and executes `git checkout -- <file>` to revert modifications back to the last clean git commit.
4. **Quarantines Checkpoint:** Moves `.wrap/checkpoint.json` to `.wrap/quarantine/checkpoint_<task_id>_<timestamp>.json` for post-mortem forensics.
5. **Emits Verification Log:** Prints `[SUCCESS] Task rollback completed cleanly. Workspace restored.` with exit code 0.

---

## 3. RUNBOOK DR-02: RATE LIMIT & API QUOTA EXHAUSTION RECOVERY

When cloud LLM APIs return HTTP 429 or `RESOURCE_EXHAUSTED`:
1. **Intercept Error:** Catch the API exception at the client dispatcher level.
2. **Apply Synchronized Full Jitter Backoff Formula (DEF-C7-004):**
   $$T_{\text{wait}}(k) = \text{Uniform}(0.5, \min(30.0, 1.5 \times 2^k))$$
   Where $k \in \{0, 1, 2, 3, 4\}$ is the 0-indexed retry attempt.
3. **Execute Exponential Sleep:** Sleep for $T_{\text{wait}}(k)$ seconds (maximum 5 retries, $k=0$ through $4$).
4. **Local Fallback:** If all 5 retries fail, automatically trigger the provider failover cascade to Tier 4 Local (`Qwen 2.5 Coder 7B Q4_K_M`) running locally on the i5-12400F CPU.

---

## 4. RUNBOOK DR-03: CYCLIC AST OSCILLATION RECOVERY

Autonomous repair loops frequently fall into cyclic ping-pongs (e.g., alternating between fixing an indentation error and introducing a type mismatch):
1. **Capture Hash:** At each iteration, compute `hash_ast.py <target_file>`.
2. **Check Ring Buffer:** Compare hash against the last 3 recorded iterations in `.wrap/checkpoint.json`.
3. **Halt on Recurrence:** If $H(t) == H(t-2)$, trip the oscillation detector with exit code 42.
4. **Step-Back Protocol:** The agent is forced to wipe its local scratchpad, read the exact error traceback from the test runner, and attempt an alternative architectural strategy.

---

## 5. RUNBOOK DR-04: BINARY ASSET QUARANTINE PROTOCOL

Generative 3D APIs occasionally emit degenerate meshes (e.g., non-manifold geometry, 50,000 unindexed triangles, or multi-texture slot bindings):
1. **Trigger Condition:** `inspect_glb.py` fails with triangle count $> 1,500$ or material slots $> 1$.
2. **Immediate Quarantine:** The asset is moved to `07_ASSETS/quarantine/<timestamp>_<filename>.glb`.
3. **Diagnostic Logging:** A corresponding `<filename>_report.json` is generated detailing the exact accessor index and triangle overflow.
4. **No Engine Exposure:** Quarantined assets are never moved to `06_GAME_PROJECT/`, preventing Godot from generating `.godot/imported/` cache bloat.

---
*End of Chapter 05 Disaster Recovery Runbooks.*