OUTDIR=../build
CC=riscv64-unknown-elf

all: riscv-tests simple ripes

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

ripes:
	@mkdir -p $(OUTDIR)/ripes
	@echo "Compiling ripes tests..."
	$(MAKE) OUTDIR=../$(OUTDIR)/ripes CC=$(CC) -C ripes
	@echo "Done."

dump: ${AOBJ} ${COBJ}
	$(CC)-objdump -d $(AOBJ) $(COBJ)

.PHONY: riscv-tests simple ripes