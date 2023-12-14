---
marp: true
theme: gaia
_class: lead
paginate: true
backgroundColor: #fff
backgroundImage: url('https://marp.app/assets/hero-background.svg')
---

<!-- headingDivider: 3 -->

# **Design of a RISC-V Microprocessor**

This repo is the website for the 3 weeks course at DTU on
designing a RISC-V microprocessor, containing lab material. 

The course will be in building 116, room 042 and will start on Tuesday 2nd
of January 2023 at 10:00.

See the `Makefile` for the hardware and test targets.

## Welcome

 * Build your **own** RISC-V microprocessor
 * Run **your** processor in your Basys3 board
 * This is a new 3 weeks course
   * You are the test group
   * Might have some edges

## Rules

 * The processor shall implement the RISC-V RV32I instruction set.
 * The processor shall be pipelined.
 * The processor shall be able to run a simple program in an FPGA.
 * You are allowed to split the memory into instruction and data memory
   * To avoid the need for caches for a single memory
 * You do not need to support unaligned memory access
   * This could be added by an exception and handled in an exception handler

## Reading Material

 * Andrew Waterman's PhD thesis on the RISC-V ISA: [Design of the RISC-V Instruction Set Architecture](https://www2.eecs.berkeley.edu/Pubs/TechRpts/2016/EECS-2016-1.html)
 * The textbook [Computer Organization and Design RISC-V Edition](https://www.amazon.com/Computer-Organization-Design-RISC-V-Architecture/dp/0128203315):
   The Hardware Software Interface, 2nd Edition,
   by David A. Patterson (Author), John L. Hennessy (Author).

## Links

 * The lab material for the CAE course at DTU: [02155 Computer Architecture and Engineering Lab](https://github.com/schoeberl/cae-lab)
 * [The RISC-V Instruction Set Manual](https://riscv.org/specifications/)
 * [Venus RV32I simulator](https://kvakil.github.io/venus/)
 * [RISC-V Green Card](https://inst.eecs.berkeley.edu/~cs61c/fa17/img/riscvcard.pdf)
 * [RISC-V Tools (GNU Toolchain, ISA Simulator, Tests)](https://github.com/riscv/riscv-tools)
 * [Rocket Chip Generator (including the RISC- tools)](https://github.com/freechipsproject/rocket-chip)
 * [Wildcat RV32I simulator](https://github.com/schoeberl/wildcat)
 * [SPIM system calls](https://www.doc.ic.ac.uk/lab/secondyear/spim/node8.html)

## Notes and Hints

 * It is easier to have the pipeline registers on the input of a stage
   * As memory has a register at the input (for register file and two memory stage)
 * For easier debugging use a Reg for the register file (RegInit(VecInit(Seq.fill(32)(0.U(32.W)))))
   * For resource/performance reasons it should be an on-chip memory (SyncReadMem(32, UInt(32.W)))
 * Stalling on a data hazard is a possible option
   * Forwarding has higher performance
 * Start testing and integration at day 1

## A Possible Work Plan

### Fetching Instructions

 * Start with a simple fetch stage
 * Use simple assembler tests (from CAE or others given)
 * Use RV gcc to compile the assembler programs
 * Read them in the fetch stage into the instruction memory (ROM)
 * Explore the waveform with GTKWave

### A Simple Start Program

Just implement immediate `addi` and the RR version of the `add`
instruction and watch it in a waveform.

```asm
	addi	x1, x0, 0x111
	addi	x2, x0, 0x222
# missing forwarding
	nop
	nop
	nop
	add	x3, x1, x2
```

You could assemble this manually and hardcode a Chisel `Vec()`.

However, it is easier to use `gcc`

### Decode Stage

### Bootloader

 * The bootloadr is a small program that is loaded into the instruction memory
 * It can then itself load a program into the instruction and data memory
 * This avoids resynthesizing the FPGA for each new program
 * The bootloader can be written in C
 * It communicates with the host computer via the serial port
  * You need a program on the host computer to send the program to the bootloader running on your RISC-V processor


## TODO and Notes

* Talk about testing: self testes and cosimulation
* Get some testing infrastructure in place
* Competiton: smallest and fastest implementation
* Explore myself different pipeline organizations