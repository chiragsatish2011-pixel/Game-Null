#!/usr/bin/env python3
"""
PROJECT NULL — Comprehensive Pipeline Diagnostics & Edge-Case Verification Suite
File: 08_TESTING/test_pipeline_diagnostics.py
Authority: Test Diagnostics Specialist
Skill Applied: godot-debugging
"""

import sys
import os
import subprocess
import tempfile
import json
from pathlib import Path

ROOT_DIR = Path(__file__).resolve().parents[1]
PYTHON_EXE = sys.executable
GODOT_EXE = "Godot_v4.7.2-stable_win64_console.exe"

def run_cmd(cmd, cwd=ROOT_DIR):
    res = subprocess.run(cmd, cwd=cwd, capture_output=True, text=True)
    return res.returncode, res.stdout, res.stderr

def test_hash_ast():
    print("[1/6] Testing hash_ast.py edge cases...")
    script = str(ROOT_DIR / "04_AI_STUDIO" / "scripts" / "hash_ast.py")
    
    # 1. No arguments -> exit 2
    rc, out, err = run_cmd([PYTHON_EXE, script])
    assert rc == 2, f"Expected exit 2, got {rc}"
    assert "Usage:" in err or "Usage:" in out

    # 2. Missing target file -> exit 1
    rc, out, err = run_cmd([PYTHON_EXE, script, "nonexistent.gd"])
    assert rc == 1, f"Expected exit 1, got {rc}"
    assert "ERROR:" in err

    with tempfile.TemporaryDirectory() as tmp_dir:
        tmp_p = Path(tmp_dir)
        # 3. Zero-byte target file -> exit 0
        empty_gd = tmp_p / "empty.gd"
        empty_gd.write_text("", encoding="utf-8")
        rc, out, err = run_cmd([PYTHON_EXE, script, str(empty_gd)])
        assert rc == 0, f"Expected exit 0, got {rc}"
        assert "SEMANTIC_HASH: e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855" in out

        # 4. Trailing --checkpoint flag -> exit 2
        rc, out, err = run_cmd([PYTHON_EXE, script, str(empty_gd), "--checkpoint"])
        assert rc == 2, f"Expected exit 2, got {rc}"
        assert "ERROR:" in err

        # 5. Non-existent checkpoint -> exit 1
        rc, out, err = run_cmd([PYTHON_EXE, script, str(empty_gd), "--checkpoint", "nonexistent.json"])
        assert rc == 1, f"Expected exit 1, got {rc}"
        assert "ERROR:" in err

        # 6. Zero-byte checkpoint -> exit 1
        empty_cp = tmp_p / "empty_cp.json"
        empty_cp.write_text("", encoding="utf-8")
        rc, out, err = run_cmd([PYTHON_EXE, script, str(empty_gd), "--checkpoint", str(empty_cp)])
        assert rc == 1, f"Expected exit 1, got {rc}"
        assert "ERROR:" in err

        # 7. Corrupt checkpoint -> exit 1
        corrupt_cp = tmp_p / "corrupt_cp.json"
        corrupt_cp.write_text("{corrupt", encoding="utf-8")
        rc, out, err = run_cmd([PYTHON_EXE, script, str(empty_gd), "--checkpoint", str(corrupt_cp)])
        assert rc == 1, f"Expected exit 1, got {rc}"
        assert "ERROR:" in err

        # 8. Checkpoint cycle detection -> exit 42
        cycle_cp = tmp_p / "cycle_cp.json"
        cycle_cp.write_text(json.dumps({"semantic_hash_ring_buffer": ["e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"]}), encoding="utf-8")
        rc, out, err = run_cmd([PYTHON_EXE, script, str(empty_gd), "--checkpoint", str(cycle_cp)])
        assert rc == 42, f"Expected exit 42, got {rc}"
        assert "CRITICAL: Cyclical error oscillation detected!" in err

    print("  --> hash_ast.py: ALL 8 EDGE CASES PASSED")

