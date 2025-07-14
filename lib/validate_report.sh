#!/usr/bin/env bash

# Script to validate bin/report output format following successful compilation.
# Usage: ./bin/report /tmp/build /tmp/cache /tmp/env | lib/validate_report.sh
#
# Validates that all expected fields are present and properly formatted.
# Reports all missing/invalid patterns and exits with status 1 if any errors found.

set -uo pipefail

EXPECTED_PATTERNS=(
	"^sdk_version_requirement: '[^']*'"
	"^sdk_download_file_url: 'https://"
	"^sdk_download_file_duration_ns: [0-9]"
	"^sdk_download_file_attempts: [0-9]"
	"^sdk_verify_checksum_duration_ns: [0-9]"
	"^sdk_extract_tarball_duration_ns: [0-9]"
	"^sdk_layer_duration_ns: [0-9]"
	"^libcnb_build_event: '[^']*'"
	"^libcnb_build_status_code: [0-9]"
	"^libcnb_build_duration_ns: [0-9]"
)

validate_report_output() {
	local report_output="$1"
	local errors=0

	# Check each expected pattern
	for pattern in "${EXPECTED_PATTERNS[@]}"; do
		if ! echo "${report_output}" | grep -q "${pattern}"; then
			echo "ERROR: Pattern '${pattern}' missing or invalid format" >&2
			((errors++))
		fi
	done

	if [[ "${errors}" -gt 0 ]]; then
		echo "ERROR: ${errors} bin/report validation errors found" >&2
		return 1
	fi

	echo "All expected bin/report fields present and properly formatted"
}

# Read input from stdin
report_output=$(cat)

validate_report_output "${report_output}"
