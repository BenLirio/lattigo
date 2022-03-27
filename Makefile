.DEFAULT_GOAL := test

Coding/bin/Makefile.base:
	git clone https://github.com/dedis/Coding

.PHONY: test_examples
test_examples:
	@echo Running the examples
	go run ./examples/ring/vOLE -short > /dev/null
	go run ./examples/bfv > /dev/null
	go run ./examples/ckks/bootstrapping -short > /dev/null
	go run ./examples/ckks/advanced/lut -short > /dev/null
	go run ./examples/ckks/euler > /dev/null
	go run ./examples/ckks/polyeval > /dev/null
	go run ./examples/dbfv/pir &> /dev/null
	go run ./examples/dbfv/psi &> /dev/null
	@echo ok

.PHONY: test_gotest
test_gotest:
	go test -v -timeout=0 ./utils
	go test -v -timeout=0 ./ring
	go test -v -timeout=0 ./rlwe
	go test -v -timeout=0 ./rlwe/ringqp
	go test -v -timeout=0 ./rlwe/gadget
	go test -v -timeout=0 ./rlwe/rgsw
	go test -v -timeout=0 ./rlwe/lut
	go test -v -timeout=0 ./bfv
	go test -v -timeout=0 ./dbfv
	go test -v -timeout=0 ./ckks
	go test -v -timeout=0 ./ckks/advanced
	go test -v -timeout=0 ./ckks/bootstrapping -test-bootstrapping -short
	go test -v -timeout=0 ./dckks

.PHONY: test
test: test_fmt test_gotest test_examples

.PHONY: ci_test
ci_test: test_fmt test_lint test_gotest test_examples

%: force Coding/bin/Makefile.base
	@$(MAKE) -f Coding/bin/Makefile.base $@
force: ;