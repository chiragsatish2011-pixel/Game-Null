#!/usr/bin/env python3
"""
PROJECT NULL — Automated Binary GLB Inspection Engine
File: 07_ASSETS/scripts/inspect_glb.py
Mandate: DEC-0002 (Blender-Free), DEC-0031 (Budget & Material Gating)
"""

import sys
import os
import struct
import json
import argparse
from typing import Dict, Any, Tuple, List

# glTF Component Type Constants
GLTF_COMPONENT_TYPES = {
    5120: ("BYTE", 1),
    5121: ("UNSIGNED_BYTE", 1),
    5122: ("SHORT", 2),
    5123: ("UNSIGNED_SHORT", 2),
    5125: ("UNSIGNED_INT", 4),
    5126: ("FLOAT", 4)
}

def parse_glb_header(f) -> Tuple[int, int]:
    """Reads 12-byte GLB header. Returns (version, length)."""
    header_bytes = f.read(12)
    if len(header_bytes) < 12:
        raise ValueError("Corrupt file: Header smaller than 12 bytes.")
    
    magic, version, length = struct.unpack("<4sII", header_bytes)
    if magic != b"glTF":
        raise ValueError(f"Invalid magic identifier: {magic}. Expected b'glTF'.")
    if version != 2:
        raise ValueError(f"Unsupported glTF version: {version}. Expected version 2.")
    return version, length

def parse_glb_chunks(f) -> Tuple[Dict[str, Any], int]:
    """Extracts Chunk 0 (JSON) metadata. Returns (json_dict, bin_chunk_length)."""
    chunk0_hdr = f.read(8)
    if len(chunk0_hdr) < 8:
        raise ValueError("Corrupt file: Chunk 0 header missing.")
    
    chunk0_len, chunk0_type = struct.unpack("<II", chunk0_hdr)
    if chunk0_type != 0x4E4F534A: # 'JSON' in ASCII
        raise ValueError("Chunk 0 is not JSON type.")
    
    json_bytes = f.read(chunk0_len)
    json_data = json.loads(json_bytes.decode("utf-8"))
    
    bin_len = 0
    chunk1_hdr = f.read(8)
    if len(chunk1_hdr) == 8:
        c1_len, c1_type = struct.unpack("<II", chunk1_hdr)
        if c1_type == 0x004E4942: # 'BIN\0'
            bin_len = c1_len
            
    return json_data, bin_len

def audit_geometry(json_data: Dict[str, Any]) -> Dict[str, Any]:
    """Calculates total triangles, vertices, materials, and bounding box."""
    accessors = json_data.get("accessors", [])
    meshes = json_data.get("meshes", [])
    materials = json_data.get("materials", [])
    textures = json_data.get("textures", [])
    
    total_triangles = 0
    total_vertices = 0
    min_bound = [float('inf'), float('inf'), float('inf')]
    max_bound = [float('-inf'), float('-inf'), float('-inf')]

    for mesh_idx, mesh in enumerate(meshes):
        for prim_idx, prim in enumerate(mesh.get("primitives", [])):
            if "indices" in prim:
                idx_accessor_id = prim["indices"]
                if idx_accessor_id < len(accessors):
                    acc = accessors[idx_accessor_id]
                    count = acc.get("count", 0)
                    total_triangles += count // 3
            elif "attributes" in prim and "POSITION" in prim["attributes"]:
                pos_accessor_id = prim["attributes"]["POSITION"]
                if pos_accessor_id < len(accessors):
                    acc = accessors[pos_accessor_id]
                    count = acc.get("count", 0)
                    total_triangles += count // 3
            
            if "attributes" in prim and "POSITION" in prim["attributes"]:
                pos_accessor_id = prim["attributes"]["POSITION"]
                if pos_accessor_id < len(accessors):
                    acc = accessors[pos_accessor_id]
                    total_vertices += acc.get("count", 0)
                    p_min = acc.get("min", [])
                    p_max = acc.get("max", [])
                    if len(p_min) == 3 and len(p_max) == 3:
                        for i in range(3):
                            min_bound[i] = min(min_bound[i], p_min[i])
                            max_bound[i] = max(max_bound[i], p_max[i])

    dimensions = [0.0, 0.0, 0.0]
    if min_bound[0] != float('inf'):
        dimensions = [round(max_bound[i] - min_bound[i], 4) for i in range(3)]
        min_bound = [round(min_bound[i], 4) for i in range(3)]
        max_bound = [round(max_bound[i], 4) for i in range(3)]
    else:
        min_bound = [0.0, 0.0, 0.0]
        max_bound = [0.0, 0.0, 0.0]

    return {
        "mesh_count": len(meshes),
        "material_count": len(materials),
        "texture_count": len(textures),
        "total_triangles": total_triangles,
        "total_vertices": total_vertices,
        "dimensions": dimensions,
        "bounding_box_min": min_bound,
        "bounding_box_max": max_bound
    }

