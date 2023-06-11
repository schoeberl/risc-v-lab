# Design of a RISC-V Microprocessor

This repo is the website for the 3 weeks course at DTU on designing a RISC-V
microprocessor containing lab material. 

See the `Makefile` for the hardware and test targets.

## Rules

 * The processor shall implement the RISC-V RV32I instruction set.
 * The processor shall be pipelined.
 * The processor shall be able to run a simple program in an FPGA.
 * You can split the memory into instruction and data memory
   * To avoid the need for caches for a single memory

## TODO and Notes

 * Talk about testing: self testes and cosimulation
 * Get some testing infrastructure in place
 * Competiton: smallest and fastest implementation
 * Explore myself different pipeline organizations

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

