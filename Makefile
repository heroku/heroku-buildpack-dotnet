# These targets are not files
.PHONY: lint lint-scripts lint-ruby lint-python check-format check-format-shell check-format-python format format-shell format-python test-parse-launch-toml run run-ci publish

STACK ?= heroku-24
FIXTURE ?= spec/fixtures/basic_web_8.0

# Converts a stack name of `heroku-NN` to its build Docker image tag of `heroku/heroku:NN-build`.
STACK_IMAGE_TAG := heroku/$(subst -,:,$(STACK))-build

lint: lint-scripts check-format lint-ruby lint-python

lint-scripts:
	@git ls-files -z --cached --others --exclude-standard 'bin/*' '*/bin/*' '*.sh' | xargs -0 shellcheck --check-sourced --color=always

lint-ruby:
	@bundle exec rubocop

lint-python:
	@ruff check .

check-format: check-format-shell check-format-python

check-format-shell:
	@shfmt --diff .

check-format-python:
	@ruff format --diff

format: format-shell format-python

format-shell:
	@shfmt --write --list .

format-python:
	@ruff format .

test-parse-launch-toml:
	@echo "Testing parse_launch_toml.py script functionality using: STACK=$(STACK)"
	@docker run --rm -v $(PWD):/src:ro "$(STACK_IMAGE_TAG)" /src/test/parse-launch-toml-test.sh

run:
	@echo "Running buildpack using: STACK=$(STACK) FIXTURE=$(FIXTURE)"
	@docker run --rm -v $(PWD):/src:ro --tmpfs /app -e "HOME=/app" -e "STACK=$(STACK)" "$(STACK_IMAGE_TAG)" \
		bash -euo pipefail -c '\
			mkdir /tmp/buildpack /tmp/build /tmp/cache /tmp/env; \
			cp -r /src/{bin,lib,vendor} /tmp/buildpack; \
			cp -rT /src/$(FIXTURE) /tmp/build; \
			cd /tmp/buildpack; \
			unset $$(printenv | cut -d '=' -f 1 | grep -vE "^(HOME|LANG|PATH|STACK)$$"); \
			echo -e "\n~ Detect:" && ./bin/detect /tmp/build; \
			echo -e "\n~ Compile:" && { ./bin/compile /tmp/build /tmp/cache /tmp/env || COMPILE_FAILED=1; }; \
			[[ "$${COMPILE_FAILED:-}" == "1" ]] && exit 0; \
			[[ -f /tmp/build/bin/compile ]] && { echo -e "\n~ Compile (Inline Buildpack):" && (source ./export && /tmp/build/bin/compile /tmp/build /tmp/cache /tmp/env); }; \
			echo -e "\n~ Report:" && REPORT_OUTPUT=$$(./bin/report /tmp/build /tmp/cache /tmp/env) && echo "$$REPORT_OUTPUT" && echo "$$REPORT_OUTPUT" | lib/validate_report.sh; \
			echo -e "\n~ Release:" && ./bin/release /tmp/build; \
			echo -e "\nBuild successful!"; \
		'
	@echo

run-ci:
	@echo "Running buildpack CI scripts using: STACK=$(STACK) FIXTURE=$(FIXTURE)"
	@docker run --rm -v $(PWD):/src:ro --tmpfs /app -e "HOME=/app" -e "STACK=$(STACK)" "$(STACK_IMAGE_TAG)" \
		bash -euo pipefail -c '\
			mkdir /tmp/buildpack /tmp/build /tmp/cache /tmp/env; \
			cp -r /src/{bin,lib,vendor} /tmp/buildpack; \
			cp -rT /src/$(FIXTURE) /tmp/build; \
			cd /tmp/buildpack; \
			unset $$(printenv | cut -d '=' -f 1 | grep -vE "^(HOME|LANG|PATH|STACK)$$"); \
			echo -e "\n~ Detect:" && ./bin/detect /tmp/build; \
			echo -e "\n~ Test Compile:" && ./bin/test-compile /tmp/build /tmp/cache /tmp/env; \
			echo -e "\n~ Sourcing profile:" && { source /tmp/build/.profile.d/dotnet.sh && printenv; }; \
			echo -e "\n~ Test:" && ./bin/test /tmp/build /tmp/cache /tmp/env; \
			echo -e "\nTest compilation and execution successful!"; \
		'
	@echo

publish:
	@etc/publish.sh
