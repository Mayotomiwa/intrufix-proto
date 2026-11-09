BUF := go run github.com/bufbuild/buf/cmd/buf@v1.75.0

.PHONY: generate lint breaking

# Regenerate Go code into gen/go. Commit the result.
generate:
	$(BUF) generate
	go mod tidy

lint:
	$(BUF) lint

# Fails if the contract changed in a way that breaks existing callers.
breaking:
	$(BUF) breaking --against '.git#branch=main'
