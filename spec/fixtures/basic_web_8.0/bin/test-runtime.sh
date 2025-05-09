#!/usr/bin/env bash

set -euo pipefail

# Check that all required dynamically linked libraries can be found in the run image.

# Capture `ldd` output for `dotnet` executables and `*.so*` shared libraries in the `dotnet` install directory.
INSTALL_DIR="$(command -v dotnet)"
ldd_output=$(find "$(dirname "${INSTALL_DIR}")" -type f,l \( -name 'dotnet' -o -name '*.so*' \) -exec ldd '{}' +)

# Check for missing libraries.
# An exception is made for `liblttng-ust.so.0`, which is filtered out as it is considered
# non-critical, and expected to be missing in some environments.
# For more info, see: https://github.com/heroku/base-images/pull/346#issuecomment-2715075259
if grep 'not found' <<<"${ldd_output}" | grep -v 'liblttng-ust.so.0' | sort --unique; then
	echo "The above dynamically linked libraries were not found!"
	exit 1
else
	echo "All dynamically linked libraries were found."
fi
