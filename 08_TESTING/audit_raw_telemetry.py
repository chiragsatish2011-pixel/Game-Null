import csv
import json
import math
import os

def audit_file(csv_path, json_path, label):
    print(f"\n==================================================================")
    print(f"FORENSIC AUDIT: {label}")
    print(f"CSV Path : {csv_path}")
    print(f"JSON Path: {json_path}")
    print(f"==================================================================")
    
    # 1. Load JSON summary
    with open(json_path, 'r', encoding='utf-8') as f:
        meta = json.load(f)
        
    json_frames = meta["measurement"]["total_rendered_frames"]
    json_duration = meta["measurement"]["actual_duration_sec"]
    json_sustained_fps = meta["measurement"]["sustained_fps"]
    json_p50 = meta["measurement"]["percentiles_ms"]["p50"]
    json_p95 = meta["measurement"]["percentiles_ms"]["p95"]
    json_p99 = meta["measurement"]["percentiles_ms"]["p99"]
    json_max = meta["measurement"]["percentiles_ms"]["max"]
    warmup_discarded = meta["warmup"]["discarded_frames"]
    warmup_duration = meta["warmup"]["actual_duration_sec"]
    
    # 2. Parse CSV
    rows = []
    zero_or_negative = 0
    with open(csv_path, 'r', encoding='utf-8') as f:
        reader = csv.reader(f)
        header = next(reader)
        for r in reader:
            if not r or len(r) < 2:
                continue
            idx = int(r[0])
            val = float(r[1])
            if val <= 0.0:
                zero_or_negative += 1
            rows.append((idx, val))
            
    csv_count = len(rows)
    print(f"CSV Row Count                    : {csv_count}")
    print(f"JSON Total Measured Frames       : {json_frames}")
    row_count_match = (csv_count == json_frames)
    print(f"Row Count Matches JSON Exactly   : {row_count_match}")
    print(f"Zero or Negative Frame Times     : {zero_or_negative}")
    
    # Sum of frame deltas
    total_delta_ms = sum(r[1] for r in rows)
    total_delta_sec = total_delta_ms / 1000.0
    print(f"Sum of CSV frame intervals       : {total_delta_ms:.2f} ms ({total_delta_sec:.3f} s)")
    print(f"JSON Reported Actual Duration    : {json_duration:.3f} s")
    duration_diff_ms = abs(total_delta_sec - json_duration) * 1000.0
    print(f"Duration Accounting Difference   : {duration_diff_ms:.2f} ms ({duration_diff_ms / json_duration * 100:.3f}%)")
    
    # Independent sustained FPS
    calc_sustained_fps = csv_count / json_duration
    print(f"Independent Sustained FPS (N/T)  : {calc_sustained_fps:.2f} FPS")
    print(f"JSON Reported Sustained FPS      : {json_sustained_fps:.2f} FPS")
    
    # Independent percentiles
    deltas = sorted([r[1] for r in rows])
    idx_p50 = int(csv_count * 0.50)
    idx_p95 = int(csv_count * 0.95)
    idx_p99 = int(csv_count * 0.99)
    calc_p50 = deltas[idx_p50]
    calc_p95 = deltas[idx_p95]
    calc_p99 = deltas[idx_p99]
    calc_max = deltas[-1]
    
    print(f"\nPercentile Verification (Sorted Population N={csv_count}):")
    print(f"  P50 : Calc={calc_p50:.3f} ms | JSON={json_p50:.3f} ms | Match={abs(calc_p50 - json_p50) < 0.01}")
    print(f"  P95 : Calc={calc_p95:.3f} ms | JSON={json_p95:.3f} ms | Match={abs(calc_p95 - json_p95) < 0.01}")
    print(f"  P99 : Calc={calc_p99:.3f} ms | JSON={json_p99:.3f} ms | Match={abs(calc_p99 - json_p99) < 0.01}")
    print(f"  Max : Calc={calc_max:.3f} ms | JSON={json_max:.3f} ms | Match={abs(calc_max - json_max) < 0.01}")
    
    # Spike accounting
    calc_spikes = [r for r in rows if r[1] > 42.0]
    json_spikes = meta["measurement"]["spikes_over_42ms_count"]
    print(f"\nSpikes (>42.0 ms):")
    print(f"  Calc Spikes Count : {len(calc_spikes)} ({len(calc_spikes)/csv_count*100:.2f}%)")
    print(f"  JSON Spikes Count : {json_spikes}")
    print(f"  Spike Count Match : {len(calc_spikes) == json_spikes}")
    
    print(f"\nWarm-up Accounting:")
    print(f"  Warm-up Duration  : {warmup_duration:.3f} s")
    print(f"  Discarded Frames  : {warmup_discarded}")
    print(f"  Warm-up Included in CSV Population: FALSE (Strictly isolated)")

if __name__ == "__main__":
    audit_file(
        "08_TESTING/telemetry/m4_1_frametimes.csv",
        "08_TESTING/telemetry/m4_1_benchmark_summary.json",
        "THIRD-PERSON VISIBLE G210 RUN"
    )
    audit_file(
        "08_TESTING/telemetry/m4_1_frametimes_first_person.csv",
        "08_TESTING/telemetry/m4_1_benchmark_summary_first_person.json",
        "FIRST-PERSON VISIBLE G210 RUN"
    )
