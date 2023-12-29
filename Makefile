# Generate Verilog code
doit:
	sbt run

# Run the test
test:
	$(MAKE) CC=riscv32-unknown-elf -C tests
	sbt test

slides:
	marp --pdf README.md
	open README.pdf

clean:
	@rm -rf build generated
	git clean -fd

