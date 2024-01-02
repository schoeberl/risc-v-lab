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

The course will be in building 116, room 042 and will start on
Tuesday 2nd of January 2023 at 10:00.

See the `Makefile` for the hardware and test targets.

## Welcome

 * Build your **own** RISC-V microprocessor
 * Run **your** processor in your Basys3 board
 * This is a new 3 weeks course
 * I am exciting to see you building a RISC-V processor

## Introduction Round

 * Who are you?
 * Why this course?

## Rules

 * The processor shall implement the RISC-V RV32I instruction set
 * The processor shall be pipelined
 * The processor shall be able to run a simple program in an FPGA
 * You are allowed to split the memory into instruction and data memory
   * To avoid the need for caches for a single memory
 * You do not need to support unaligned memory access
   * This could be added by an exception and handled in an exception handler

## Warning

 * This is a new course
 * There might be some rough edges
 * You are the test group
 * I will try to fix problems as fast as possible
 * I will add more material as we go along

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

## Notes and Hints

 * It is easier to have the pipeline registers on the input of a stage
   * As memory has a register at the input (for register file and the memory stage)
 * For easier debugging use a Reg for the register file (RegInit(VecInit(Seq.fill(32)(0.U(32.W)))))
   * For resource/performance reasons it should be an on-chip memory (SyncReadMem(32, UInt(32.W)))
 * Stalling on a data hazard is a possible option
   * Forwarding has higher performance
 * Start testing and integration at day 1

### Pipeline Repetition

 * See CAE slides

## Organisation

 * We will meet in the first week every day at 10:00
   * **except this Friday:** at 13:00
 * Status presentation on Friday (13:00)
   * Each group presents
   * Two slides
 * I am online available during the week (email, slack, zoom)
   * Can we agree on a Slack channel?

## Exam

 * Presentation of your processor
   * On last Friday
   * A few slides
   * Demo in FPGA board
 * Show me your code
 * No report needed

## Competition

 * Shall we have a competition?
   * The fastest implementation
   * The smallest implementation
   * We need to agree on a benchmark

## A Possible Work Plan

 * Imlplement the minum viable product (MVP) first
   * A single instruction
   * MVP of all pipeline stages
 * Write a test
 * Continue adding instructions  

### Fetching Instructions

 * Start with a simple fetch stage
 * Use simple assembler tests (from CAE or others given)
 * Use RV gcc (or Venus) to compile the assembler programs
 * Read them in the fetch stage into the instruction memory (ROM)
 * Explore the waveform with GTKWave

### Start with a Single Instruction

  * Implement a single instruction
  * Start with `addi`
  ```asm
	addi	x1, x0, 0x123
  ```
  * Assembles to `0x12300093`
  * Hardcode that instruction in the fetch stage
  * Watch the instruction through the pipeline
  * Write a test

### A Simple Initial Program

Add the RR version of the `add` instruction and watch it in a waveform.

```asm
	addi	x1, x0, 0x111
	addi	x2, x0, 0x222
# missing forwarding
	nop
	nop
	nop
	add	x3, x1, x2
```

### Assemble that code

 * You could assemble this manually and hardcode a Chisel `Vec()`.
 * You can also use Venus to assemble the program
 * Show it live
 * However, it is easier to use `gcc`

### Decode Stage

 * Add the decode stage
 * Extract the opcode and the register numbers
 * Use a `switch` to decode the instruction
 * Add the register file
 * Write some tests

### Execute Stage

 * Add the execute stage
 * Implement the `addi` instruction
 * Write some tests
 * Continue with the ALU

### Memory Stage

  * Add the memory stage
  * Implement the `lw` and `sw` instructions
  * Write some tests

### Writeback stage

 * Do we need a writeback stage?
 * Let us discuss pipeline variations (now)

