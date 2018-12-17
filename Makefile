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
GOMETALINTER := $(BIN_DIR)/gometalinter
TEST_BUILDS=test-pkgs
OS=$(shell uname -s)
VERSION := $(shell cat VERSION)

# Check for required command tools to build or stop immediately
#EXECUTABLES = git go find pwd
#K := $(foreach exec,$(EXECUTABLES),\
        $(if $(shell which $(exec)),some string,$(error "No $(exec) in PATH)))

#ROOT_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

# Add the following 'help' target to your Makefile
# And add help text after each target name starting with '\#\#'
.PHONY: help
help: ## This help message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: setup
setup: ## Ckecks and prepares setup
ifeq ($(OS), Darwin)
	brew install dep
else
	curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh
endif
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

.PHONY: lint
lint: $(GOMETALINTER) ## Runs a GO linter
	gometalinter ./... --vendor

