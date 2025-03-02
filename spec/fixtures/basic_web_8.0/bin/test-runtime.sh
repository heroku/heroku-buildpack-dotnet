#!/usr/bin/env bash

set -euo pipefail

# Check that all dynamically linked libraries exist in the run image
INSTALL_DIR="$(command -v dotnet)"
ldd_output=$(find "$(dirname "${INSTALL_DIR}")" -type f,l \( -name 'dotnet' -o -name '*.so*' \) -exec ldd '{}' +)
if grep 'not found' <<<"${ldd_output}" | sort --unique; then
	echo "The above dynamically linked libraries were not found!"
	exit 1
else
	echo "All dynamically linked libraries were found."
fi
