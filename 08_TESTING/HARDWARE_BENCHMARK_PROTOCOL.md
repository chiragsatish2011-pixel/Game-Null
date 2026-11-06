# PROJECT NULL — HARDWARE BENCHMARK PROTOCOL & EMPIRICAL G210 VALIDATION SPECIFICATION

**Document ID:** PNL-TEST-BENCH-001  
**Document Version:** 2.2.0  
**Authority:** Technical Director & Lead Production Agent  
**Status:** SPECIFICATION ONLY — NON-PRODUCTION BENCHMARK PROTOCOL  
**Date:** 2026-11-05  
**Governing Mandates:** Final Evidence Accuracy Corrections Directive, M4.1 V2.1 Final Technical Reconciliation Directive, DEC-0001, DEC-0031, DEC-0038  
**Target Hardware Baseline:** Intel Core i5-12400F | 16 GB DDR4-3200 RAM | NVIDIA GeForce G210 (1024 MB DDR3 VRAM, 64-bit bus, 8.0 GB/s peak bandwidth, PCIe 2.0 x16, driver 342.01)  
**Target Engine Baseline:** Godot Engine 4.7.2 Stable (`gl_compatibility` / OpenGL 3.3 Core Profile)  

---

## 1. PURPOSE & NON-PRODUCTION ISOLATION GUARANTEE

### 1.1 Objective
This specification establishes a deterministic, reproducible, standalone hardware benchmark protocol designed to measure the actual runtime performance of the NVIDIA GeForce G210 running the Godot 4.7.2 Compatibility renderer.

The goal is to transition the provisional hardware limits established during Phase 2 (750 MB VRAM ceiling, 220 draw calls, 30 FPS floor, 60 FPS target) from theoretical assumptions into verified, empirical engineering data.

### 1.2 Non-Production Isolation & Non-Implementation Invariant
- **Strictly Non-Production:** The benchmark scene and scripts reside entirely within `08_TESTING/benchmark/`.
- **Zero Asset Spillover:** The benchmark uses procedurally generated blockout geometry (CSG / synthetic GLB) and Pillow-packed synthetic test textures. No production narrative assets, character meshes, or finalized environments from `06_GAME_PROJECT/` are utilized.
- **Strict Non-Execution Constraint:** This document is an engineering specification only. It defines how the benchmark will be executed when explicitly commanded by the Technical Director. It does NOT authorize vertical slice gameplay implementation.

### 1.3 Verification Stratification & Headless Execution Scope
To ensure scientific rigor and prevent inflated engineering claims, all testing and verification activities are classified under four strictly separated tiers:
1. **`API presence verified`:** The property, method, class, or constant exists and can be successfully resolved in the installed Godot engine binary.
2. **`Headless behaviour tested`:** Specific automated logic, transform calculations, or resource assignments were exercised in headless mode without a physical rendering context.
3. **`Interactive runtime verified`:** Behavior was exercised and confirmed operational in a visible, interactive running window with an active viewport and input subsystem.
4. **`Physical GPU performance verified`:** Frame times, memory throughput, and thermal stability were empirically measured and logged on physical GeForce G210 hardware.

> [!IMPORTANT]
> **Headless Execution Does NOT Measure Real G210 Performance or Runtime Correctness.**
> Godot's `--headless` mode initializes a dummy display server (`DisplayServerHeadless`) that avoids creating an active OpenGL context, rasterization pipeline, swapchain, or framebuffers. Headless execution validates syntax, static typing, and scene resource graphs (`API presence verified` and `Headless behaviour tested`), but provides **zero empirical data** regarding GPU fill rate, ROP throughput, DDR3 memory bus saturation, or frame-time pacing. Real GPU performance and interactive correctness can only be verified via an interactive, visible display window executing against the active NVIDIA driver (342.01).

---

## 2. REPRODUCIBLE TEST SCENE SPECIFICATION (`bench_district_synthetic.tscn`)

The benchmark scene recreates the exact spatial complexity, material density, and lighting constraints of the Vesper District 01 street corridor without using proprietary production assets:

