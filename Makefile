# Generate Verilog code
doit:
	sbt run

# Run the test
test:
	$(MAKE) -C tests
	sbt test

slides:
	marp --pdf README.md
	open README.pdf

clean:
	@rm -rf build generated
	git clean -fd

