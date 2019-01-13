#The shell we use
SHELL := /bin/bash

# We like colors
# # From: https://coderwall.com/p/izxssa/colored-makefile-for-golang-projects
RED=`tput setaf 1`
GREEN=`tput setaf 2`
RESET=`tput sgr0`
YELLOW=`tput setaf 3`

# Settings
BIN_DIR := $(GOPATH)/bin
PKG_DIR=dist

# Build Settings
VERSION := $(shell cat VERSION)
GIT_COMMIT := $(shell git rev-parse --short HEAD)
BUILD_DATE:= $(shell date -u +%F)

.PHONY: help
help: ## This help message
	@echo -e "$$(grep -hE '^\S+:.*##' $(MAKEFILE_LIST) | sed -e 's/:.*##\s*/:/' -e 's/^\(.\+\):\(.*\)/\\x1b[36m\1\\x1b[m:\2/' | column -c2 -t -s :)"

.PHONY: test-build
test-build: ## Creating test builds (binaries) for local testing
	@echo ""
	@echo "$(YELLOW)==> Creating test binaries for $(VERSION)$(RESET)"
	@if [ -d $(TEST_BUILDS) ]; then rm -rf $(TEST_BUILDS); fi;
	@go fmt
	@gox -ldflags "$(LD_FLAGS) -X github.com/testthedocs/edic/cmd.Version=${VERSION} \
	 -X github.com/testthedocs/edic/cmd.BuildDate=$(BUILD_DATE) \
	 -X github.com/testthedocs/edic/cmd.GitCommit=$(GIT_COMMIT)" \
	 -osarch="linux/amd64 darwin/amd64" -output "$(PKG_DIR)/{{.Dir}}_{{.OS}}_{{.Arch}}"
	@echo ""
	@echo "$(YELLOW)==> Done ! Test binaries for $(VERSION) are created in $(PKG_DIR) $(RESET)"

.PHONY: dep-update
dep-update: ## Update go libs with dep
	@echo ""
	@echo "$(YELLOW)==> Creating test binaries for $(VERSION)$(RESET)"
	@dep ensure -u

.PHONY: AUTHORS
AUTHORS: ## Creates file with all individuals having contributed content to the repository
	@$(file >$@,# This file lists all individuals having contributed content to the repository.)
	@$(file >>$@,# For how it is generated, see `make AUTHORS`.)
	@echo "$(shell git log --format='%aN <%aE>' | LC_ALL=C.UTF-8 sort -uf)" >> $@