### Bootloader

 * The bootloader is a small program that is loaded into the instruction memory
 * It can then itself load a program into the instruction and data memory
 * This avoids resynthesizing the FPGA for each new program
 * The bootloader can be written in C
 * It communicates with the host computer via the serial port
  * You need a program on the host computer to send the program to the bootloader running on your RISC-V processor


## TODO and Notes

 * Talk about testing: self testes and cosimulation
 * Competiton: smallest and fastest implementation
 * Explore myself different pipeline organizations

## Testing

- Two collections of test programs are provided
  - `tests/simple` contains some basic test cases for all RV32I instructions
    - The ones from the CAE course
  - `tests/riscv-tests` contains thorough tests for all RV32I instructions from the official [riscv-tests](https://github.com/riscv-software-src/riscv-tests) repository
  - The test programs exit via the `ecall` instruction
  - All tests come with a `.res` file containing a dump of the register file after the program has finished

### Building the Tests

- Elf files and flat binaries are built before `sbt test` when running `make test`
- The output files are placed in the `build/simple` and `build/riscv-tests` directories
- Set the `CC` variable to your RISC-V GCC compiler in the [Makefile](Makefile?plain=1#L7)

### riscv-tests

- the `riscv-tests` are self tests which check results inside the test code
  - the test returns 0 in register `a7` if the test was successful
  - else the failing tests number is placed in `a7`
  - the self testing functionality relies on compare and branch instructions

### riscv-tests - Execution Traces - I

- Each riscv-test programs also comes with a `.csv` file containing an execution trace
- One line contains the following information:
  - `pc;instr_word;assembly;wb_dest;wb_value;mem_addr;mem_wr_data\n`
  - If no write back, load or store occurs, the corresponding fields are left empty
- Example: this load instruction sets x14 to 0xF00F by loading a halfword from address 0x80001006
  - `800000f8;60d703;lhu a4, 6(ra);14;f00f;80001006;\n`

### riscv-tests - Execution Traces - II

- The execution traces can be used to check the correct execution of the programs step by step, like in a co-simulation
- Attention has to be given to stalls in your pipeline, since the trace was executed on a single-cycle processor

## Peripherals

- Two basic memory mapped peripherals are provided
  - UART transceiver
  - LED controller
- The peripherals are attached to a simple bus

### System Bus

| name    | width | description                                            |
|---------|-------|--------------------------------------------------------|
| `read`  | 1     | signal a read operation                                |
| `write` | 1     | signal a write operation                               |
| `addr`  | 32    | address for read or write                              |
| `wrData`| 32    | data to write                                          |
| `rdData`| 32    | result of read (valid one cycle after `read` is asserted) |

Use `Bus.RequestPort()` and `Bus.ResponsePort()` to create IO.

### LED Controller - Register Map

| address | read                           | write                           |
|---------|--------------------------------|---------------------------------|
| 0x00    | read n-bit LED status          | set n-bit LED status            |

- Has only a single memory-mapped register with one bit per LED

### UART - Register Map


| address | read                           | write                           |
|---------|--------------------------------|---------------------------------|
| 0x00    | read received data from buffer | write data to send into buffer  |
| 0x04    | read UART status (bit 0: tx ready and bit 1: rx has data) | -    |


- Reading from address 0x00 will remove a character from the receive buffer. If the buffer is empty, no valid data is returned. 
- Writing to address 0x00 will add a character to the transmit buffer. If the buffer is full, the character will be dropped. 


## Connecting multiple Peripherals

- Requests have to be sent to the appropriate peripheral or memory based on the address
- Each device has its own address range, e.g. a multiple of 1kB and in this case the upper 22 bits are used to select the device
- Only the `read` and `write` signals of the appropriate device are asserted
- The routing decision has to be remembered to select the correct response


## Using elf Executables

- Use the `lib.Executable` class to load an elf file and extract sections and the entry address

```scala
val exe = Executable.from("path/to/myElf.out")
val text = exe.getSection(".text")
text.getWords // returns a Seq[Long] of instructions
text.start // start address of the section
exe.getEntryPoint // returns the start PC of the program
```

