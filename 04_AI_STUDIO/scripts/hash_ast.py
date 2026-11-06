#!/usr/bin/env python3
"""
PROJECT NULL — Autonomous AI Studio Tooling
Module: QA & Verification / Semantic AST Hasher
File: 04_AI_STUDIO/scripts/hash_ast.py
Description: Computes invariant semantic SHA-256 hashes of GDScript files by
             stripping comments, ISO-8601 timestamps, and normalizing whitespace.
             Detects cyclical oscillation in autonomous Wrap-Loop recovery cycles.
Governing Defect: DEF-C7-005
"""

import sys
import re
import hashlib
import json
from pathlib import Path
from typing import List, Tuple, Dict, Any


# Regex patterns for invariant stripping
RE_SINGLE_LINE_COMMENT = re.compile(r'#.*$', re.MULTILINE)
RE_DOCSTRING_COMMENT = re.compile(r'##.*$', re.MULTILINE)
RE_ISO_TIMESTAMP = re.compile(r'\b\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(?:\.\d+)?(?:Z|[+-]\d{2}:\d{2})?\b')
RE_DATE_STRINGS = re.compile(r'\b(?:Monday|Tuesday|Wednesday|Thursday|Friday|Saturday|Sunday)?,?\s*(?:January|February|March|April|May|June|July|August|September|October|November|December)\s+\d{1,2},\s+\d{4}\b', re.IGNORECASE)
RE_MULTIPLE_WHITESPACE = re.compile(r'[ \t]+')
RE_EMPTY_LINES = re.compile(r'\n\s*\n')


def normalize_gdscript(source_code: str) -> str:
    """Normalizes GDScript source code to invariant semantic tokens."""
    # 1. Strip docstrings and single-line comments
    text = RE_DOCSTRING_COMMENT.sub('', source_code)
    text = RE_SINGLE_LINE_COMMENT.sub('', text)

    # 2. Strip dynamic timestamps and dates
    text = RE_ISO_TIMESTAMP.sub('__ISO_TIMESTAMP__', text)
    text = RE_DATE_STRINGS.sub('__DATE_STRING__', text)

    # 3. Normalize whitespace
    lines = []
    for line in text.splitlines():
        trimmed = line.strip()
        if trimmed:
            # Preserve structural indentation as single tabs
            leading_spaces = len(line) - len(line.lstrip())
            indent_level = leading_spaces // 4 if '\t' not in line else line.count('\t')
            normalized_line = ('\t' * indent_level) + RE_MULTIPLE_WHITESPACE.sub(' ', trimmed)
            lines.append(normalized_line)

    return '\n'.join(lines)


def compute_semantic_hash(file_path: Path) -> str:
    """Computes SHA-256 hash of normalized GDScript content."""
    if not file_path.exists():
        raise FileNotFoundError(f"Source file not found: {file_path}")

    raw_content = file_path.read_text(encoding='utf-8', errors='replace')
    normalized_content = normalize_gdscript(raw_content)
    
    sha256 = hashlib.sha256()
    sha256.update(normalized_content.encode('utf-8'))
    return sha256.hexdigest()


def check_oscillation_ring_buffer(new_hash: str, history: List[str]) -> Tuple[bool, int]:
    """
    Checks if new_hash matches a prior state in the history ring buffer.
    Detects ping-pong cycles where state(n) == state(n-2).
    """
    for index, prior_hash in enumerate(reversed(history)):
        distance = index + 1
        if new_hash == prior_hash:
            return True, distance
    return False, 0


def main() -> int:
    if len(sys.argv) < 2:
        print("Usage: python hash_ast.py <target_file.gd> [--checkpoint <checkpoint.json>]", file=sys.stderr)
        return 2

    target_file = Path(sys.argv[1])
    try:
        sem_hash = compute_semantic_hash(target_file)
    except Exception as e:
        print(f"ERROR: Failed to compute semantic hash: {e}", file=sys.stderr)
        return 1

    print(f"FILE: {target_file}")
    print(f"SEMANTIC_HASH: {sem_hash}")

    # Checkpoint ring-buffer integration
    if "--checkpoint" in sys.argv:
        cp_idx = sys.argv.index("--checkpoint") + 1
        if cp_idx >= len(sys.argv):
            print("ERROR: --checkpoint specified without checkpoint file path.", file=sys.stderr)
            return 2
        cp_path = Path(sys.argv[cp_idx])
        if not cp_path.exists():
            print(f"ERROR: Checkpoint file not found: {cp_path}", file=sys.stderr)
            return 1
        try:
            content = cp_path.read_text(encoding='utf-8')
            if not content.strip():
                print(f"ERROR: Checkpoint file is empty: {cp_path}", file=sys.stderr)
                return 1
            cp_data = json.loads(content)
        except json.JSONDecodeError as e:
            print(f"ERROR: Corrupted checkpoint JSON: {e}", file=sys.stderr)
            return 1
        except Exception as e:
            print(f"ERROR: Failed to read checkpoint: {e}", file=sys.stderr)
            return 1

        history = cp_data.get("semantic_hash_ring_buffer", [])
        is_cyclical, distance = check_oscillation_ring_buffer(sem_hash, history)
        if is_cyclical:
            print(f"CRITICAL: Cyclical error oscillation detected! Hash matches state {distance} cycles ago.", file=sys.stderr)
            return 42 # Specific exit code for oscillation detection

    return 0


if __name__ == "__main__":
    sys.exit(main())
