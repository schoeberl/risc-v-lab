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
 * [RIPES RISC-V simulator](https://github.com/mortbopet/Ripes)
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
   * Send me a link to your repo latest Thursday evening
 * I am online available during the week (email, slack, zoom)
   * Can we agree on a Slack channel?
   * DE2 from last year?

## Exam

 * Presentation of your processor
   * On last Friday
   * A few slides
   * Demo in your FPGA board
 * Show me your code
 * No report needed
   * Just one page with names, title, abstract, and a link to your repo
   * Maybe your processsor has a name?

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

* Add the RR version of the `add` instruction and a `nop` instruction.
* Watch it in a waveform.

```asm
	addi	x1, x0, 0x111
	addi	x2, x0, 0x222
# missing forwarding
	nop
	nop
	nop
	add	x3, x1, x2
```

### Assemble that Program

 * You could assemble this manually and hardcode a Chisel `Vec()`.
 * You can also use Venus to assemble the program
 * Show it live
 * However, it is easier to use `gcc` (or `as`)

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

## Summary

 * Do small steps and test
 * Run an instruction through the pipeline
 * That's it for today from my side
 * Questions?

## Status Update

 * How is your `addi` instruction going?
 * How many stages have you planned?
 * How many stages have you implemented (even as fake stage)?
 * Did you aim for the minum viable product (MVP)?

## When to Start with Your FPGA Board?

 * Blinking LED is the embedded version of "Hello World"
   * If you can blink an LED, you can do everything
 * You need `bge` and `sw` for that, besides `addi` and `nop`
   * **That's it**
   * Can you write the code for this?
 * I showed once a blinking LED at the first review meeting of an EU project!
 * Aim for a blinking LED this week

## Debugging

 * During development to get stuff right
 * OK, to start with, but move on to real testing
 * Use the waveform viewer
 * Use `printf` in Chisel
 * *Watch* instructions through the pipeline

## Testing

 * Helps debugging during development, but is more
 * You can create a test suit that is run on evey code change
   * You can be more confident when you change stuff
     * Introduced bugs will (hopefully) be caught by the tests
   * More relaxed in doing refactoring
     * Remeber agile development  
   * Regression testing
   * GitHub CI on commit
     * Shall I show it?

## What to Test?

 * Individual components, such as:
   * ALU
   * Decode
   * Instruction fetch
 * Maybe?
   * Too much work?
   * Is it worth to test the addition in an ALU?
     * If you write '+' it will probabaly do an addition

## Testing a Processor

 * It is easier than unit testing
   * You *just* execute programs and check if they work
 * Is better than unit testing
    * You test the whole system
    * You test the interaction of the components
 * Two options:
   * Self testing programs
   * Cosimulation

## Self Testing Programs

 * Write your test programs with a known result
 * E.g., agree that all your tests will signal a pass with 0 in x1
 * You can check this in the simulation
   * With your ChiselTest or VHDL benchmark
* You can build up a collection of tests
  * Do some yourself
  * Use others (provided) later

## Example

 * We test the `add` and `addi` instructions

```
addi x1, x0, 0x123
addi x2, x0, 0x111
addi x3, x0, 0x222
add x1, x2, x3
addi x1, x1, -0x333
```

 * Shall finish with `0` in x1
 * Write your tests in Venus and *test the tests* on Venus

## Available Tests

 * From riscv-tests
 * From Ripes
   * Both use exit ecall to signal a result
 * From CAE
   * You know them
   * No siganlling of a result
   * You have a file with expected results in registers

## Cosimulation

 * You can run the same program on your processor and on a simulator
   * Simultor is called the golden model
   * Use your simulator from CAE :-)
 * Compare the results
 * You can use the execution trace to compare the results
 * Or run it in lockstep
 * Or use the traces Tjark provided

## Given Tests

- Three collections of test programs are provided
  - `tests/simple` contains some basic test cases for all RV32I instructions
    - The ones from the CAE course
  - `tests/ripes` contains some longer self-tests for most RV32I instructions
  - `tests/riscv-tests` contains thorough self-tests for all RV32I instructions from the official [riscv-tests](https://github.com/riscv-software-src/riscv-tests) repository
  
## Given Tests - II

  - The test programs exit via the unix exit system call (exit code 93 in `a7`) using the `ecall` instruction
  - The exit code can be found in the `a0` register
  - A `0` exit code means that the test finished successfully
  - A non-zero exit code means the test failed
  - `simple` and `riscv-tests` tests come with a `.res` file containing a dump of the register file after the program has finished

### Building the Tests

- Elf files and flat binaries are built before `sbt test` when running `make test`
- The output files are placed in the `build/simple`, `build/ripes` and `build/riscv-tests` directories
- Set the `CC` variable to your RISC-V GCC compiler in the [Makefile](Makefile?plain=1#L7)

### riscv-tests

- the `riscv-tests` are self tests which check results inside the test code
  - the test terminates with a exit system call
  - if one of the test cases failed, its number is placed in `a0` (1-indexed)
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

## Summary

 * Aim for an embedded *Hello World* in your FPGA board this week
   * With some real code that is blinking an LED
   * Only 4 instructions are needed
 * A processor is realtively easy to test just with programs
   * Just execute a program and check the result
   * Get at least on simple test running this week (result 0 in `x1`)
 * Other tests: known result in a register on an ecall
 * Cosimulation with a golden model (your CAE simulator)

## More Tips

 * Don't take the book literally
 * Don't take Ripes literally
 * The book contains errors
 * Ripes contains not the best drawings
 * Get the ideas and build y9our own
 * Use Bundeles (Chisel) or Records (VHDL) to group signals
 * Use enumerations instead of magic numbers

## Peripherals

- Two basic memory mapped peripherals are provided
  - LED controller
  - UART transceiver
- The peripherals are attached to a simple bus

### System Bus

| name    | width | description                                            |
|---------|-------|--------------------------------------------------------|
| `read`  | 1     | signal a read operation                                |
| `write` | 1     | signal a write operation                               |
| `addr`  | 32    | address for read or write                              |
| `wrData`| 32    | data to write                                          |
| `rdData`| 32    | result of read (valid one cycle after `read` is asserted) |

Use `Bus.RequestPort()` and `Bus.ResponsePort()` to create the IO Bundle

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

## Bootloader

 * The bootloader is a small program that is loaded into the instruction memory
 * It can then itself load a program into the instruction and data memory
 * This avoids resynthesizing the FPGA for each new program
 * The bootloader can be written in C
 * It communicates with the host computer via the serial port
  * You need a program on the host computer to send the program to the bootloader running on your RISC-V processor

## Using elf Executables

- Use the `lib.Executable` class to load an elf file and extract sections and the entry address

```scala
val exe = Executable.from("path/to/myElf.out")
val text = exe.getSection(".text")
text.getWords // returns a Seq[Long] of instructions
text.start // start address of the section
exe.getEntryPoint // returns the start PC of the program
```