import io

def generate_synthetic_glb() -> bytes:
    """Generates a valid binary GLB buffer representing 1 triangle for synthetic testing."""
    vertices = struct.pack("<9f", 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0, 0.0)
    indices = struct.pack("<3HH", 0, 1, 2, 0)
    bin_data = vertices + indices

    json_dict = {
        "asset": {"version": "2.0", "generator": "ProjectNULL_SyntheticTest"},
        "scenes": [{"nodes": [0]}],
        "nodes": [{"mesh": 0}],
        "meshes": [{
            "primitives": [{
                "attributes": {"POSITION": 0},
                "indices": 1,
                "material": 0,
                "mode": 4
            }]
        }],
        "materials": [{"name": "SyntheticMaterial"}],
        "accessors": [
            {
                "bufferView": 0,
                "byteOffset": 0,
                "componentType": 5126,
                "count": 3,
                "type": "VEC3",
                "max": [1.0, 1.0, 0.0],
                "min": [0.0, 0.0, 0.0]
            },
            {
                "bufferView": 1,
                "byteOffset": 0,
                "componentType": 5123,
                "count": 3,
                "type": "SCALAR",
                "max": [2],
                "min": [0]
            }
        ],
        "bufferViews": [
            {"buffer": 0, "byteOffset": 0, "byteLength": 36, "target": 34962},
            {"buffer": 0, "byteOffset": 36, "byteLength": 6, "target": 34963}
        ],
        "buffers": [{"byteLength": len(bin_data)}]
    }

    json_bytes = json.dumps(json_dict).encode("utf-8")
    json_padding = (4 - (len(json_bytes) % 4)) % 4
    json_bytes += b" " * json_padding
    chunk0_len = len(json_bytes)

    bin_padding = (4 - (len(bin_data) % 4)) % 4
    bin_data += b"\x00" * bin_padding
    chunk1_len = len(bin_data)

    total_len = 12 + (8 + chunk0_len) + (8 + chunk1_len)

    header = struct.pack("<4sII", b"glTF", 2, total_len)
    chunk0_hdr = struct.pack("<II", chunk0_len, 0x4E4F534A)
    chunk1_hdr = struct.pack("<II", chunk1_len, 0x004E4942)

    return header + chunk0_hdr + json_bytes + chunk1_hdr + bin_data

