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

		# Extract command array from lines like `command = ["bash", "-c", "run_command"]`,
		# `command = ["dotnet", "test", "foo.csproj"]`.
		# `command = ["dotnet", "test", "foo bar.csproj", "--verbosity", "normal"]`.
		if [[ ${line} =~ ^command[[:space:]]*=[[:space:]]*\[(.*)\] ]]; then
			local command=()
			local raw_command="${BASH_REMATCH[1]}"
			local quoted_command=()

			# Extract quoted values
			while [[ ${raw_command} =~ \"([^\"]+)\" ]]; do
				local arg="${BASH_REMATCH[1]}"
				command+=("${arg}")

				# Quote arg if it differs from it's own `printf '%q'` formatting. This
				# is a hack to check for special characters that'd need escaping (while
				# preferring to quote the arg for readability) without using regex, sed etc.
				if [[ "$(printf '%q' "${arg}")" != "${arg}" ]]; then
					quoted_command+=("\"${arg}\"")
				else
					quoted_command+=("${arg}")
				fi

				raw_command=${raw_command#*\""${arg}"\"}
			done

			# Store the command, handling `bash -c` case where we only want the (unquoted) third argument
			if [[ ${#command[@]} -ge 3 && "${command[0]}" == "bash" && "${command[1]}" == "-c" ]]; then
				_processes["${type}"]="${command[2]}"
			else
				_processes["${type}"]="${quoted_command[*]}"
			fi

			type=""
		fi
	done <"${launch_toml_file}"
}
