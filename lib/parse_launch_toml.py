#!/usr/bin/env python3
"""
Parse CNB launch.toml files for buildpack scripts.

Supports two output formats:
- --yaml: YAML for bin/release
- --process <type>: Command for a single process type (e.g., as used in `bin/test`)
"""

import sys
import shlex
from pathlib import Path

# `tomli`/`tomllib` compatibility layer: Use `tomllib` if available in the
# standard library (Python 3.11+), and fallback to `tomli` (available in
# `heroku/heroku:22-build`) when the standard library module is not available.
# See https://github.com/hukkin/tomli#building-a-tomlitomllib-compatibility-layer
if sys.version_info >= (3, 11):
    import tomllib
else:
    import tomli as tomllib


def parse_processes(toml_path):
    """Parse launch.toml and return process type -> command mapping."""
    try:
        with open(toml_path, "rb") as f:
            data = tomllib.load(f)
    except (FileNotFoundError, tomllib.TOMLDecodeError):
        return {}

    processes = {}
    for proc in data.get("processes", []):
        proc_type = proc.get("type")
        command_list = proc.get("command")

        if not proc_type or not isinstance(command_list, list):
            continue

        # Extract script content from bash -c commands, otherwise join with escaping
        if len(command_list) >= 3 and command_list[:2] == ["bash", "-c"]:
            processes[proc_type] = command_list[2]
        else:
            processes[proc_type] = shlex.join(command_list)

    return processes


def main():
    if len(sys.argv) not in [3, 4]:
        print(
            "Usage: parse_launch_toml.py <launch.toml> [--yaml|--process <type>]",
            file=sys.stderr,
        )
        sys.exit(1)

    toml_path, mode = sys.argv[1], sys.argv[2]

    if not Path(toml_path).exists():
        sys.exit(1)

    processes = parse_processes(toml_path)

    if mode == "--yaml":
        if processes:
            print("---\ndefault_process_types:")
            for proc_type, command in processes.items():
                print(f"  {proc_type}: {command}")

    elif mode == "--process" and len(sys.argv) == 4:
        command = processes.get(sys.argv[3])
        if command:
            print(command)
        else:
            sys.exit(1)

    else:
        print(
            "Usage: parse_launch_toml.py <launch.toml> [--yaml|--process <type>]",
            file=sys.stderr,
        )
        sys.exit(1)


if __name__ == "__main__":
    main()
