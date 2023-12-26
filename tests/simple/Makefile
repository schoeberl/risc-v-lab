OUTDIR?=.

ASRCS:=$(wildcard *.s)
CSRCS:=$(wildcard *.c)
AOBJ:=$(ASRCS:%.s=$(OUTDIR)/%.out)
COBJ:=$(CSRCS:%.c=$(OUTDIR)/%.out)
BINS:=$(AOBJ:%.out=%.bin) $(COBJ:%.out=%.bin)

CC?=riscv32-unknown-elf

all: ${AOBJ} ${COBJ} ${BINS}

$(OUTDIR)/%.out: %.c
	$(CC)-gcc -march=rv32i -mabi=ilp32 -ffreestanding -nostartfiles -nostdlib -nodefaultlibs -Wl,-T,linker.ld -o $@ $<  

$(OUTDIR)/%.out: %.s
	$(CC)-as -march=rv32i -mabi=ilp32 -o $@ $<  

$(OUTDIR)/%.bin: $(OUTDIR)/%.out
	$(CC)-objcopy -O binary $< $@

clean:
	@rm $(OUTDIR)/*.bin $(OUTDIR)/*.out
