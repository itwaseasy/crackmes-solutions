.PHONY: vet build

build:
	go build -o easy_as_gdb main.go

vet:
	go mod tidy
	go vet ./...
	go fmt ./...
