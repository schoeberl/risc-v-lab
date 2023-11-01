# Generate Verilog code
doit:
	sbt run

# Run the test
test:
	sbt test

slides:
	marp --pdf README.md
	open README.pdf

clean:
	git clean -fd

