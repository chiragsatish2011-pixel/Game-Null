import subprocess
import os
import sys
import time
import json

GODOT_BIN = "Godot_v4.7.2-stable_win64_console.exe"
PROJECT_PATH = "06_GAME_PROJECT"
OUT_DIR = "08_TESTING/telemetry/shadow_investigation"

EXPERIMENTS = [
    {
        "id": "FP_SHADOW_DISABLED",
        "label": "First-Person | Shadow Disabled (Zero Shadow PCF)",
        "cam": "--first-person",
        "flags": ["--windowed", "--shadow-disabled"]
    },
    {
        "id": "FP_SHADOW_DIST_12M_ATLAS_512",
        "label": "First-Person | Shadow Distance 12.0m | 512 Atlas",
        "cam": "--first-person",
        "flags": ["--windowed", "--shadow-512", "--shadow-distance", "12.0"]
    },
    {
        "id": "FP_SHADOW_DIST_12M_ATLAS_1024",
        "label": "First-Person | Shadow Distance 12.0m | 1024 Atlas",
        "cam": "--first-person",
        "flags": ["--windowed", "--shadow-1024", "--shadow-distance", "12.0"]
    },
    {
        "id": "TP_SHADOW_DIST_12M_ATLAS_1024",
        "label": "Third-Person | Shadow Distance 12.0m | 1024 Atlas",
        "cam": "--third-person",
        "flags": ["--windowed", "--shadow-1024", "--shadow-distance", "12.0"]
    }
]

def run_experiment(exp, duration=30.0, warmup=4.0):
    os.makedirs(OUT_DIR, exist_ok=True)
    cmd = [
        GODOT_BIN,
        "--rendering-driver", "opengl3",
        "--path", PROJECT_PATH,
        "--benchmark-auto-quit",
        "--config-id", exp["id"],
        "--run-num", "1",
        "--benchmark-duration", str(duration),
        "--warmup-duration", str(warmup),
        "--output-dir", "../" + OUT_DIR,
        exp["cam"]
    ] + exp["flags"]
    
    print(f"\n==================================================================")
    print(f"RUNNING EXPERIMENT: {exp['label']}")
    print(f"Command: {' '.join(cmd)}")
    print(f"==================================================================")
    
    t0 = time.time()
    proc = subprocess.run(cmd, capture_output=True, text=True)
    elapsed = time.time() - t0
    
    file_stem = f"m4_1_r1_config_{exp['id'].lower()}_{'first_person' if 'first' in exp['cam'] else 'third_person'}_run1"
    json_path = os.path.join(OUT_DIR, file_stem + ".json")
    
    if os.path.exists(json_path):
        with open(json_path, 'r', encoding='utf-8') as f:
            data = json.load(f)
        meas = data["measurement"]
        p = meas["percentiles_ms"]
        print(f"Result: {meas['sustained_fps']:.2f} FPS | P50={p['p50']:.2f}ms | P95={p['p95']:.2f}ms | P99={p['p99']:.2f}ms | Max={p['max']:.2f}ms | Spikes={meas['spikes_over_42ms_count']}")
        return data
    else:
        print("[ERROR] Output file not found:", json_path)
        print("STDOUT:\n", proc.stdout[-400:])
        return None

def main():
    print("STARTING FIRST-PERSON SHADOW OPTIMIZATION INVESTIGATION")
    results = {}
    for exp in EXPERIMENTS:
        res = run_experiment(exp, duration=30.0, warmup=4.0)
        if res is not None:
            results[exp["id"]] = res
        time.sleep(1.0)
        
    summary_path = os.path.join(OUT_DIR, "shadow_investigation_summary.json")
    with open(summary_path, 'w', encoding='utf-8') as f:
        json.dump(results, f, indent=2)
    print(f"\nAll experiments complete. Summary saved to: {summary_path}")

if __name__ == "__main__":
    main()