```text
┌────────────────────────────────────────────────────────────────────────────────────────┐
│                        BENCHMARK TEST SCENE TOPOLOGY (80m CORRIDOR)                    │
│                                                                                        │
│   [Block A: 2-Storey]      [Block B: 3-Storey Gantry]       [Block C: Station Gate]   │
│   ┌─────────────────┐      ┌─────────────────────────┐      ┌─────────────────────┐   │
│   │  CSG / GLB Mesh │      │    CSG / GLB Mesh       │      │   CSG / GLB Mesh    │   │
│   └─────────────────┘      └─────────────────────────┘      └─────────────────────┘   │
│   ══════════════════════════════════════════════════════════════════════════════════   │
│      [MultiMesh Props]        [MultiMesh Props]               [MultiMesh Props]       │
│      • 8 Crate Clusters       • 6 Lamppost Stems              • 6 Metal Rail Segments │
│      (1 Material, 1 Draw)     (1 Material, 1 Draw)            (1 Material, 1 Draw)    │
│   ══════════════════════════════════════════════════════════════════════════════════   │
│   ◄──────────────────────────── 80.0 Meters ────────────────────────────────────────► │
└────────────────────────────────────────────────────────────────────────────────────────┘
```

### 2.1 Geometric Composition & Budgets
1. **Structural Facades (5 Static Meshes):**
   - Three 2-to-3 storey modular building blockouts, one overhead cross-street gantry, and one perimeter retaining wall.
   - Total structural polygon budget: 8,500 triangles.
2. **Repeated Environmental Props (MultiMeshInstance3D):**
   - Group 1: 8 Wooden Crate Clusters (16 instances total) -> 1,280 triangles.
   - Group 2: 6 Industrial Lampposts -> 1,440 triangles.
   - Group 3: 12 Steel Rail Segments -> 1,920 triangles.
   - Group 4: 10 Metal Trash/Signal Drums -> 1,200 triangles.
   - Combined MultiMesh budget: 5,840 triangles (4 draw calls total).
3. **Forensic Inspection Diorama (1 Detailed Clue Station):**
   - 1 Mechanical inspection table with 3 articulated clue props (lever, gear housing, brass dial).
   - Polygon budget: 3,200 triangles.
4. **Scene Totals:**
   - Total scene geometry: ~17,540 triangles.
   - Frustum visible geometry at worst-case vantage: 12,000 to 14,500 triangles.

### 2.2 Material & Texture Budget
- **Total Unique Materials:** Exactly 6 `StandardMaterial3D` instances:
  1. `mat_brick_facade` (Albedo, Normal, ORM)
  2. `mat_wet_cobblestone` (Albedo, Normal, ORM)
  3. `mat_painted_metal` (Albedo, Normal, ORM)
  4. `mat_corrugated_iron` (Albedo, Normal, ORM)
  5. `mat_wood_timber` (Albedo, Normal, ORM)
  6. `mat_brass_prop` (Albedo, Normal, ORM)
- **Texture Packing & Sizing:**
  - All maps strictly 512x512 pixels.
  - ORM maps generated via `pack_orm.py`: Red = AO, Green = Roughness, Blue = Metallic (1 single RGB sampler).
  - Normal maps: 512x512 tangent-space normal (1 sampler).
  - Albedo maps: 512x512 sRGB diffuse (1 sampler).
  - Total samplers per material: 3 (well within OpenGL 3.3 16-sampler ceiling).
  - Compression: Godot VRAM block compression (`compress/mode=2` — S3TC/DXT1/DXT5).

### 2.3 Lighting Configuration
- **Directional Light (1 Sun/Moon):** `DirectionalLight3D`, static angle (35° elevation), `shadow_enabled = true`, shadow map resolution `1024x1024`, 1-split orthogonal shadow cascade.
- **Omni Lights (4 Streetlamps):** `OmniLight3D`, `light_energy = 1.8`, `omni_range = 12.0m`, `shadow_enabled = false` (dynamic point shadows barred).
- **Spot Lights (2 Inspection Lights):** `SpotLight3D`, `spot_range = 8.0m`, `spot_angle = 35°`, `shadow_enabled = false`.
- **Active Lights Total:** 7 lights total (max 4 lights touching any single mesh object, strictly adhering to OpenGL 8 Omni + 8 Spot ceiling).

---

## 3. DISPLAY CONFIGURATION & TEST CONDITIONS

