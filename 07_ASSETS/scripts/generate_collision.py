#!/usr/bin/env python3
"""
PROJECT NULL — Procedural Collision & Godot .tscn Scene Generator
File: 07_ASSETS/scripts/generate_collision.py
Mandate: DEC-0002 (Blender-Free), Non-Interactive Engine Integration
"""

import sys
import os
import argparse
from typing import Tuple, List

from inspect_glb import parse_glb_header, parse_glb_chunks, audit_geometry, generate_synthetic_glb

def determine_collider_shape(dimensions: List[float],
                             min_bound: List[float] = None,
                             max_bound: List[float] = None) -> Tuple[str, List[float], List[float]]:
    """
    Analyzes bounding extents [dx, dy, dz] and optional [min_bound], [max_bound].
    Returns (shape_type, shape_params, center_offset).
    """
    if len(dimensions) < 3 or max(dimensions) <= 0:
        raise ValueError(f"Invalid bounding dimensions: {dimensions}. Dimensions must have non-zero extents.")

    # Clamp zero or near-zero thin dimensions (e.g. flat planes, posters) to minimum collision thickness (0.01m)
    dx = round(max(dimensions[0], 0.01), 4)
    dy = round(max(dimensions[1], 0.01), 4)
    dz = round(max(dimensions[2], 0.01), 4)
    
    if min_bound and max_bound and len(min_bound) >= 3 and len(max_bound) >= 3:
        center_x = round((min_bound[0] + max_bound[0]) / 2.0, 4)
        center_y = round((min_bound[1] + max_bound[1]) / 2.0, 4)
        center_z = round((min_bound[2] + max_bound[2]) / 2.0, 4)
        center_offset = [center_x, center_y, center_z]
    else:
        center_offset = [0.0, round(dy / 2.0, 4), 0.0]

    max_xz = max(dx, dz)
    delta_xz = abs(dx - dz) / max_xz if max_xz > 0 else 0
    
    # If roughly circular cross-section, choose CylinderShape3D
    if delta_xz <= 0.18 and dy > 0.1:
        radius = round((dx + dz) / 4.0, 4)
        height = round(dy, 4)
        return "CylinderShape3D", [height, radius], center_offset
    
    # Default to BoxShape3D
    return "BoxShape3D", [round(dx, 4), round(dy, 4), round(dz, 4)], center_offset

def generate_tscn_scene(glb_rel_path: str, tscn_out_path: str, 
                        shape_type: str, shape_params: List[float], 
                        center_offset: List[float], node_name: str):
    """
    Generates a valid Godot 4.7.2 text scene (.tscn) file.
    """
    tscn_content = []
    tscn_content.append('[gd_scene load_steps=3 format=3 uid="uid://' + os.urandom(6).hex() + '"]')
    tscn_content.append(f'\n[ext_resource type="PackedScene" path="{glb_rel_path}" id="1_mesh"]')
    
    if shape_type == "CylinderShape3D":
        tscn_content.append('\n[sub_resource type="CylinderShape3D" id="SubResource_col"]')
        tscn_content.append(f'height = {shape_params[0]}')
        tscn_content.append(f'radius = {shape_params[1]}')
    else:
        tscn_content.append('\n[sub_resource type="BoxShape3D" id="SubResource_col"]')
        tscn_content.append(f'size = Vector3({shape_params[0]}, {shape_params[1]}, {shape_params[2]})')

    tscn_content.append(f'\n[node name="{node_name}" type="StaticBody3D"]')
    tscn_content.append('collision_layer = 3') # Layer 1 (World) + Layer 2 (Interactable Clue)
    tscn_content.append('collision_mask = 1')

    tscn_content.append('\n[node name="CollisionShape3D" type="CollisionShape3D" parent="."]')
    tscn_content.append(f'transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, {center_offset[0]}, {center_offset[1]}, {center_offset[2]})')
    tscn_content.append('shape = SubResource("SubResource_col")')

    tscn_content.append('\n[node name="ModelInstance" parent="." instance=ExtResource("1_mesh")]')

    out_dir = os.path.dirname(os.path.abspath(tscn_out_path))
    if out_dir and not os.path.exists(out_dir):
        os.makedirs(out_dir, exist_ok=True)
        
    with open(tscn_out_path, "w", encoding="utf-8") as f:
        f.write("\n".join(tscn_content) + "\n")
        
    print(f"[TSCN Generator] Created Godot scene: {tscn_out_path} ({shape_type})")

