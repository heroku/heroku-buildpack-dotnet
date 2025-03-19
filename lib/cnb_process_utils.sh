#!/usr/bin/env bash

set -euo pipefail

parse_launch_processes() {
	local -n _processes=$1
	local launch_toml_file="${2}"

	local type=""
	local line

	while IFS= read -r line; do
		# Extract the type from lines like `type = "web"`
		if [[ ${line} =~ ^type[[:space:]]*=[[:space:]]*\"([^\"]+)\" ]]; then
			type="${BASH_REMATCH[1]}"
		fi

		# Extract command array from lines like `command = ["bash", "-c", "run_command"]`, or `command = ["dotnet", "test", "foo.sln"]`
		if [[ ${line} =~ ^command[[:space:]]*=[[:space:]]*\[(.*)\] ]]; then
			local command=()
			local raw_command="${BASH_REMATCH[1]}"

			# Extract quoted values
			while [[ ${raw_command} =~ \"([^\"]+)\" ]]; do
				command+=("${BASH_REMATCH[1]}")
				raw_command=${raw_command#*\""${BASH_REMATCH[1]}"\"}
			done

			# Store the command, handling `bash -c` case where we only want the third argument
			if [[ ${#command[@]} -ge 3 && "${command[0]}" == "bash" && "${command[1]}" == "-c" ]]; then
				_processes["${type}"]="${command[2]}"
			else
				_processes["${type}"]="${command[*]}"
			fi

			type=""
		fi
	done <"${launch_toml_file}"
}