### 3.1 Primary & Secondary Resolutions
- **Primary Standard (720p):** $1280 \times 720$ (16:9 aspect ratio). Tested in Windowed and Fullscreen modes. This is the official shipping resolution target for the G210 baseline.
- **Secondary Stress Mode (1080p):** $1920 \times 1080$. Used exclusively to stress-test DDR3 memory bus bandwidth (8.0 GB/s peak) and evaluate fill-rate scaling.

### 3.2 Display Server & Window Modes
```ini
# project.godot benchmark overrides
[display]
window/size/viewport_width=1280
window/size/viewport_height=720
window/size/mode=0 ; 0 = Windowed, 3 = Exclusive Fullscreen / Fullscreen
window/vsync/vsync_mode=0 ; 0 = Disabled (Uncapped throughput), 1 = Enabled (60 Hz pacing)
```

**Display Mode Driver Compatibility Analysis:**
On Windows 11 64-bit running the legacy NVIDIA 342.01 driver, the OpenGL 3.3 Compatibility renderer implements fullscreen via `DisplayServerWindows`. Under Windows 11 DWM (Desktop Window Manager), `WINDOW_MODE_FULLSCREEN` operates as a borderless desktop-matched window rather than legacy hardware exclusive mode, which avoids video mode switches and alt-tab display crashes. Both windowed (mode 0) and fullscreen (mode 3) are fully supported by Godot 4.7.2.

### 3.3 Anti-Aliasing Test Matrix
The benchmark protocol executes across three discrete anti-aliasing passes:
1. **Pass A (Baseline / No AA):** `msaa_3d = DISABLED`, `screen_space_aa = DISABLED`.
2. **Pass B (Edge AA / MSAA 2x):** `msaa_3d = MSAA_2X`, `screen_space_aa = DISABLED`.
3. **Pass C (Post-Process / FXAA):** `msaa_3d = DISABLED`, `screen_space_aa = SCREEN_SPACE_AA_FXAA`.

---

## 4. CAMERA PATHS, WARM-UP & TEST EXECUTION PROTOCOL

### 4.1 Time-Based Warm-Up Accounting & Measurement Exclusions
- **Time-Based Warm-Up Period:** Exactly 5.0 seconds of automated execution is performed before benchmark logging begins. This allows driver shader compilation, pipeline linking, and initial VRAM memory allocation to stabilize.
- **Dynamic Frame Discard Accounting:** The 5.0-second warm-up is strictly time-based and is **NOT** described as "exactly 300 frames" (at 30 FPS it generates ~150 frames; at 60 FPS it generates ~300 frames). The exact frame count discarded during warm-up is dynamically counted and recorded.
- **Mandatory Warm-Up Log Schema:** Every benchmark run records:
  1. `warmup_start_usec`: Timestamp when warm-up commences.
  2. `warmup_end_usec`: Timestamp when warm-up completes.
  3. `warmup_duration_ms`: Actual warm-up elapsed time in milliseconds.
  4. `warmup_discarded_frames`: Exact count of frames rendered and discarded during warm-up ($N_{\text{discarded}}$).
  5. `measurement_start_usec`: Official start of benchmark data recording.
  6. `measurement_end_usec`: Official termination of benchmark data recording.
- **Exclusion Rule:** All telemetry collected during the initial 5.0-second warm-up window is excluded from steady-state frame-time percentiles.
- **Camera Transition Spike Transparency:** Any camera cuts or transitions occurring within the benchmark sequence must report their cut frames in a separate diagnostic column. **Zero transition spikes may be silently discarded from the report without documented logging.**

### 4.2 Scripted Camera Sequence (60.0 Seconds Total)
An automated, deterministic sequence controlled by an `AnimationPlayer` runs across 4 discrete stages:

```text
┌───────────────┬─────────────────┬─────────────────────────────────────────────────────────┐
│ Segment       │ Time Interval   │ Camera Mode & Description                               │
├───────────────┼─────────────────┼─────────────────────────────────────────────────────────┤
│ Vantage 1     │ 0.0s – 15.0s    │ Vista Frustum (Worst-case depth: entire 80m corridor). │
│ Vantage 2     │ 15.0s – 30.0s   │ Dense Inspection Cluster (MultiMesh props & grazing).   │
│ Vantage 3     │ 30.0s – 45.0s   │ Occluded Alleyway (Evaluates culling & fill relief).    │
│ Trajectory 4  │ 45.0s – 60.0s   │ Continuous Spline Flythrough (5.0 m/s moving camera).   │
└───────────────┴─────────────────┴─────────────────────────────────────────────────────────┘
```