def main():
    parser = argparse.ArgumentParser(description="Generate Godot 4 .tscn with procedural collision from GLB.")
    parser.add_argument("glb_path", nargs="?", default=None, help="Path to inspected .glb file.")
    parser.add_argument("--out", help="Path for destination .tscn file.")
    parser.add_argument("--res-prefix", default="res://assets/props/", 
                        help="Godot project resource prefix for the GLB (e.g. res://assets/props/).")
    parser.add_argument("--overwrite", action="store_true",
                        help="Allow overwriting existing destination scene.")
    parser.add_argument("--test-synthetic", action="store_true",
                        help="Run end-to-end synthetic verification test and exit.")
    args = parser.parse_args()

    if args.test_synthetic:
        import tempfile
        try:
            with tempfile.TemporaryDirectory() as tmp_dir:
                # 1. Test BoxShape3D generation from synthetic GLB
                temp_glb = os.path.join(tmp_dir, "temp_test_synthetic.glb")
                temp_box_tscn = os.path.join(tmp_dir, "temp_box_synthetic.tscn")
                
                glb_data = generate_synthetic_glb()
                with open(temp_glb, "wb") as f:
                    f.write(glb_data)
                with open(temp_glb, "rb") as f:
                    parse_glb_header(f)
                    json_data, _ = parse_glb_chunks(f)
                    metrics = audit_geometry(json_data)
                
                dims = metrics["dimensions"]
                min_b = metrics.get("bounding_box_min")
                max_b = metrics.get("bounding_box_max")
                shape_type, shape_params, offset = determine_collider_shape(dims, min_b, max_b)
                assert shape_type == "BoxShape3D", f"Expected BoxShape3D, got {shape_type}"
                
                generate_tscn_scene(
                    glb_rel_path="res://assets/props/test_box.glb",
                    tscn_out_path=temp_box_tscn,
                    shape_type=shape_type,
                    shape_params=shape_params,
                    center_offset=offset,
                    node_name="test_box"
                )
                assert os.path.isfile(temp_box_tscn), "Box .tscn was not created"
                with open(temp_box_tscn, "r", encoding="utf-8") as f:
                    content = f.read()
                    assert '[gd_scene load_steps=3 format=3' in content
                    assert 'type="StaticBody3D"' in content
                    assert 'collision_layer = 3' in content
                    assert 'type="BoxShape3D"' in content
                    assert 'node name="ModelInstance"' in content

                # 2. Test CylinderShape3D branch with cylindrical dimensions
                cyl_dims = [0.8, 2.4, 0.8]
                cyl_shape, cyl_params, cyl_offset = determine_collider_shape(cyl_dims)
                assert cyl_shape == "CylinderShape3D", f"Expected CylinderShape3D, got {cyl_shape}"
                assert cyl_params == [2.4, 0.4], f"Expected [2.4, 0.4], got {cyl_params}"
                
                temp_cyl_tscn = os.path.join(tmp_dir, "temp_cyl_synthetic.tscn")
                generate_tscn_scene(
                    glb_rel_path="res://assets/props/test_cyl.glb",
                    tscn_out_path=temp_cyl_tscn,
                    shape_type=cyl_shape,
                    shape_params=cyl_params,
                    center_offset=cyl_offset,
                    node_name="test_cyl"
                )
                assert os.path.isfile(temp_cyl_tscn), "Cylinder .tscn was not created"
                with open(temp_cyl_tscn, "r", encoding="utf-8") as f:
                    cyl_content = f.read()
                    assert 'type="CylinderShape3D"' in cyl_content
                    assert 'height = 2.4' in cyl_content
                    assert 'radius = 0.4' in cyl_content

            print("ALL SYNTHETIC TESTS PASSED: Procedural collision and .tscn generation verified (Box + Cylinder, isolated tempdir).")
            sys.exit(0)
        except Exception as e:
            print(f"SYNTHETIC TEST FAILED: {e}", file=sys.stderr)
            sys.exit(1)

    if not args.glb_path or not args.out:
        parser.error("glb_path and --out are required unless --test-synthetic is used.")

    if not os.path.isfile(args.glb_path):
        print(f"FATAL: GLB file not found: {args.glb_path}", file=sys.stderr)
        sys.exit(1)

    if os.path.exists(args.out) and not args.overwrite:
        print(f"FATAL: Destination file already exists: {args.out}. Use --overwrite to replace.", file=sys.stderr)
        sys.exit(1)

    try:
        with open(args.glb_path, "rb") as f:
            parse_glb_header(f)
            json_data, _ = parse_glb_chunks(f)
            metrics = audit_geometry(json_data)
    except Exception as e:
        print(f"FATAL: Corrupt or invalid GLB file '{args.glb_path}': {e}", file=sys.stderr)
        sys.exit(1)

    dims = metrics.get("dimensions", [0.0, 0.0, 0.0])
    total_verts = metrics.get("total_vertices", 0)
    total_tris = metrics.get("total_triangles", 0)
    if not dims or len(dims) < 3 or max(dims) <= 0 or total_verts == 0 or total_tris == 0:
        print(f"FATAL: Mesh geometry contains invalid or zero dimensions/vertices/triangles: dims={dims}, verts={total_verts}, tris={total_tris}", file=sys.stderr)
        sys.exit(1)

    min_b = metrics.get("bounding_box_min")
    max_b = metrics.get("bounding_box_max")
    shape_type, shape_params, offset = determine_collider_shape(dims, min_b, max_b)
    
    glb_filename = os.path.basename(args.glb_path)
    godot_res_path = os.path.join(args.res_prefix, glb_filename).replace("\\", "/")
    raw_node_name = os.path.splitext(glb_filename)[0]
    import re
    node_name = re.sub(r'[^a-zA-Z0-9_]', '_', raw_node_name)
    if not node_name or node_name[0].isdigit():
        node_name = f"Prop_{node_name}"

    generate_tscn_scene(
        glb_rel_path=godot_res_path,
        tscn_out_path=args.out,
        shape_type=shape_type,
        shape_params=shape_params,
        center_offset=offset,
        node_name=node_name
    )

if __name__ == "__main__":
    main()
