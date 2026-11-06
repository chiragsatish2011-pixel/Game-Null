#!/usr/bin/env python3
"""
PROJECT NULL — Automated PBR ORM Texture Packing Pipeline
File: 07_ASSETS/scripts/pack_orm.py
Mandate: DEC-0002 (Blender-Free), DEC-0031 (Sampler Reduction)
"""

import sys
import os
import argparse
from PIL import Image

def load_and_prepare_channel(img_path: str, target_size: tuple, default_val: int, strict: bool = False) -> Image.Image:
    """
    Loads an image file, converts to 8-bit grayscale ('L'),
    resizes via Lanczos-3 resampling, or creates a solid fill if None.
    """
    if not img_path:
        return Image.new("L", target_size, color=default_val)
    
    if not os.path.isfile(img_path):
        if strict:
            print(f"FATAL: Specified image file not found: '{img_path}'.", file=sys.stderr)
            sys.exit(1)
        print(f"WARNING: Specified image file not found: '{img_path}'. Using fallback default {default_val}.", file=sys.stderr)
        return Image.new("L", target_size, color=default_val)
    
    try:
        with Image.open(img_path) as src:
            gray = src.convert("L")
            if gray.size != target_size:
                gray = gray.resize(target_size, Image.Resampling.LANCZOS)
            return gray
    except Exception as e:
        if strict:
            print(f"FATAL: Failed to read {img_path}: {e}.", file=sys.stderr)
            sys.exit(1)
        print(f"WARNING: Failed to read {img_path}: {e}. Using fallback default {default_val}.", file=sys.stderr)
        return Image.new("L", target_size, color=default_val)

def pack_orm_maps(ao_path: str, rough_path: str, metal_path: str, 
                  output_path: str, size: int = 512, invert_roughness: bool = False,
                  strict: bool = False):
    """
    Combines AO, Roughness, and Metallic maps into a unified 3-channel RGB texture.
    R = AO, G = Roughness, B = Metallic
    """
    target_size = (size, size)
    
    ao_img = load_and_prepare_channel(ao_path, target_size, default_val=255, strict=strict)
    rough_img = load_and_prepare_channel(rough_path, target_size, default_val=180, strict=strict)
    metal_img = load_and_prepare_channel(metal_path, target_size, default_val=0, strict=strict)

    if invert_roughness:
        from PIL import ImageOps
        rough_img = ImageOps.invert(rough_img)

    orm_img = Image.merge("RGB", (ao_img, rough_img, metal_img))
    
    try:
        out_dir = os.path.dirname(os.path.abspath(output_path))
        if out_dir and not os.path.exists(out_dir):
            os.makedirs(out_dir, exist_ok=True)

        ext = os.path.splitext(output_path)[1].lower()
        if ext in [".webp"]:
            # Lossless WebP is strictly required for PBR masks to avoid cross-channel ringing and metallic bit corruption
            orm_img.save(output_path, "WEBP", lossless=True, quality=100, method=6)
        else:
            orm_img.save(output_path, "PNG", optimize=True)
    except Exception as e:
        print(f"FATAL: Failed to write packed texture '{output_path}': {e}", file=sys.stderr)
        sys.exit(1)

    print(f"[ORM Packer] Successfully packed: {output_path} ({size}x{size} RGB)")

def main():
    parser = argparse.ArgumentParser(description="Pack AO, Roughness, and Metallic into single ORM map.")
    parser.add_argument("--ao", help="Path to Ambient Occlusion grayscale texture.")
    parser.add_argument("--rough", help="Path to Roughness grayscale texture.")
    parser.add_argument("--metal", help="Path to Metallic grayscale texture.")
    parser.add_argument("--out", help="Path for output packed texture (.png or .webp).")
    parser.add_argument("--size", type=int, choices=[256, 512, 1024], default=512, 
                        help="Target texture dimension (default: 512).")
    parser.add_argument("--invert-rough", action="store_true", 
                        help="Invert roughness (convert Smoothness/Glossiness to Roughness).")
    parser.add_argument("--strict", action="store_true",
                        help="Fail with exit code 1 if any specified input texture is missing or corrupt.")
    parser.add_argument("--test-synthetic", action="store_true",
                        help="Run end-to-end synthetic verification test and exit.")
    args = parser.parse_args()

    if args.test_synthetic:
        import tempfile
        try:
            with tempfile.TemporaryDirectory() as tmp_dir:
                # 1. Test fallback default packing (PNG)
                png_out = os.path.join(tmp_dir, "test_synthetic_orm.png")
                pack_orm_maps(
                    ao_path=None,
                    rough_path=None,
                    metal_path=None,
                    output_path=png_out,
                    size=256,
                    invert_roughness=False
                )
                assert os.path.isfile(png_out), "PNG output file was not created"
                with Image.open(png_out) as img:
                    assert img.size == (256, 256), f"Expected (256, 256), got {img.size}"
                    assert img.mode == "RGB", f"Expected RGB mode, got {img.mode}"
                    r, g, b = img.getpixel((0, 0))
                    assert r == 255, f"Expected default AO=255, got {r}"
                    assert g == 180, f"Expected default Roughness=180, got {g}"
                    assert b == 0, f"Expected default Metallic=0, got {b}"

                # 2. Test roughness inversion
                inv_out = os.path.join(tmp_dir, "test_synthetic_inv.png")
                pack_orm_maps(
                    ao_path=None,
                    rough_path=None,
                    metal_path=None,
                    output_path=inv_out,
                    size=256,
                    invert_roughness=True
                )
                with Image.open(inv_out) as img:
                    _, g_inv, _ = img.getpixel((0, 0))
                    # Inverted 180 should be 255 - 180 = 75
                    assert g_inv == 75, f"Expected inverted roughness 75, got {g_inv}"

                # 3. Test WebP format packing
                webp_out = os.path.join(tmp_dir, "test_synthetic_orm.webp")
                pack_orm_maps(
                    ao_path=None,
                    rough_path=None,
                    metal_path=None,
                    output_path=webp_out,
                    size=256,
                    invert_roughness=False
                )
                assert os.path.isfile(webp_out), "WebP output file was not created"
                with Image.open(webp_out) as img:
                    assert img.size == (256, 256)
                    assert img.mode == "RGB"

            print("ALL SYNTHETIC TESTS PASSED: ORM texture pack verified (PNG, Inversion, WebP, isolated tempdir).")
            sys.exit(0)
        except Exception as e:
            print(f"SYNTHETIC TEST FAILED: {e}", file=sys.stderr)
            sys.exit(1)

    if not args.out:
        parser.error("the following arguments are required: --out")

    pack_orm_maps(
        ao_path=args.ao,
        rough_path=args.rough,
        metal_path=args.metal,
        output_path=args.out,
        size=args.size,
        invert_roughness=args.invert_rough,
        strict=args.strict
    )

if __name__ == "__main__":
    main()
