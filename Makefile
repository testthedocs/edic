# ########################################################## #
# Makefile for Golang Project
# Includes cross-compiling, installation, cleanup
# ########################################################## #

# The shell we use
SHELL := /bin/bash

# We like colors
# # From: https://coderwall.com/p/izxssa/colored-makefile-for-golang-projects
RED=`tput setaf 1`
GREEN=`tput setaf 2`
RESET=`tput sgr0`
YELLOW=`tput setaf 3`

# Vars
BIN_DIR := $(GOPATH)/bin
# Set an output prefix, which is the local directory if not specified
PREFIX?=$(shell pwd)

# Vars for linters
GOMETALINTER := $(BIN_DIR)/gometalinter
GOLINT := $(BIN_DIR)/golint
STATICCHECK :=$(BIN_DIR)/staticcheck
TEST_BUILDS=test-pkgs
OS=$(shell uname -s)
VERSION := $(shell cat VERSION)
RELEASE_NOTES :=release-notes


# Add the following 'help' target to your Makefile
# And add help text after each target name starting with '\#\#'
.PHONY: help
help: ## This help message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: setup
setup: ## Ckecks and prepares setup
ifeq ($(OS), Darwin)
	@echo ""
	@echo "$(YELLOW)==> Installing dep ...$(RESET)"
	brew install dep
else
	@echo ""
	@echo "$(YELLOW)==> Installing dep ...$(RESET)"
	curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh
endif
	@echo ""
	@echo "$(YELLOW)==> Running dep to install go dependencies ...$(RESET)"
	dep ensure -vendor-only

.PHONY: test-build
test-build: ## Creating test builds (binaries) for local testing
	@echo ""
	@echo "$(YELLOW)==> Creating test binaries for $(VERSION)$(RESET)"
	@if [ -d $(TEST_BUILDS) ]; then rm -rf $(TEST_BUILDS); fi;
	@go fmt
	@gox -osarch="linux/amd64 darwin/amd64" -output "$(TEST_BUILDS)/{{.Dir}}_{{.OS}}_{{.Arch}}"
	@echo ""
	@echo "$(YELLOW)==> Done ! Test binaries for $(VERSION) are created in $(TEST_BUILDS) $(RESET)"

.PHONY: install
install: ## Install test binary locally
	@echo ""
	@echo "$(YELLOW)==> Installing test binary for $(VERSION)$(RESET)"
	@go install

$(GOMETALINTER):
	go get -u github.com/alecthomas/gometalinter
	gometalinter --install &> /dev/null

.PHONY: lint-all
lint: $(GOMETALINTER) ## Runs ALL GO linter
	gometalinter ./... --vendor

.PHONY: golint
golint: $(GOLINT) ## Runs golint
	golint ./...

.PHONY: staticcheck
staticcheck: $(STATICCHECK) ## Runs staticcheck
	staticcheck ./...

.PHONY: docs
docs: ## Builds HTML for publishing
	$(MAKE) -C docs docs

.PHONY: release
release: ## Release go binary using GitReleaser
	@git tag -a $(VERSION) -m "Release" || true
	@git push origin $(VERSION)
	#@goreleaser --rm-dist
	@goreleaser --rm-dist --release-notes=$(PREFIX)/$(RELEASE_NOTES)/$(VERSION).md
	#@echo "$(YELLOW)==> Now run: goreleaser --rm-dist --release-notes=PATH/TO/NOTES $(VERSION)$(RESET)"

.PHONY: release-snapshot
release-snapshot: ## Build snapshot of release with GoReleaser
	@goreleaser --rm-dist --snapshot
