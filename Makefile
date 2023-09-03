SHELL:=/bin/sh
.PHONY: build run fmt clean test

MKFILE_PATH := ${abspath $(lastword $(MAKEFILE_LIST))}
MKFILE_DIR := $(dir $(MKFILE_PATH))
RELEASE_DIR := ${MKFILE_DIR}/output
GO_PATH := go #$(shell go env | grep GOPATH | awk -F '=' '{print $2}')

# Rules
build:
	@echo "build"
	cd ${MKFILE_DIR} && \
	go build -v -trimpath \
	-o ${RELEASE_DIR}/go-to ${MKFILE_DIR}

run:
	build

fmt:
	cd ${MKFILE_DIR} && go fmt ./...

clean:
	rm -rf ${RELEASE_DIR}

test:
	cd ${MKFILE_DIR}
	go mod tidy
	git diff --exit-code go.mod go.sum
	go mod verify
	go test -v -gcflag "all=-l" ${MKFILE_DIR}