- **Camera 1 (Vista Frustum, 0–15s):** Placed at $(0, 2.5, 40)$, looking forward along the entire 80m corridor. Maximizes draw calls and visible geometry; all 7 lights and MultiMesh instances in view.
- **Camera 2 (Inspection Cluster, 15–30s):** Placed at $(4.5, 1.2, 5)$, focused on the detailed clue table and crate cluster. Evaluates high-frequency roughness shading and specular highlights under grazing light angles.
- **Camera 3 (Occluded Alleyway, 30–45s):** Placed behind the 3-storey building block. Evaluates frustum culling effectiveness and fill-rate recovery.
- **Camera 4 (Flythrough Spline, 45–60s):** Smooth Catmull-Rom spline moving from $(0, 2.0, -35)$ to $(0, 4.0, 35)$ at $5.0\text{ m/s}$.
  > [!NOTE]
  > **Correction on Streaming:** Trajectory 4 evaluates **dynamic frustum culling, mipmap LOD transitions, and batch culling stability under motion**. It does NOT measure or test world streaming, as no background disk streaming subsystem is present in this benchmark.

### 4.3 Repeat Count & Test Order
Every display configuration is executed for exactly **3 full iterations** to verify reproducibility:
1. Run 1: 720p No-AA (Warm-up 5s + Test 60s)
2. Run 2: 720p MSAA 2x (Warm-up 5s + Test 60s)
3. Run 3: 720p FXAA (Warm-up 5s + Test 60s)
4. Run 4: 1080p Stress Run (Warm-up 5s + Test 60s)

---

## 5. TELEMETRY TAXONOMY & RIGOROUS MEASUREMENT DEFINITIONS

To eliminate ambiguity, rendering terms and telemetry channels are strictly segregated:

```text
┌─────────────────────────────────┬────────────────────────────────────────────────────────┐
│ Metric Term                     │ Exact Technical Definition                             │
├─────────────────────────────────┼────────────────────────────────────────────────────────┤
│ 1. Draw Call                    │ A single CPU-to-GPU rendering dispatch command         │
│                                 │ (glDrawElements / glDrawArrays).                       │
│ 2. Render Pass                  │ An entire execution pass over a framebuffer/target     │
│                                 │ (e.g. shadow map pass, forward geometry pass, UI pass).│
│ 3. Rendered Object              │ A distinct Node3D instance evaluated by frustum culling│
│                                 │ (Performance.RENDER_TOTAL_OBJECTS_IN_FRAME).           │
│ 4. Visible Primitives           │ The total number of rasterized geometric triangles     │
│                                 │ (Performance.RENDER_TOTAL_PRIMITIVES_IN_FRAME).        │
│ 5. Engine-Observed Frame Time   │ Inter-frame delta measured inside Godot main loop      │
│                                 │ via Time.get_ticks_usec() (NOT present-to-display).    │
│ 6. Present-to-Display Latency   │ True hardware latency from present dispatch to scanout │
│                                 │ on physical monitor (requires external PresentMon).    │
└─────────────────────────────────┴────────────────────────────────────────────────────────┘
```

### 5.1 Internal Godot Engine Telemetry (100% Verified Available)
Queried programmatically per-frame in GDScript via `Performance.get_monitor()`:
- `Performance.TIME_FPS`: Instantaneous frame rate.
- `Performance.TIME_PROCESS`: CPU frame process time in seconds.
- `Performance.TIME_PHYSICS_PROCESS`: CPU physics frame time in seconds.
- `Performance.RENDER_TOTAL_DRAW_CALLS_IN_FRAME`: Total draw calls dispatched in current frame.
- `Performance.RENDER_TOTAL_OBJECTS_IN_FRAME`: Total visual objects evaluated.
- `Performance.RENDER_TOTAL_PRIMITIVES_IN_FRAME`: Total triangles rendered.
- `Performance.RENDER_VIDEO_MEM_USED`: Internal engine video memory (textures + buffers in bytes).
- `Performance.RENDER_TEXTURE_MEM_USED`: Internal texture memory in bytes.
- `Performance.RENDER_BUFFER_MEM_USED`: Internal vertex/index buffer memory in bytes.
- Frame delta array: Captured via `Time.get_ticks_usec()`.