def test_precommit_audit():
    print("[2/6] Testing precommit_audit.py edge cases...")
    script = str(ROOT_DIR / "04_AI_STUDIO" / "scripts" / "precommit_audit.py")

    # 1. Normal run (no payload) -> exit 0
    rc, out, err = run_cmd([PYTHON_EXE, script])
    assert rc == 0, f"Expected exit 0, got {rc}"
    assert "PRE-COMMIT GATE EVALUATION COMPLETE" in out

    wrap_dir = ROOT_DIR / ".wrap"
    wrap_dir.mkdir(exist_ok=True)
    payload_file = wrap_dir / "review_payload.json"
    try:
        # 2. Blocking defect -> exit 3
        payload_file.write_text(json.dumps({
            "findings": [{
                "id": "DEF-TEST-001",
                "severity": "Critical",
                "technical_certainty": 0.95,
                "evidence_verifiability": 0.90,
                "description": "Synthetic blocking defect"
            }]
        }), encoding="utf-8")
        rc, out, err = run_cmd([PYTHON_EXE, script])
        assert rc == 3, f"Expected exit 3, got {rc}"
        assert "PRE-COMMIT REJECTED" in err

        # 3. Non-blocking minor defect -> exit 0
        payload_file.write_text(json.dumps({
            "findings": [{
                "id": "DEF-TEST-002",
                "severity": "Minor",
                "technical_certainty": 0.85,
                "evidence_verifiability": 0.85,
                "description": "Synthetic advisory minor defect"
            }]
        }), encoding="utf-8")
        rc, out, err = run_cmd([PYTHON_EXE, script])
        assert rc == 0, f"Expected exit 0, got {rc}"
        assert "[ADVISORY MINOR]" in out

        # 4. Zero-byte payload file -> exit 0 (warning logged)
        payload_file.write_text("", encoding="utf-8")
        rc, out, err = run_cmd([PYTHON_EXE, script])
        assert rc == 0, f"Expected exit 0, got {rc}"
        assert "WARNING:" in err

        # 5. Corrupted payload file -> exit 3
        payload_file.write_text("{bad json", encoding="utf-8")
        rc, out, err = run_cmd([PYTHON_EXE, script])
        assert rc == 3, f"Expected exit 3, got {rc}"
        assert "ERROR: Corrupted review_payload.json" in err
    finally:
        if payload_file.exists():
            payload_file.unlink()
        if wrap_dir.exists():
            wrap_dir.rmdir()

    print("  --> precommit_audit.py: ALL 5 EDGE CASES PASSED")

def test_inspect_glb():
    print("[3/6] Testing inspect_glb.py edge cases...")
    script = str(ROOT_DIR / "07_ASSETS" / "scripts" / "inspect_glb.py")

    # 1. Synthetic test -> exit 0
    rc, out, err = run_cmd([PYTHON_EXE, script, "--test-synthetic"])
    assert rc == 0, f"Expected exit 0, got {rc}"

    # 2. Missing file -> exit 3
    rc, out, err = run_cmd([PYTHON_EXE, script, "nonexistent.glb"])
    assert rc == 3, f"Expected exit 3, got {rc}"
    assert "FATAL:" in err

    with tempfile.TemporaryDirectory() as tmp_dir:
        tmp_p = Path(tmp_dir)
        # 3. Zero-byte file -> exit 3
        zero_glb = tmp_p / "zero.glb"
        zero_glb.write_bytes(b"")
        rc, out, err = run_cmd([PYTHON_EXE, script, str(zero_glb)])
        assert rc == 3, f"Expected exit 3, got {rc}"
        assert "FATAL CORRUPTION:" in err

        # 4. Corrupted magic -> exit 3
        corrupt_glb = tmp_p / "corrupt.glb"
        corrupt_glb.write_bytes(b"NOT_GLTF_MAGIC_DATA")
        rc, out, err = run_cmd([PYTHON_EXE, script, str(corrupt_glb)])
        assert rc == 3, f"Expected exit 3, got {rc}"
        assert "FATAL CORRUPTION:" in err

        # 5. JSON output mode on corrupt file -> exit 3, valid json in stderr
        rc, out, err = run_cmd([PYTHON_EXE, script, str(corrupt_glb), "--json"])
        assert rc == 3, f"Expected exit 3, got {rc}"
        err_json = json.loads(err.strip())
        assert err_json.get("status") == "CORRUPT"

    print("  --> inspect_glb.py: ALL 5 EDGE CASES PASSED")

def test_generate_collision():
    print("[4/6] Testing generate_collision.py edge cases...")
    script = str(ROOT_DIR / "07_ASSETS" / "scripts" / "generate_collision.py")

    # 1. Synthetic test -> exit 0
    rc, out, err = run_cmd([PYTHON_EXE, script, "--test-synthetic"])
    assert rc == 0, f"Expected exit 0, got {rc}"

    # 2. Missing args -> exit 2
    rc, out, err = run_cmd([PYTHON_EXE, script])
    assert rc == 2, f"Expected exit 2, got {rc}"

    # 3. Missing file -> exit 1
    rc, out, err = run_cmd([PYTHON_EXE, script, "nonexistent.glb", "--out", "test.tscn"])
    assert rc == 1, f"Expected exit 1, got {rc}"
    assert "FATAL:" in err

    with tempfile.TemporaryDirectory() as tmp_dir:
        tmp_p = Path(tmp_dir)
        # 4. Zero-byte GLB -> exit 1
        zero_glb = tmp_p / "zero.glb"
        zero_glb.write_bytes(b"")
        out_tscn = tmp_p / "out.tscn"
        rc, out, err = run_cmd([PYTHON_EXE, script, str(zero_glb), "--out", str(out_tscn)])
        assert rc == 1, f"Expected exit 1, got {rc}"
        assert "FATAL:" in err

        # 5. Corrupt GLB -> exit 1
        corrupt_glb = tmp_p / "corrupt.glb"
        corrupt_glb.write_bytes(b"BAD_GLTF_BYTES_1234")
        rc, out, err = run_cmd([PYTHON_EXE, script, str(corrupt_glb), "--out", str(out_tscn)])
        assert rc == 1, f"Expected exit 1, got {rc}"
        assert "FATAL:" in err

    print("  --> generate_collision.py: ALL 5 EDGE CASES PASSED")

