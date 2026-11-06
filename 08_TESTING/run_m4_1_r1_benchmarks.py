import subprocess
import os
import sys
import time
import json
import csv

GODOT_BIN = "Godot_v4.7.2-stable_win64_console.exe"
PROJECT_PATH = "06_GAME_PROJECT"
TELEMETRY_DIR = "08_TESTING/telemetry/r1"

CONFIGS = {
    "A": {
        "name": "Config A (Windowed 720p, 1024 Shadow)",
        "flags": ["--windowed", "--shadow-1024"],
        "window_mode": 0,
        "shadow_size": 1024
    },
    "B": {
        "name": "Config B (Borderless Fullscreen, 1024 Shadow)",
        "flags": ["--borderless", "--shadow-1024"],
        "window_mode": 3,
        "shadow_size": 1024
    },
    "C": {
        "name": "Config C (Windowed 720p, 512 Shadow)",
        "flags": ["--windowed", "--shadow-512"],
        "window_mode": 0,
        "shadow_size": 512
    },
    "D": {
        "name": "Config D (Borderless Fullscreen, 512 Shadow)",
        "flags": ["--borderless", "--shadow-512"],
        "window_mode": 3,
        "shadow_size": 512
    }
}

CAMERA_MODES = ["third_person", "first_person"]

def run_single_benchmark(config_id, camera_mode, run_num, duration_sec=60.0, warmup_sec=5.0):
    cfg = CONFIGS[config_id]
    cam_flag = "--first-person" if camera_mode == "first_person" else "--third-person"
    
    cmd = [
        GODOT_BIN,
        "--rendering-driver", "opengl3",
        "--path", PROJECT_PATH,
        "--benchmark-auto-quit",
        "--config-id", config_id,
        "--run-num", str(run_num),
        "--benchmark-duration", str(duration_sec),
        "--warmup-duration", str(warmup_sec),
        "--output-dir", "../" + TELEMETRY_DIR,
        cam_flag
    ] + cfg["flags"]
    
    print(f"\n>>> Running: Config {config_id} | {camera_mode.upper()} | Run {run_num} ({duration_sec}s measurement + {warmup_sec}s warm-up)")
    print(f"    Command: {' '.join(cmd)}")
    
    t0 = time.time()
    proc = subprocess.run(cmd, capture_output=True, text=True)
    elapsed = time.time() - t0
    
    print(f"    Finished with exit code {proc.returncode} in {elapsed:.1f} s")
    
    # Verify resulting JSON
    expected_stem = f"m4_1_r1_config_{config_id.lower()}_{camera_mode.lower()}_run{run_num}"
    json_path = os.path.join(TELEMETRY_DIR, expected_stem + ".json")
    csv_path = os.path.join(TELEMETRY_DIR, expected_stem + ".csv")
    
    if not os.path.exists(json_path) or not os.path.exists(csv_path):
        print(f"    [ERROR] Missing output telemetry files: {json_path} or {csv_path}")
        print("    STDOUT:\n", proc.stdout[-500:])
        print("    STDERR:\n", proc.stderr[-500:])
        return None
        
    with open(json_path, 'r', encoding='utf-8') as f:
        data = json.load(f)
    
    meas = data["measurement"]
    p = meas["percentiles_ms"]
    print(f"    Result: {meas['sustained_fps']:.2f} FPS | P50: {p['p50']:.2f}ms | P95: {p['p95']:.2f}ms | P99: {p['p99']:.2f}ms | Spikes >42ms: {meas['spikes_over_42ms_count']}")
    return data

def main():
    os.makedirs(TELEMETRY_DIR, exist_ok=True)
    
    # Parse options if any
    quick = "--quick" in sys.argv
    duration = 10.0 if quick else 60.0
    warmup = 3.0 if quick else 5.0
    repetitions = 1 if quick else 3
    
    selected_configs = ["A", "B", "C", "D"]
    if "--config" in sys.argv:
        idx = sys.argv.index("--config")
        selected_configs = [sys.argv[idx + 1].upper()]
        
    all_results = {}
    
    print("==================================================================")
    print("PROJECT NULL — M4.1-R1 HARDWARE BENCHMARK SUITE")
    print(f"Configs       : {', '.join(selected_configs)}")
    print(f"Camera Modes  : {', '.join(CAMERA_MODES)}")
    print(f"Repetitions   : {repetitions}")
    print(f"Duration      : {duration}s measurement + {warmup}s warmup per run")
    print(f"Total Runs    : {len(selected_configs) * len(CAMERA_MODES) * repetitions}")
    print("==================================================================")
    
    for cid in selected_configs:
        all_results[cid] = {}
        for cam in CAMERA_MODES:
            all_results[cid][cam] = []
            for rep in range(1, repetitions + 1):
                res = run_single_benchmark(cid, cam, rep, duration_sec=duration, warmup_sec=warmup)
                if res is not None:
                    all_results[cid][cam].append(res)
                # Short cooldown between GPU stress runs
                time.sleep(1.0)
                
    # Save overall suite summary
    summary_path = os.path.join(TELEMETRY_DIR, "m4_1_r1_suite_summary.json")
    with open(summary_path, 'w', encoding='utf-8') as f:
        json.dump(all_results, f, indent=2)
    print(f"\nSaved comprehensive suite telemetry to: {summary_path}")

if __name__ == "__main__":
    main()
