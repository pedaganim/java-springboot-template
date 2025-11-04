SHELL := /bin/bash

.PHONY: help backend-format backend-check backend-test backend-build ui-install ui-format ui-lint ui-test ui-build format check test build

help:
	@echo "Targets:"
	@echo "  backend-format  - Apply Spotless formatting"
	@echo "  backend-check   - Run Spotless, Checkstyle, tests, coverage"
	@echo "  backend-test    - Run backend tests"
	@echo "  backend-build   - Build backend"
	@echo "  ui-install      - Install UI deps (npm ci)"
	@echo "  ui-format       - Prettier write"
	@echo "  ui-lint         - ESLint"
	@echo "  ui-test         - Vitest run"
	@echo "  ui-build        - Build UI"
	@echo "  format          - Backend + UI formatting"
	@echo "  check           - Backend + UI checks"
	@echo "  test            - Backend + UI tests"
	@echo "  build           - Backend + UI builds"

backend-format:
	./gradlew spotlessApply

backend-check:
	./gradlew clean spotlessCheck checkstyleMain test jacocoTestReport jacocoTestCoverageVerification

backend-test:
	./gradlew test

backend-build:
	./gradlew clean build

ui-install:
	cd ui && npm ci

ui-format:
	cd ui && npm run format

ui-lint:
	cd ui && npm run lint

ui-test:
	cd ui && npm run test:run

ui-build:
	cd ui && npm run build

format: backend-format ui-format

check: backend-check ui-lint

test: backend-test ui-test

build: backend-build ui-build
\nEOF\n
# Add Husky-like hooks directory and pre-commit script
mkdir -p .husky
cat > .husky/pre-commit << nEOFn
#!/bin/sh
. "./_/husky.sh" 2>/dev/null || true

# Backend: format check and style
./gradlew -q spotlessCheck checkstyleMain || exit 1

# UI: install (cached by npm) + lint + prettier check if ui exists
if [ -d ui ]; then
  (cd ui && npm ci && npm run -s lint && npm run -s format:check) || exit 1
fi
\nEOF\n
# Add helper husky shim so script still runs if husky not installed
cat > .husky/_/husky.sh << EOF
#!/bin/sh
# Minimal shim to avoid failing when Husky is not installed in this repo
# Allows running the hook script directly
:
EOF
chmod +x .husky/pre-commit .husky/_/husky.sh

# Provide setup script to enable hooks without Husky
mkdir -p scripts
cat > scripts/enable-git-hooks.sh << EOF
#!/usr/bin/env bash
set -euo pipefail

echo "Setting core.hooksPath to .husky"
git config core.hooksPath .husky

echo "Done. Git will now use .husky hooks."
EOF
chmod +x scripts/enable-git-hooks.sh

git add -A
git commit -m "devex: add Makefile and pre-commit hook (.husky); helper script to enable hooks"

git push -u origin devex-make-husky