### 5.2 External Windows OS & GPU Telemetry (Empirical Hardware Availability Audit)
In compliance with Directive Requirement 4, the proposed telemetry mechanisms were empirically probed on the active Windows 11 host running the NVIDIA GeForce G210 (Driver 21.21.13.4201 / WDDM 1.2):

```text
┌──────────────────────────────────────┬─────────────┬─────────────────────────────────────────────────────────────────┐
│ Telemetry Channel                    │ Status      │ Exact API, Counter & Empirical Availability Finding             │
├──────────────────────────────────────┼─────────────┼─────────────────────────────────────────────────────────────────┤
│ • Hardware Installed Adapter RAM     │ AVAILABLE   │ PowerShell CIM: `Get-CimInstance Win32_VideoController`.        │
│                                      │ (Static)    │ Verified returns: AdapterRAM = 1073741824 bytes (1024 MB).       │
│ • DXGI Dedicated Video Memory Cap.   │ AVAILABLE   │ DXGI: `CreateDXGIFactory` -> `IDXGIAdapter::GetDesc`.           │
│                                      │ (Static)    │ Verified returns: DedicatedVideoMemory = 1019871232 bytes       │
│                                      │             │ (972.62 MB dedicated video-memory capacity reported by the      │
│                                      │             │ DXGI adapter descriptor; 51.38 MB reserved by firmware/VBIOS).  │
│ • DXGI Active Video Memory Info      │ UNAVAILABLE │ DXGI 1.4+: `IDXGIAdapter3::QueryVideoMemoryInfo`.                │
│                                      │             │ Probed live: Returns E_NOINTERFACE (0x80004002) because driver  │
│                                      │             │ 342.01 lacks WDDM 2.0+ DXGI 1.4 interfaces.                     │
│ • PDH GPU Dedicated Usage Counters   │ UNAVAILABLE │ `\GPU Adapter Memory(*)\dedicated usage` & `GPU Process Memory` │
│                                      │             │ Probed live: CookedValue returns 0. Driver 342.01 does not      │
│                                      │             │ report dynamic dedicated usage to Windows PDH counters.         │
│ • Host Process Working Set RAM       │ AVAILABLE   │ PowerShell: `Get-Process Godot* | Select WorkingSet64`.         │
│                                      │             │ Verified fully available and reliable for process host RAM.     │
│ • Engine-Internal Video Memory (VRAM)│ AVAILABLE   │ GDScript: `Performance.get_monitor(RENDER_VIDEO_MEM_USED)`.    │
│                                      │             │ Verified operational inside Godot OpenGL context (<= 500 MB).   │
│ • Physical Chip-Level Dedicated VRAM │ AVAILABLE   │ External Tool: GPU-Z Background Sensor Logging (via NVAPI       │
│                                      │ (External)  │ private IOCTLs). Authoritative physical silicon artifact.       │
│ • GPU Core / Memory Clock & Diode    │ AVAILABLE   │ External Tool: GPU-Z / HWiNFO sensor logging (589 MHz core /    │
│                                      │ (External)  │ 500 MHz memory / diode temp °C). Authoritative hardware source. │
│ • nvidia-smi CLI Tool                │ UNAVAILABLE │ GeForce Driver 342.01 does not include nvidia-smi utility.      │
│ • Programmatic Bus Saturation Sensor │ UNAVAILABLE │ Evaluated via 720p vs 1080p fill-rate scaling differential.     │
└──────────────────────────────────────┴─────────────┴─────────────────────────────────────────────────────────────────┘
```

