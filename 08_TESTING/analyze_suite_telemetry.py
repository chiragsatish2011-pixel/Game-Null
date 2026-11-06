import os
import glob
import json
import csv
import math

TELEMETRY_DIR = "08_TESTING/telemetry/r1"

def mean(vals):
    return sum(vals) / len(vals) if vals else 0.0

def std_dev(vals):
    if len(vals) < 2:
        return 0.0
    m = mean(vals)
    variance = sum((x - m) ** 2 for x in vals) / (len(vals) - 1)
    return math.sqrt(variance)

def analyze_all():
    json_files = glob.glob(os.path.join(TELEMETRY_DIR, "m4_1_r1_config_*.json"))
    
    data_by_config_mode = {}
    
    for jf in json_files:
        with open(jf, 'r', encoding='utf-8') as f:
            data = json.load(f)
            
        cfg = data["configuration"]
        cid = cfg["config_id"]
        cam = cfg["camera_mode"].lower()
        rep = cfg["repetition"]
        
        key = (cid, cam)
        if key not in data_by_config_mode:
            data_by_config_mode[key] = []
            
        meas = data["measurement"]
        p = meas["percentiles_ms"]
        
        data_by_config_mode[key].append({
            "rep": rep,
            "file": os.path.basename(jf),
            "fps": meas["sustained_fps"],
            "p50": p["p50"],
            "p95": p["p95"],
            "p99": p["p99"],
            "max": p["max"],
            "spikes": meas["spikes_over_42ms_count"],
            "warmup_frames": data["warmup"]["discarded_frames"],
            "warmup_sec": data["warmup"]["actual_duration_sec"],
            "pass": data["acceptance_evaluation"]["overall_tier_2_pass"]
        })
        
    print("\n==================================================================")
    print("M4.1-R1 HARDWARE TELEMETRY SUMMARY")
    print("==================================================================")
    
    for (cid, cam), runs in sorted(data_by_config_mode.items()):
        runs.sort(key=lambda x: x["rep"])
        print(f"\n--- Config {cid} | {cam.upper()} (N={len(runs)}) ---")
        fps_list = [r["fps"] for r in runs]
        p50_list = [r["p50"] for r in runs]
        p95_list = [r["p95"] for r in runs]
        p99_list = [r["p99"] for r in runs]
        spike_list = [r["spikes"] for r in runs]
        
        for r in runs:
            print(f"  Run {r['rep']}: {r['fps']:.2f} FPS | P50={r['p50']:.2f}ms | P95={r['p95']:.2f}ms | P99={r['p99']:.2f}ms | Max={r['max']:.2f}ms | Spikes={r['spikes']} | Warmup={r['warmup_frames']} frames in {r['warmup_sec']:.2f}s | Pass={r['pass']}")
            
        print(f"  >> Aggregate: Mean FPS={mean(fps_list):.2f} (std={std_dev(fps_list):.2f}) | Mean P50={mean(p50_list):.2f}ms | Mean P95={mean(p95_list):.2f}ms | Mean P99={mean(p99_list):.2f}ms | Mean Spikes={mean(spike_list):.1f}")

if __name__ == "__main__":
    analyze_all()