def test_pack_orm():
    print("[5/6] Testing pack_orm.py edge cases...")
    script = str(ROOT_DIR / "07_ASSETS" / "scripts" / "pack_orm.py")

    # 1. Synthetic test -> exit 0
    rc, out, err = run_cmd([PYTHON_EXE, script, "--test-synthetic"])
    assert rc == 0, f"Expected exit 0, got {rc}"

    # 2. Missing --out -> exit 2
    rc, out, err = run_cmd([PYTHON_EXE, script, "--ao", "something.png"])
    assert rc == 2, f"Expected exit 2, got {rc}"

    with tempfile.TemporaryDirectory() as tmp_dir:
        tmp_p = Path(tmp_dir)
        out_png = tmp_p / "out.png"

        # 3. Nonexistent input without --strict -> exit 0 (warning logged)
        rc, out, err = run_cmd([PYTHON_EXE, script, "--ao", "nonexistent.png", "--out", str(out_png)])
        assert rc == 0, f"Expected exit 0, got {rc}"
        assert "WARNING:" in err
        assert out_png.exists()
        out_png.unlink()

        # 4. Nonexistent input with --strict -> exit 1 (fatal logged)
        rc, out, err = run_cmd([PYTHON_EXE, script, "--ao", "nonexistent.png", "--out", str(out_png), "--strict"])
        assert rc == 1, f"Expected exit 1, got {rc}"
        assert "FATAL:" in err
        assert not out_png.exists()

        # 5. Zero-byte input without --strict -> exit 0 (warning logged)
        zero_img = tmp_p / "zero.png"
        zero_img.write_bytes(b"")
        rc, out, err = run_cmd([PYTHON_EXE, script, "--ao", str(zero_img), "--out", str(out_png)])
        assert rc == 0, f"Expected exit 0, got {rc}"
        assert "WARNING:" in err
        assert out_png.exists()
        out_png.unlink()

        # 6. Zero-byte input with --strict -> exit 1 (fatal logged)
        rc, out, err = run_cmd([PYTHON_EXE, script, "--ao", str(zero_img), "--out", str(out_png), "--strict"])
        assert rc == 1, f"Expected exit 1, got {rc}"
        assert "FATAL:" in err
        assert not out_png.exists()

    print("  --> pack_orm.py: ALL 6 EDGE CASES PASSED")

def test_renderer_probe():
    print("[6/6] Testing renderer_probe in Godot 4.7.2...")
    probe_dir = ROOT_DIR / "08_TESTING" / "renderer_probe"
    project_godot = probe_dir / "project.godot"

    # 1. Normal run -> exit 0
    rc, out, err = run_cmd([GODOT_EXE, "--headless", "--path", str(probe_dir)])
    assert rc == 0, f"Expected exit 0, got {rc}"
    assert "RENDERER_PROBE_SUCCESS" in out
    assert "Display Server: headless" in out
    assert "Configured Rendering Method: gl_compatibility" in out

    # 2. Invariant breach: bad rendering method -> exit 1
    orig_content = project_godot.read_text(encoding="utf-8")
    try:
        bad_method_content = orig_content.replace(
            'renderer/rendering_method="gl_compatibility"',
            'renderer/rendering_method="forward_plus"'
        )
        project_godot.write_text(bad_method_content, encoding="utf-8")
        rc, out, err = run_cmd([GODOT_EXE, "--headless", "--path", str(probe_dir)])
        assert rc == 1, f"Expected exit 1 on forward_plus breach, got {rc}"
        assert "RENDERER_PROBE_FAILURE" in err or "RENDERER_PROBE_FAILURE" in out

        # 3. Invariant breach: barred feature (SDFGI) -> exit 1
        sdfgi_content = orig_content + "\n[rendering]\nglobal_illumination/sdfgi/enabled=true\n"
        project_godot.write_text(sdfgi_content, encoding="utf-8")
        rc, out, err = run_cmd([GODOT_EXE, "--headless", "--path", str(probe_dir)])
        assert rc == 1, f"Expected exit 1 on SDFGI breach, got {rc}"
        assert "RENDERER_PROBE_FAILURE: Barred feature 'SDFGI'" in err or "RENDERER_PROBE_FAILURE: Barred feature 'SDFGI'" in out

    finally:
        project_godot.write_text(orig_content, encoding="utf-8")

    print("  --> renderer_probe: ALL 3 TESTS PASSED")

def main():
    print("==================================================================")
    print("PROJECT NULL — MASTER TEST DIAGNOSTICS & VERIFICATION SUITE")
    print("==================================================================")
    test_hash_ast()
    test_precommit_audit()
    test_inspect_glb()
    test_generate_collision()
    test_pack_orm()
    test_renderer_probe()
    print("==================================================================")
    print("ALL TEST DIAGNOSTICS SUITES PASSED CLEANLY (100% SUCCESS)")
    print("==================================================================")
    return 0

if __name__ == "__main__":
    sys.exit(main())
