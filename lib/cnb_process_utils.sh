#!/usr/bin/env bash

set -euo pipefail

parse_launch_processes() {
	local -n _processes=$1
	local launch_toml_file="${2}"

	local type=""
	local command=""
	local line

	while IFS= read -r line; do
		# Extract the type from lines like `type = "web"`
		if [[ ${line} =~ ^type[[:space:]]*=[[:space:]]*\"([^\"]+)\" ]]; then
			type="${BASH_REMATCH[1]}"
		fi

		# Extract the command from lines like `command = ["bash", "-c", "run_command"]`
		if [[ ${line} =~ ^command[[:space:]]*=[[:space:]]*\[\"bash\",[[:space:]]*\"-c\",[[:space:]]*\"(.*)\"[[:space:]]*\] ]]; then
			command="${BASH_REMATCH[1]}"
			_processes["${type}"]="${command}"
			type=""
			command=""
		fi
	done <"${launch_toml_file}"
}
