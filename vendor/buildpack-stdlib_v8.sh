#!/usr/bin/env bash
# shellcheck disable=SC2250 # TODO: Use braces around variable references even when not strictly required.

set -euo pipefail

# Based on:
# https://raw.githubusercontent.com/heroku/buildpack-stdlib/v8/stdlib.sh

# Buildpack Utilities
# -------------------

# Usage: $ _env-blacklist pattern
# Outputs a regex of default blacklist env vars.
_env_blacklist() {
	local regex=${1:-''}
	if [[ -n "$regex" ]]; then
		regex="|$regex"
	fi
	echo "^(PATH|CPATH|CPPATH|LD_PRELOAD|LIBRARY_PATH|LD_LIBRARY_PATH|PYTHONHOME$regex)$"
}

# Usage: $ export-env ENV_DIR WHITELIST BLACKLIST
# Exports the environment variables defined in the given directory.
export_env() {
	local env_dir=${1:-$ENV_DIR}
	local whitelist=${2:-''}
	local blacklist
	blacklist="$(_env_blacklist "$3")"
	if [[ -d "$env_dir" ]]; then
		# Environment variable names won't contain characters affected by:
		# shellcheck disable=SC2045
		for e in $(ls "$env_dir"); do
			echo "$e" | grep -E "$whitelist" | grep -qvE "$blacklist" \
				&& export "$e=$(cat "$env_dir/$e")"
			:
		done
	fi
}
