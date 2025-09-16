#!/usr/bin/env bash
# Test script for parse_launch_toml.py CLI functionality

set -euo pipefail

BUILDPACK_DIR=$(cd "$(dirname "$(dirname "${BASH_SOURCE[0]}")")" && pwd)
SCRIPT_PATH="${BUILDPACK_DIR}/lib/parse_launch_toml.py"

# Create test TOML file
TEST_TOML=$(mktemp)
trap 'rm -f "${TEST_TOML}"' EXIT

echo "${TEST_TOML}"

cat >"${TEST_TOML}" <<'EOF'
# Current CNB output (used by bin/release and bin/detect)
[[processes]]
type = "bash-c"
command = ["bash", "-c", "cd bin/publish; ./foo --urls http://*:$PORT"]

[[processes]]
type = "bash-c-spaces"
command = ["bash", "-c", "cd 'console app/bin/publish'; ./'console app'"]

[[processes]]
type = "simple"
command = ["dotnet", "test", "foo.csproj"]

[[processes]]
type = "simple-arg-spaces"
command = ["dotnet", "test", "solution with spaces.sln"]

# TOML parsing edge cases
[[processes]]
default = true
command = ["foo", "bar", "baz", "qux", "quux"]
type = "field-order"

[[processes]]
   type =   "whitespace"
command = ["foo",    "bar",  "baz", "qux",   "quux"  ]

[[processes]]
type = "multiline"
command = [
    "foo",
    "bar",
    "baz"
]
EOF

test_yaml_output() {
	echo "Testing complete YAML output:"
	local output
	output=$(python3 "${SCRIPT_PATH}" "${TEST_TOML}" --yaml)
	echo "${output}"

	local expected_yaml="---
default_process_types:
  bash-c: cd bin/publish; ./foo --urls http://*:\$PORT
  bash-c-spaces: cd 'console app/bin/publish'; ./'console app'
  simple: dotnet test foo.csproj
  simple-arg-spaces: dotnet test 'solution with spaces.sln'
  field-order: foo bar baz qux quux
  whitespace: foo bar baz qux quux
  multiline: foo bar baz"

	if [[ "${output}" != "${expected_yaml}" ]]; then
		echo "ERROR: YAML output mismatch"
		echo "Expected:"
		echo "${expected_yaml}"
		echo "Got:"
		echo "${output}"
		return 1
	fi
	echo "✓ Complete YAML output verified"
}

test_process_extraction() {
	local process_type="$1"
	local expected="$2"

	echo "Testing --process ${process_type}:"
	local output
	output=$(python3 "${SCRIPT_PATH}" "${TEST_TOML}" --process "${process_type}")
	echo "${output}"

	if [[ "${output}" != "${expected}" ]]; then
		echo "ERROR: Expected '${expected}', got '${output}'"
		return 1
	fi
	echo "✓ ${process_type} process verified"
}

test_nonexistent_process() {
	echo "Testing nonexistent process (should fail):"
	if python3 "${SCRIPT_PATH}" "${TEST_TOML}" --process nonexistent >/dev/null 2>&1; then
		echo "ERROR: Should have failed for nonexistent process"
		return 1
	else
		echo "✓ Nonexistent process correctly failed"
	fi
}

main() {
	echo "Testing parse_launch_toml.py CLI functionality"
	echo "=============================================="

	test_yaml_output
	echo

	# Test parsing functionality for current CNB `launch.toml` output first
	test_process_extraction "bash-c" "cd bin/publish; ./foo --urls http://*:\$PORT"
	echo

	test_process_extraction "bash-c-spaces" "cd 'console app/bin/publish'; ./'console app'"
	echo

	test_process_extraction "simple" "dotnet test foo.csproj"
	echo

	test_process_extraction "simple-arg-spaces" "dotnet test 'solution with spaces.sln'"
	echo

	# Test TOML parsing edge cases
	test_process_extraction "field-order" "foo bar baz qux quux"
	echo

	test_process_extraction "whitespace" "foo bar baz qux quux"
	echo

	test_process_extraction "multiline" "foo bar baz"
	echo

	test_nonexistent_process
	echo

	echo "All tests passed!"
}

main "$@"