def main():
    parser = argparse.ArgumentParser(description="Audit GLB polygon and material budgets without Blender.")
    parser.add_argument("glb_path", nargs="?", default=None, help="Path to binary .glb file.")
    parser.add_argument("--test-synthetic", action="store_true", help="Run automated synthetic test with generated GLB payload.")
    parser.add_argument("--category", choices=["hero", "ordinary", "modular", "clutter", "character"], 
                        default="ordinary", help="Target prop category.")
    parser.add_argument("--max-tris", type=int, default=None, help="Override triangle ceiling.")
    parser.add_argument("--max-materials", type=int, default=1, help="Max allowed material slots (default: 1).")
    parser.add_argument("--json", action="store_true", help="Output audit report strictly as JSON.")
    args = parser.parse_args()

    # Synthetic Test Execution Path
    if args.test_synthetic:
        try:
            # 1. Positive Test: Parse valid synthetic GLB
            raw_glb = generate_synthetic_glb()
            f = io.BytesIO(raw_glb)
            version, file_length = parse_glb_header(f)
            assert version == 2, f"Expected glTF version 2, got {version}"
            assert file_length == len(raw_glb), f"Header length {file_length} != buffer length {len(raw_glb)}"
            
            json_data, bin_length = parse_glb_chunks(f)
            metrics = audit_geometry(json_data)
            assert metrics["total_triangles"] == 1, f"Expected 1 triangle, got {metrics['total_triangles']}"
            assert metrics["material_count"] == 1, f"Expected 1 material, got {metrics['material_count']}"
            assert metrics["mesh_count"] == 1, f"Expected 1 mesh, got {metrics['mesh_count']}"
            
            # 2. Negative Test: Corrupt magic identifier
            bad_magic_bytes = b"NOPE" + raw_glb[4:12]
            f_bad_magic = io.BytesIO(bad_magic_bytes)
            try:
                parse_glb_header(f_bad_magic)
                assert False, "Failed to reject invalid magic identifier"
            except ValueError as ve:
                assert "Invalid magic identifier" in str(ve)

            # 3. Negative Test: Truncated header (< 12 bytes)
            f_truncated = io.BytesIO(b"glTF\x02\x00")
            try:
                parse_glb_header(f_truncated)
                assert False, "Failed to reject truncated header"
            except ValueError as ve:
                assert "Header smaller than 12 bytes" in str(ve)

            # 4. Negative Test: Corrupt Chunk 0 type (not JSON)
            bad_chunk_glb = raw_glb[:12] + struct.pack("<II", 10, 0x12345678) + raw_glb[20:]
            f_bad_chunk = io.BytesIO(bad_chunk_glb)
            f_bad_chunk.seek(12)
            try:
                parse_glb_chunks(f_bad_chunk)
                assert False, "Failed to reject non-JSON chunk 0"
            except ValueError as ve:
                assert "Chunk 0 is not JSON type" in str(ve)

            print("ALL SYNTHETIC TESTS PASSED: GLB parser verified (Positive + Negative corruption checks, in-memory isolation).")
            sys.exit(0)
        except Exception as e:
            print(f"SYNTHETIC TEST FAILED: {e}", file=sys.stderr)
            sys.exit(1)

    if not args.glb_path:
        parser.error("glb_path is required unless --test-synthetic is specified.")

    CATEGORY_BUDGETS = {
        "hero": 2750,
        "ordinary": 1000,
        "modular": 500,
        "clutter": 350,
        "character": 5500
    }
    
    limit_tris = args.max_tris if args.max_tris is not None else CATEGORY_BUDGETS[args.category]

    if not os.path.isfile(args.glb_path):
        err = {"status": "ERROR", "message": f"File not found: {args.glb_path}"}
        print(json.dumps(err) if args.json else f"FATAL: {err['message']}", file=sys.stderr)
        sys.exit(3)

    try:
        with open(args.glb_path, "rb") as f:
            version, file_length = parse_glb_header(f)
            json_data, bin_length = parse_glb_chunks(f)
            metrics = audit_geometry(json_data)
    except Exception as e:
        err = {"status": "CORRUPT", "message": str(e)}
        print(json.dumps(err) if args.json else f"FATAL CORRUPTION: {str(e)}", file=sys.stderr)
        sys.exit(3)

    failures: List[str] = []
    if metrics["total_triangles"] > limit_tris:
        failures.append(f"Triangle budget breached: {metrics['total_triangles']} > {limit_tris}")
    if metrics["material_count"] > args.max_materials:
        failures.append(f"Material slot count breached: {metrics['material_count']} > {args.max_materials}")
    if metrics["total_triangles"] == 0:
        failures.append("Degenerate model: 0 triangles extracted")

    report = {
        "file": os.path.abspath(args.glb_path),
        "file_size_bytes": file_length,
        "category": args.category,
        "limits": {"max_triangles": limit_tris, "max_materials": args.max_materials},
        "metrics": metrics,
        "status": "FAIL" if failures else "PASS",
        "violations": failures
    }

    if args.json:
        print(json.dumps(report, indent=2))
    else:
        print("=" * 60)
        print(f"GLB AUDIT REPORT: {os.path.basename(args.glb_path)}")
        print(f"Status:      {report['status']}")
        print(f"Triangles:   {metrics['total_triangles']} / {limit_tris} (Budget)")
        print(f"Vertices:    {metrics['total_vertices']}")
        print(f"Materials:   {metrics['material_count']} / {args.max_materials} (Budget)")
        print(f"Dimensions:  X={metrics['dimensions'][0]}m, Y={metrics['dimensions'][1]}m, Z={metrics['dimensions'][2]}m")
        if failures:
            print("\nVIOLATIONS:")
            for v in failures:
                print(f"  [X] {v}")
        print("=" * 60)

    if failures:
        if any("Triangle" in f for f in failures):
            sys.exit(1)
        if any("Material" in f for f in failures):
            sys.exit(2)
        sys.exit(1)
    
    sys.exit(0)

if __name__ == "__main__":
    main()