> [!IMPORTANT]
> **Strict Memory Metric Segregation & Headroom Invariance:**
> `IDXGIAdapter::GetDesc` returns the adapter's reported dedicated video-memory capacity (972.62 MB). It does **NOT** report currently free VRAM, available allocation budget, or live application usage. The engineering team must maintain strict separation between:
> 1. **Physical / Descriptor Capacity:** Static hardware/driver limits (1024 MB physical, 972.62 MB DXGI descriptor capacity).
> 2. **Godot Engine-Reported Allocation:** Programmatic memory tracked via `Performance.RENDER_VIDEO_MEM_USED` ($\le 500\text{ MB}$).
> 3. **Process-Specific GPU Memory:** Per-process video memory (unsupported on legacy driver 342.01 / WDDM 1.2).
> 4. **Live Adapter-Wide Dedicated Usage:** Real-time physical allocation on the GPU silicon ($\le 750\text{ MB}$), captured exclusively via external GPU-Z sensor logs querying NVAPI.
> 
> **Never infer current usage or available headroom from adapter capacity.** Allocations must be verified against actual engine and sensor telemetry.

---

## 6. FRAME-TIME PERCENTILES & STATISTICAL ANALYSIS

Frame times are compiled across all $N$ valid frames captured during the 60-second test ($N \approx 1,800$ to $3,600$ frames):

### 6.1 Statistical Formulation & Methodology
1. **Array Sorting:** Engine-observed frame intervals in milliseconds sorted ascending:
   $$T = [t_1, t_2, \dots, t_N] \quad \text{where } t_i \le t_{i+1}$$
2. **Sustained FPS Methodology (Mandatory):**
   $$\text{Sustained FPS} = \frac{\text{Total Rendered Frames}}{\text{Total Measurement Elapsed Time (seconds)}} = \frac{N_{\text{total}}}{T_{\text{elapsed}}}$$
   > [!IMPORTANT]
   > Calculating sustained FPS by taking the arithmetic mean of instantaneous FPS samples is **strictly prohibited**, as instantaneous sampling mathematically overweights slow hitch frames and produces an invalid throughput measure.
3. **Median (P50):** The 50th percentile representing typical frame pacing:
   $$P50 = T[\lfloor 0.50 \times N \rfloor]$$
4. **95th Percentile (P95):** The threshold above which the slowest 5% of frames fall:
   $$P95 = T[\lfloor 0.95 \times N \rfloor]$$
5. **99th Percentile (P99):** The threshold representing extreme hitching (slowest 1%):
   $$P99 = T[\lfloor 0.99 \times N \rfloor]$$
6. **Maximum Observed Frame Time ($t_{\max}$):** The single worst frame interval recorded:
   $$t_{\max} = T[N]$$
7. **Frame-Time Variance (Jitter):**
   $$\sigma = \sqrt{\frac{1}{N} \sum_{i=1}^N (t_i - \mu)^2} \quad \text{where } \mu = \frac{1}{N} \sum_{i=1}^N t_i$$

### 6.2 Mandatory Telemetry Report Schema
Every benchmark and PoC telemetry execution report must publish these 7 core metrics:
1. **Median Frame Time (P50)** (ms)
2. **95th Percentile Frame Time (P95)** (ms)
3. **99th Percentile Frame Time (P99)** (ms)
4. **Maximum Observed Frame Time ($t_{\max}$)** (ms)
5. **Total Rendered Frames ($N_{\text{total}}$)**
6. **Actual Measurement Duration ($T_{\text{elapsed}}$)** (seconds)
7. **Sustained Framerate ($N_{\text{total}} / T_{\text{elapsed}}$)** (FPS)

---

## 7. THERMAL & SUSTAINED-LOAD BEHAVIORAL PROFILE

The G210 hardware configuration uses a low-profile passive aluminum heatsink or low-RPM 40mm fan, making sustained load evaluation essential:

### 7.1 10-Minute Sustained Loop
- The 60-second benchmark sequence loops continuously for 10 consecutive iterations (600 seconds total elapsed time).
- Thermal checkpoints recorded at $T_0$ (idle), $T_2$ (2 mins), $T_5$ (5 mins), and $T_{10}$ (steady state).

