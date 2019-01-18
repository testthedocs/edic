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
RELEASE_NOTES :=release-notes

# Set an output prefix, which is the local directory if not specified
PREFIX?=$(shell pwd)

# Build Settings
VERSION := $(shell cat VERSION)
GIT_COMMIT := $(shell git rev-parse --short HEAD)
BUILD_DATE:= $(shell date -u +%F)
LD_FLAGS += -s -w

# Release settings
GITHUB_TOKEN := $(shell cat .env)

# Check for required command tools to build or stop immediately
EXECUTABLES = git go find pwd
K := $(foreach exec,$(EXECUTABLES),\
        $(if $(shell which $(exec)),some string,$(error "No $(exec) in PATH")))

.PHONY: help
help: ## This help message
	@echo -e "$$(grep -hE '^\S+:.*##' $(MAKEFILE_LIST) | sed -e 's/:.*##\s*/:/' -e 's/^\(.\+\):\(.*\)/\\x1b[36m\1\\x1b[m:\2/' | column -c2 -t -s :)"

.PHONY: check
check: ## Runs golangci
	@GO111MODULE=off go get -u github.com/golangci/golangci-lint/cmd/golangci-lint
	@golangci-lint run

.PHONY: install
install: ## Install binary locally
	@echo ""
	@echo "$(YELLOW)==> Installing binary for $(VERSION)$(RESET)"
	go install -ldflags "$(LD_FLAGS) -X github.com/testthedocs/edic/cmd.Version=${VERSION} \
	 -X github.com/testthedocs/edic/cmd.BuildDate=$(BUILD_DATE) \
	 -X github.com/testthedocs/edic/cmd.GitCommit=$(GIT_COMMIT)"

.PHONY: binary
binary: ## Creating builds (binaries)
	@echo ""
	@echo "$(YELLOW)==> Creating binaries for $(VERSION)$(RESET)"
	@if [ -d $(PKG_DIR) ]; then rm -rf $(PKG_DIR); fi;
	@go fmt
	@gox -ldflags "$(LD_FLAGS) -X github.com/testthedocs/edic/cmd.Version=${VERSION} \
	 -X github.com/testthedocs/edic/cmd.BuildDate=$(BUILD_DATE) \
	 -X github.com/testthedocs/edic/cmd.GitCommit=$(GIT_COMMIT)" \
	 -osarch="linux/amd64 darwin/amd64" -output "$(PKG_DIR)/{{.Dir}}_{{.OS}}_{{.Arch}}"
	@echo ""
	@echo "$(YELLOW)==> Done ! binaries for $(VERSION) are created in $(PKG_DIR) $(RESET)"

.PHONY: dep-update
dep-update: ## Update go libs with dep
	@echo ""
	@echo "$(YELLOW)==> Updating go libs $(VERSION)$(RESET)"
	@dep ensure -u

.PHONY: release
release: binary ## Release go binary using GitReleaser
	@echo ""
	@echo "$(YELLOW)==> Creating release for $(VERSION)$(RESET)"
	@git tag -a $(VERSION) -m "Release" || true
	@git push origin $(VERSION)
	@ghr -t $(GITHUB_TOKEN) -body="$(cat $(PREFIX)/$(RELEASE_NOTES)/$(VERSION).md)" $(VERSION) dist

.PHONY: read-changelog
read-changelog:
	@cat $(PREFIX)/$(RELEASE_NOTES)/$(VERSION).md

.PHONY: AUTHORS
AUTHORS: ## Creates file with all individuals having contributed content to the repository
	@$(file >$@,# This file lists all individuals having contributed content to the repository.)
	@$(file >>$@,# For how it is generated, see `make AUTHORS`.)
	@echo "$(shell git log --format='%aN <%aE>' | LC_ALL=C.UTF-8 sort -uf)" >> $@
