.PHONY: vet build

build:
	go build -o powershelly main.go

vet:
	go mod tidy
	go vet ./...
	go fmt ./...