### 7.2 Rigorous 4-Tier Thermal Constraint Classification
Observations are classified into one of four mutually exclusive operational states:
1. **Confirmed Thermal Throttling:** Supported by a definitive driver or hardware throttling indicator (e.g. GPU-Z PerfCap Reason = `Thrm`, or NVAPI thermal slowdown status active).
2. **Suspected Thermal Constraint:** Sustained GPU diode temperature increase ($\ge 85^\circ\text{C}$) accompanied by sustained core clock reduction from baseline operating clock, without a definitive hardware throttling flag.
3. **No Observed Thermal Constraint:** No meaningful sustained core clock reduction or thermal warning observed during the 10-minute continuous load test.
4. **Unavailable:** Required thermal or sensor data cannot be obtained from the platform.

### 7.3 Sensor Sourcing and Availability
- **GPU Diode Temperature (°C):** Sourced from GPU-Z background sensor log (via NVAPI interface). Marked unavailable via CLI.
- **GPU Core / Memory Clock (MHz):** Sourced from GPU-Z background sensor log. Marked unavailable via CLI.
- **Host CPU Temperature (°C):** Sourced from HWiNFO sensor logging.

---

## 8. MINIMUM ACCEPTABLE PERFORMANCE & FALLBACK CRITERIA

```text
┌──────────────┬────────────────────────┬──────────────────────┬────────────────────────────────────────────────────────┐
│ Target Tier  │ Frame Time Percentiles │ Draw Calls & VRAM    │ Operational Disposition                                │
├──────────────┼────────────────────────┼──────────────────────┼────────────────────────────────────────────────────────┤
│ TIER 1       │ P50 <= 16.67 ms (60FPS)│ Draw Calls <= 150    │ OPTIMIZATION TARGET: Excellent headroom. Proceed with  │
│ (Optimal)    │ P95 <= 18.00 ms        │ WDDM VRAM <= 650 MB  │ full visual specification.                             │
│              │ P99 <= 22.00 ms        │                      │                                                        │
├──────────────┼────────────────────────┼──────────────────────┼────────────────────────────────────────────────────────┤
│ TIER 2       │ P50 <= 33.33 ms (30FPS)│ Draw Calls <= 220    │ ACCEPTABLE FLOOR: Official baseline pass.              │
│ (Acceptance  │ P95 <= 36.00 ms        │ WDDM VRAM <= 750 MB  │ Lock 30 FPS cap or activate Level 1 Fallbacks.         │
│  Baseline)   │ P99 <= 42.00 ms        │                      │                                                        │
├──────────────┼────────────────────────┼──────────────────────┼────────────────────────────────────────────────────────┤
│ TIER 3       │ P50 > 33.33 ms (<30FPS)│ Draw Calls > 220     │ PERFORMANCE BREACH: Mandatory execution of             │
│ (Failure)    │ P99 > 50.00 ms (Stall) │ WDDM VRAM > 750 MB   │ Level 2 Fallbacks before Phase 4 expansion.            │
└──────────────┴────────────────────────┴──────────────────────┴────────────────────────────────────────────────────────┘
```

### 8.1 Fallback Hierarchy:

#### Level 1 Fallbacks (Triggered if Tier 2 Yellow):
1. **Reduce Directional Shadow Map:** Downsample directional shadow map from $1024 \times 1024$ to $512 \times 512$ (saves 1.5 MB VRAM and 40% shadow raster bandwidth).
2. **Cap Active Omni Lights:** Reduce maximum unshadowed omni lights from 4 to 2 in street corridors.
3. **Downsample Secondary Props:** Downsample secondary prop textures (crates, barrels) from 512x512 to 256x256 via `pack_orm.py --size 256`.
4. **Disable MSAA:** Force FXAA or disable anti-aliasing entirely.

#### Level 2 Fallbacks (Triggered if Tier 3 Red):
1. **Internal 3D Resolution Scaling:** Set `rendering/scaling_3d/scale = 0.75` (internal 3D render at $960 \times 540$, upscaled via bilinear filter to 720p). Reduces raster pixel fill workload by 43.75%.
2. **Eliminate Dynamic Directional Shadows:** Switch `DirectionalLight3D` to `shadow_enabled = false` and bake static sunlight into vertex colors or low-res lightmap textures.
3. **Aggressive MultiMesh Batching:** Merge all street props into a single combined multi-mesh buffer to enforce $\le 80$ total draw calls.

---

*End of Hardware Benchmark Protocol Specification.*
