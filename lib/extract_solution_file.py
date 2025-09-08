#!/usr/bin/env python3
"""
Extract solution_file configuration from project.toml files.
TOML 1.0 compliant parser that extracts the solution_file value
from the com.heroku.buildpacks.dotnet section.
"""

import sys
from pathlib import Path

# Handle Python 3.10 (heroku-22) vs 3.11+ (heroku-24)
try:
    import tomllib
except ImportError:
    # Python < 3.11, use tomli package
    import tomli as tomllib


def parse_solution_file(toml_path):
    """
    Parse project.toml and extract solution_file from com.heroku.buildpacks.dotnet section.

    Args:
        toml_path: Path to the project.toml file

    Returns:
        The solution_file value if found, None otherwise
    """
    try:
        # Both tomllib and tomli expect binary mode
        with open(toml_path, 'rb') as f:
            data = tomllib.load(f)

        # Navigate to com.heroku.buildpacks.dotnet section
        dotnet_config = data.get('com', {}).get('heroku', {}).get('buildpacks', {}).get('dotnet', {})

        # Get solution_file value
        solution_file = dotnet_config.get('solution_file')

        return solution_file

    except (FileNotFoundError, KeyError):
        return None
    except Exception:
        # Handle both tomllib.TOMLDecodeError and tomli parsing errors
        return None


def main():
    if len(sys.argv) != 2:
        print("Usage: extract_solution_file.py <path_to_project.toml>", file=sys.stderr)
        sys.exit(1)

    toml_path = sys.argv[1]

    if not Path(toml_path).exists():
        sys.exit(1)

    solution_file = parse_solution_file(toml_path)

    if solution_file:
        print(solution_file)
        sys.exit(0)
    else:
        sys.exit(1)


if __name__ == "__main__":
    main()
