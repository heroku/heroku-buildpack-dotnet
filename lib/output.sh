#!/usr/bin/env bash

# This is technically redundant, since all consumers of this lib will have enabled these,
# however, it helps Shellcheck realise the options under which these functions will run.
set -euo pipefail

ANSI_RED='\033[1;31m'
ANSI_RESET='\033[0m'

# Indent passed stdout. Typically used to indent command output within a step.
#
# Usage:
# ```
# dotnet test ... | output::indent
# ```
function output::indent() {
	sed --unbuffered "s/^/       /"
}

# Output a styled multi-line error message to stderr.
#
# Usage:
# ```
# output::error <<-EOF
# 	Error: The error summary.
#
# 	Detailed description.
# EOF
# ```
function output::error() {
	echo >&2
	while IFS= read -r line; do
		echo -e "${ANSI_RED} !     ${line}${ANSI_RESET}" >&2
	done
	echo >&2
}
