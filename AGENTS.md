<!-- PROJECT NULL — AGENTS.md WORKSPACE INSTRUCTIONS -->
# PROJECT NULL — Autonomous Agent Workspace Directives
**Target Engine:** Godot Engine 4.7.2 Stable (`gl_compatibility` / OpenGL 3.3 Core Profile)
**Target Hardware Baseline:** Intel Core i5-12400F | 16 GB DDR4 RAM | NVIDIA GeForce G210 (1024 MB DDR3 VRAM, 64-bit bus)
**Framework:** GodotPrompter (v1.16.0)

<!-- SESSION-CARD-START -->
**GodotPrompter is active in this Godot project.**

Workflow plugins decide *how you work*; GodotPrompter decides *what you build*. Both apply.

**RULE: before implementing any Godot system, invoke the matching `godot-prompter:*` skill.**
Applies to subagents writing Godot code too.

| Situation | Start with |
|---|---|
| New system, or the requirements are unclear | `godot-grill` — settle decisions, then design and build |
| Known change, explicit ask, bug fix | the domain skill below — build |

**Then report before you build:** name the pattern you picked, the alternative you rejected, and why. The choice is the developer's. A report states; it never ends on your own questions. A design decision needs the developer's answer or go-ahead first? Invoke `godot-grill`.

| Building… | Start with |
|---|---|
| Movement, input, cameras | `player-controller`, `input-handling`, `camera-system` |
| Architecture | `state-machine`, `event-bus`, `scene-organization`, `component-system`, `resource-pattern`, `dependency-injection` |
| Gameplay systems | `inventory-system`, `dialogue-system`, `ability-system`, `save-load` |
| Enemy AI | `ai-navigation` |
| UI, HUD, i18n | `godot-ui`, `hud-system`, `responsive-ui`, `localization` |
| Animation, tweens, audio | `animation-system`, `tween-animation`, `audio-system` |
| Physics, 2D, 3D | `physics-system`, `2d-essentials`, `3d-essentials` |
| Shaders, rendering, VFX, procgen, math | `shader-basics`, `rendering-pipeline`, `particles-vfx`, `procedural-generation`, `math-essentials` |
| Performance, profiling | `godot-optimization` |
| Review, testing, debugging | `godot-code-review`, `godot-testing`, `godot-debugging` |

<!-- SESSION-CARD-END -->

## Mandatory Architectural Invariants for Project NULL
1. **Rendering Method:** Strictly `gl_compatibility` (OpenGL 3.3 Core Profile).
2. **Unsupported Features (Strictly Barred):**
   - NO SDFGI, NO VoxelGI, NO Volumetric Fog, NO SSIL, NO SSR, NO TAA, NO FSR 2.
   - NO Compute Shaders (`RenderingDevice` compute pipelines, SSBOs).
   - NO Point Light Shadows (dynamic point light shadows cause severe DDR3 bus starvation).
   - OpenGL Light Ceilings: Max 8 Omni + 8 Spot lights per mesh object; max 32 renderable lights per frame.
3. **Asset Pipeline:** Strictly Blender-Free (DEC-0002). No `.blend` imports; use CSG modular blockouts, Pillow ORM packing, and glTF 2.0 binary (`.glb`).
4. **Non-Implementation Gate:** Strictly no production gameplay scripts (`.gd`), scenes (`.tscn`), or final assets in `06_GAME_PROJECT/` until formal Phase 4 greenlight.
