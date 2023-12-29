OUTDIR?=../build

CC?=riscv32-unknown-elf

all: riscv-tests simple

riscv-tests:
	@mkdir -p $(OUTDIR)/riscv-tests
	@echo "Compiling riscv-tests..."
	$(MAKE) OUTDIR=../$(OUTDIR)/riscv-tests CC=$(CC) -C riscv-tests
	@echo "Done."

simple:
	@mkdir -p $(OUTDIR)/simple
	@echo "Compiling simple tests..."
	$(MAKE) OUTDIR=../$(OUTDIR)/simple CC=$(CC) -C simple
	@echo "Done."

.PHONY: riscv-tests simple