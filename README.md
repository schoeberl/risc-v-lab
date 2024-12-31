# **02114 - Design of a RISC-V Microprocessor**

This repository contains the material for the 3-week course **02114 - Design of a RISC-V Microprocessor** at the Technical University of Denmark (DTU).

This README file contains all the information related to the course. **Important note: Before starting with the design and implementation (i.e. coding), please read this document top-to-bottom, so you know the overall requirements, expectations, and suggestions.**

Content:
* [General course information](#general-course-information)
* [Your RISC-V microprocessor](#your-risc-v-microprocessor)
* [About peripherals](#about-peripherals)
* [Suggested work plan](#suggested-work-plan)
* [When to start with your FPGA board?](#when-to-start-with-your-fpga-board)
* [Notes, hints, and tips](#notes--hints--and-tips)
* [Testing and debugging](#testing-and-debugging)
* [More notes (advanced))](#more-notes-advanced)

## General course information
This section provides the practical information related to the course, such as aim, learning objectives, group forming, schedule, access to help, exam, etc.

### Aim

In this course, you will consolidate your knowledge and skills in computer architecture and digital hardware design by:
- Designing and implementing your **own** RISC-V microprocessor
- Running **your** processor in your Basys3 board (or an equivalent one)

### Learning objectives

A student who has met the objectives of the course will be able to:
- **Apply** the principles of pipelining and **leverage** its benefits in digital system design
- **Use** the RISC-V architecture, its instruction set, and its implementation in digital systems
- **Gain** proficiency in Chisel, a hardware construction language used for digital system design
- **Design** and **implement** each stage of a pipelined RISC-V processor on an FPGA
- **Use** simulation tools to verify the correctness of digital system designs
- **Gain** experience in debugging digital system designs
- **Work** effectively in small teams to design and implement a complex digital system
- **Integrate** individual designs into a fully functional pipelined RISC-V processor
- **Evaluate** the performance and quality of the final design based on various metrics

### Practicalities

Here is some general practical information about the course.
- The course will start **Monday, January 6th, 2025** at **10:00**
- The course will be in **Building 324 - Room 070**
- The room is reserved for the entire 3-week period from 8:00 to 17:00
- The room and the foyer of Building 324 are suitable for group work
- The last day of the course is **Friday, January 24th, 2025**, when we will have the exam (see more info below)

### Teaching and supervision

This is a practical course where you learn-by-doing. We will try to keep frontal teaching (i.e. lectures) to a minimum and we only have one scheduled one presentation on the first day of the course. Other frontal lectures can be scheduled if the need arises.

Overall, we expect that working independently, but we strongly encourage you to seek help whenever needed. In any case, we will have the following supervised sessions:

- Everyday **from 10:00 to 11:00**
- Everyday **from 14:00 to 15:00**

In addition, we will set up a discussion forum (Discord server) for you to ask questions, share ideas, and collaborate with your peers. The forum will also be actively monitored by the teacher to provide timely assistance. The forum access link will be announced on DTU-Learn.

### Group forming
The course work should be carried out in **groups of 4 people** (groups of 2 or 3 are also possible but less preferred). You are free to select your group members. **Groups should be registered as soon as possible in the DTU-Learn group forming facility.** If you experience difficulties forming a group, please contact the teacher.

When forming a new group, please make sure that you align expectations between the members. To achieve this, we recommend having a discussion about each member’s availability, work habits, and goals for the course to ensure a smooth and collaborative experience.

### Presence and review meetings

We recommend **being present** during course hours in the course classroom to make the most of the available resources and support.

During the course, we will have two review meetings to ensure you are on track and to provide you with feedback. These meetings will be an opportunity to discuss your progress, address any challenges, and get guidance from the teacher (and from your peers).

The review meetings are scheduled as follows:
- Review meeting 1: **Friday, January 10th, 2025**
- Review meeting 2: **Friday, January 17th, 2025**

At each meeting, you should be prepared to present your current progress, demonstrate any working components, and discuss any issues you are facing. We will announce the precise content of the meetings during the course.

The exact times and group schedule for these review meetings will be announced on DTU-Learn.

### Exam and deliverables
We will have the exam of the course on **Friday, January 24th, 2025** (the last day of the 3-week period).

The exam consists of the following:
- A presentation of your processor (give your processor a name)
- A demo of your processor on the FPGA board
- Highlights from your code

In addition, you are expected to hand-in the following deliverables:

- **Short report:** A short report describing your processor and your work. The report should not be longer than 4 pages (everything included). You are free to use your own template. In the following, you can find the expected structure of the report:
  - **Title**
  - **Group number**
  - **Names and student IDs of the group members**
  - **Contributions:** Clearly state what each team member contributed to the project. This section is crucial for evaluating individual contributions and ensuring fair grading.
  - **Introduction:** Briefly introduce your processor design.
  - **Design overview:** Summarize the key aspects of your processor design, including a block diagram.
  - **Implementation details:** Describe the main features of your implementation, focusing on how you translated your design into Chisel.
  - **Testing and evaluation:** Explain how you tested your design and comment on the results of the testing.

- **Source files:** All the source code of your implementation (and tests). It is fine to just have a link to a repository. Alternatively, you can hand in a zip file with the code. If you hand in the code as zip file, please only include the source code (not the generated files).

- **README file:** A README file that includes instructions on how to set up and run your processor on the FPGA, as well as how to run any test cases you developed.

All deliverables must be submitted via the DTU-Learn course assignment page at the following location: `DTU-Learn/Course content/Assignments/Short report`.

The deadline for the hand-in is **Thursday, January 23rd, 2025** at **midday**.

### Installing tools
You will use your own laptop for developing the project. 
Tools need to be installed to carry out hardware development. If you attended the course Digital Electronics 2, you likely already have the tools installed. Otherwise, you can follow the instruction given for the course Digital Electronics 2 page: [02139 Digital Electronics 2](https://github.com/schoeberl/risc-v-lab). Specifically, the Setup.md file contains detailed instructions: [Setup.md](https://github.com/schoeberl/chisel-lab/blob/master/Setup.md).

### FPGA board
If you have your own FPGA board, you are expected to use it in this course. If you do not have a board, you can borrow one of DTU's board for the duration of the course. Ask the teacher if you need to borrow a board.

## Your RISC-V microprocessor
This section outlines the objectives, requirements, and resources for designing your own RISC-V microprocessor.

### Main objective

In this course, you are required to implement a RISC-V processor from scratch. This includes the processor itself and some peripherals of your choice.

Please note that this course offers a lot of freedom in your approach to designing a RISC-V processor. Specifically, we decided to not provide a predefined hardware structure or template. You will be starting entirely from scratch. This is your chance to explore, experiment, and develop a processor that reflects your own design choices.

In summary, you are expected to:
 * Design and build a fully functional RISC-V microprocessor
 * Test it in simulation to ensure correctness
 * Implement it on an FPGA to verify hardware functionality
 * Develop and run demo programs to showcase its capabilities.

Please note that these objectives will be used for the evaluation (i.e. for the grading).

### Requirements

Here you can find some requirements for your design. Please read them **carefully**.
- The processor shall implement the RISC-V RV32I instruction set
- The processor shall be pipelined
- The processor shall be able to run a simple program in simulation and on an FPGA
- You are allowed (and we recommend) to split the memory into instruction and data memory
- No need to implement caches
- You do not need to support unaligned memory access
- You need to have at least one output peripheral (e.g., GPIO/LEDs, UART, 7-segment display, buttons, switches, etc.)

### Reading Material

- Andrew Waterman's PhD thesis on the RISC-V ISA: [Design of the RISC-V Instruction Set Architecture](https://www2.eecs.berkeley.edu/Pubs/TechRpts/2016/EECS-2016-1.html)
- The textbook [Computer Organization and Design RISC-V Edition](https://www.amazon.com/Computer-Organization-Design-RISC-V-Architecture/dp/0128203315):
 The Hardware Software Interface, 2nd Edition,
 by David A. Patterson (Author), John L. Hennessy (Author).

### Useful links

- The lab material for the CAE course at DTU: [02155 Computer Architecture and Engineering Lab](https://github.com/schoeberl/cae-lab)
- Material and installation instruction for the Digital Electronics 2 course at DTU: [02139 Digital Electronics 2](https://github.com/schoeberl/risc-v-lab)
- [The RISC-V Instruction Set Manual](https://riscv.org/specifications/)
- [Venus RV32I simulator](https://kvakil.github.io/venus/)
- [RIPES RISC-V simulator](https://github.com/mortbopet/Ripes)
- [RISC-V Green Card](https://dejazzer.com/coen2710/lectures/RISC-V-Reference-Data-Green-Card.pdf)
- [RISC-V Tools (GNU Toolchain, ISA Simulator, Tests)](https://github.com/riscv/riscv-tools)
- [Rocket Chip Generator (including the RISC- tools)](https://github.com/freechipsproject/rocket-chip)
- [A RISC-V tutorial](https://github.com/BrunoLevy/learn-fpga/blob/master/FemtoRV/TUTORIALS/FROM_BLINKER_TO_RISCV/README.md)

### DTU-Learn material

On DTU-Learn you can find the following additional resources:
- Slides on the RISC-V pipeline from course 02155
- Slides on memory, bus, and interfaces from course 02139

## About peripherals

Peripherals are an essential part of your RISC-V microprocessor system, providing the means for interaction with the external world. In this course, we offer two basic memory-mapped peripherals to get you started:

- **LED controller**: for LEDs control.
- **UART transceiver** for serial communication.

Both peripherals are connected to a **simple system bus**, allowing you to read and write data through memory-mapped IO.

This means that each peripheral is mapped to a specific address range in memory. By reading from or writing to these memory locations, you can interact with the peripheral’s functionality.

Please note: since the peripherals are memory mapped, you should interact with them using standard instructions like `lw` (load word) and `sw` (store word).

If you wish to extend your system with additional peripherals, feel free to experiment or reach out for guidance.

### System bus

The peripherals are connected through a bus with the following interface:

| name  | width | description                      |
|---------|-------|--------------------------------------------------------|
| `read` | 1   | signal a read operation                |
| `write` | 1   | signal a write operation                |
| `addr` | 32  | address for read or write               |
| `wrData`| 32  | data to write                     |
| `rdData`| 32  | result of read (valid one cycle after `read` is asserted) |

A timing diagram for the interface showing a write and read trasaction is shown in the following figure.

![A timing diagram of this interface showing a write and read trasaction.](./images/bus_timing.jpg)

Use `Bus.RequestPort()` and `Bus.ResponsePort()` to create the IO Bundle

### LED controller - Register map

| address | read              | write              |
|---------|--------------------------------|---------------------------------|
| 0x00  | read n-bit LED status     | set n-bit LED status      |

- Has only a single memory-mapped register with one bit per LED

### UART - Register map


| address | read              | write              |
|---------|--------------------------------|---------------------------------|
| 0x00  | read received data from buffer | write data to send into buffer |
| 0x04  | read UART status (bit 0: tx ready and bit 1: rx has data) | -  |


- Reading from address 0x00 will remove a character from the receive buffer. If the buffer is empty, no valid data is returned.
- Writing to address 0x00 will add a character to the transmit buffer. If the buffer is full, the character will be dropped.


### Connecting multiple peripherals
To integrate multiple peripherals into your system:
- Each device must be assigned its **own address range** (e.g., multiples of 1 kB).
- The system bus must direct `read` and `write` signals to the appropriate device based on the address.
- The routing decision must be retained to ensure the correct response is provided by the selected peripheral.
- Note: It is up to you to implement this!


## Suggested work plan

To build your RISC-V processor efficiently and incrementally, we suggest following this work plan. It is designed to help you start small, test frequently, and expand your design step by step while building a strong foundation for your microprocessor.

Begin with a **minimum viable product (MVP)** that focuses on achieving basic functionality:
- **Start with a single instruction** to establish the core pipeline behavior.
- Develop an MVP implementation of all pipeline stages:
 - **Fetch, Decode, Execute, Memory, Writeback**.
- Write **tests** to validate each pipeline stage and the instruction flow.
- Gradually **add more instructions** once the MVP is functional and tested.


### Fetching instructions

Implement the **instruction fetch stage** to read instructions into your pipeline:
- Start with a simple fetch mechanism that reads instructions from instruction memory (maybe a ROM at first).
- Use **simple assembler tests** to validate the fetch functionality (from CAE or others given).
- Compile assembler programs using tools like **RV GCC** or **Venus**.
- Load the compiled programs into the fetch stage and observe the execution using waveform viewers like **GTKWave** to debug and verify.

### Decode stage

Develop the decode stage to interpret the fetched instructions:
- Extract the **opcode** and **register numbers** from the instruction.
- Use a `switch` or equivalent logic to decode instructions and identify operations.
- Integrate the **register file** into the decode stage to provide input data for execution.
- Write tests to ensure decoding works correctly and handles valid instructions.

### Execute stage

Expand your pipeline with an execute stage:
- Start by implementing the **`addi` instruction** to handle simple arithmetic.
- Add an **Arithmetic Logic Unit (ALU)** to support additional operations like `add`, `sub`, and more.
- Write tests to validate the ALU functionality and the execution stage.

### Memory stage
Incorporate memory operations into your pipeline:
- Add support for **load (`lw`)** and **store (`sw`)** instructions.
- Ensure memory operations interact correctly with data memory.
- Write tests to verify that memory reads and writes function as expected.

### Writeback stage
- Implement the writeback stage
- Do we need a writeback stage?
- Let's discuss pipeline variations

 Complete the pipeline with the writeback stage:
- Implement logic to write results back to the register file.
- Feel free to explore **pipeline variations** to decide if a separate writeback stage is actually needed.
- Validate the full pipeline functionality by running instructions end-to-end.

### Start with a single instruction

To simplify development, begin with a single instruction:
- **Example:** `addi`
 ```asm
 addi x1, x0, 0x123
 ```
 - Assembles to `0x12300093`.
- Hardcode the instruction in the fetch stage for initial testing.
- Observe its progress through the pipeline and write tests to verify functionality.

### A simple initial program

Once the pipeline is functional for a single instruction, test it with a small program:
- Include additional instructions, such as `add` and `nop`, to simulate more complex execution scenarios.

**Example program:**
```asm
addi x1, x0, 0x111
addi x2, x0, 0x222
# missing forwarding
nop
nop
nop
add  x3, x1, x2
```
- Use waveform tools to monitor the instruction flow and debug any issues.

### Assemble the programs

Prepare programs for execution in your processor:
- Manually assemble simple programs and hardcode them using a Chisel `Vec()` for initial testing.
- Use tools like **Venus** for assembling programs.
- For larger programs, switch to `gcc` or `as` to streamline the compilation and loading process.

### Summary

- Focus on **small, incremental steps** and validate each stage with thorough testing.
- Start with a single instruction and expand the pipeline gradually.
- Observe instruction flow using waveform viewers and debug as needed.
- Testing frequently ensures reliability and confidence as your design grows.

## When to start with your FPGA board?

Aim to start as soon as possible.
- Blinking LED is the embedded version of "Hello World"
  - If you can blink an LED, you can do everything
- You need `bge` and `sw` for that, besides `addi` and `nop`
  - **That's it!**
  - Can you write the code for this?
- Aim for a blinking LED at the end of the 1st week of the course.

## Notes, hints, and tips

Here are some key suggestions and best practices to guide you through your processor design:

### 1. Pipeline design:
 - Place pipeline registers at the **input of each stage** for simplicity.
 - For the memory and register file stages, having a register at the input is particularly helpful.

### 2. Register file debugging:
 - Use a **Reg** for the register file during debugging:
 ```scala
 RegInit(VecInit(Seq.fill(32)(0.U(32.W))))
 ```
 - For improved performance and resource efficiency, transition to **on-chip memory**:
 ```scala
 SyncReadMem(32, UInt(32.W))
 ```

### 3. Handling data hazards:
 - **Stalling** can be used to address data hazards, but it may affect performance.
 - **Forwarding** is a more efficient solution and provides better overall performance.

### 4. Testing and integration:
 - Begin testing and integrating components **from day one** to identify and resolve issues early.

### 5. Interpret resources critically:
 - Use the provided resources as inspiration to develop your own implementation.

### 6. Design documentation:
 - Always **draw a block diagram**:
  - It will help you understand and communicate your design.
  - Include it in your abstract or presentation.

### 7. Signal management:
 - Use **Bundles** (Chisel) or **records** (VHDL) to group signals logically and cleanly.
 - Replace magic numbers with **enumerations** for readability and maintainability:
  - Example: Use `op_add` instead of `123`.


## Testing and debugging
Testing and debugging are essential to ensure your RISC-V processor functions correctly. Here are some tips and strategies to help you debug issues effectively and test your design thoroughly.

Use debugging tools and techniques to get things working during the early stages:
- Visualize signals and behavior with a waveform viewer.
- Add `printf` statements in Chisel to monitor signals and observe pipeline activity.
- **Watch** instructions move through the pipeline step by step to pinpoint issues.


### Testing
- Helps debugging during development
- You can create a test suit that is run on every code change
  - You can be more confident when you change stuff
  - Introduced bugs will (hopefully) be caught by the tests
- Advanced: Regression testing
- Advanced: GitHub CI on commit

### What to Test?
- Focus on testing individual components first, such as:
  - ALU
  - Decode Stage
  - Instruction Fetch
- Consider whether testing certain details is worthwhile:
 - Example: Do you need to test addition in an ALU? If you wrote `+`, it likely works as intended.


### Testing a processor

- Testing a processor is easier than unit testing
  - You *just* execute programs and check if they work
- Is better than unit testing
  - You test the whole system
  - You test the interaction of the components
- Two options:
  - Self-testing programs
  - Cosimulation

### Self-Testing Programs

- Write your test programs with a known result
- E.g., agree that all your tests will signal a pass with 0 in x1
- You can check this in the simulation
  - With your ChiselTest or VHDL benchmark
- You can build up a collection of tests
  - Do some yourself
  - Use others (provided) later

For example, to test the `add` and `addi` instructions

```
addi x1, x0, 0x123
addi x2, x0, 0x111
addi x3, x0, 0x222
add x1, x2, x3
addi x1, x1, -0x333
```

- Shall finish with `0` in x1
- Write your tests in Venus and *test the tests* on Venus

### Available Tests

- From riscv-tests
- From Ripes
  - Both use exit ecall to signal a result
- From CAE (course 02155)
  - You know them
  - No siganlling of a result
  - You have a file with expected results in registers

### Cosimulation (advanced)

- You can run the same program on your processor and on a simulator
  - Simulator is called the golden model
  - Use your simulator from CAE :-)
- Compare the results
- You can use the execution trace to compare the results
- Or run it in lockstep
- Or use the traces provided

### Given Tests

- Three collections of test programs are provided
 - `tests/simple` contains some basic test cases for all RV32I instructions
  - The ones from the CAE course
 - `tests/ripes` contains some longer self-tests for most RV32I instructions
 - `tests/riscv-tests` contains thorough self-tests for all RV32I instructions from the official [riscv-tests](https://github.com/riscv-software-src/riscv-tests) repository
 - The test programs exit via the unix exit system call (exit code 93 in `a7`) using the `ecall` instruction
 - The exit code can be found in the `a0` register
 - A `0` exit code means that the test finished successfully
 - A non-zero exit code means the test failed
 - `simple` and `riscv-tests` tests come with a `.res` file containing a dump of the register file after the program has finished

### Building the Tests (advanced)

- Elf files and flat binaries are built before `sbt test` when running `make test`
- The output files are placed in the `build/simple`, `build/ripes` and `build/riscv-tests` directories
- Set the `CC` variable to your RISC-V GCC compiler in the [Makefile](Makefile?plain=1#L7)

### The riscv-tests (advanced)

- the `riscv-tests` are self-tests which check results inside the test code
  - the test terminates with an exit system call
  - if one of the test cases fails, its number is placed in `a0` (1-indexed)
  - the self-testing functionality relies on compare and branch instructions

### The riscv-tests - Execution Traces (advanced)

- Each riscv-test program also comes with a `.csv` file containing an execution trace
- One line contains the following information:
  - `pc;instr_word;assembly;wb_dest;wb_value;mem_addr;mem_wr_data\n`
  - If no write back, load, or store occurs, the corresponding fields are left empty
- Example: this load instruction sets x14 to 0xF00F by loading a halfword from address 0x80001006
  - `800000f8;60d703;lhu a4, 6(ra);14;f00f;80001006;\n`
- The execution traces can be used to check the correct execution of the programs step by step, like in a co-simulation
- Attention has to be given to stalls in your pipeline, since the trace was executed on a single-cycle processor

## More notes (advanced)
### Bootloader (advanced)

The bootloader is a small program that is loaded into the instruction memory
- It can load a program into the instruction and data memory
- This avoids resynthesizing the FPGA for each new program
- The bootloader can be written in C
- It communicates with the host computer via the serial port
  - You need a program on the host computer to send the program to the bootloader running on your RISC-V processor

A simplified version of a bootloader consists of using a state machine to:
- Receive a program from the host computer via the serial port
- Write it into the instruction memory
- Start the program

Here, you can have a Java/Scala program to send the program:
- Byte by byte
- Use a magic number to mark the end of the byte stream

### Using elf executables

- Use the `lib.Executable` class to load an elf file and extract sections and the entry address

```scala
val exe = Executable.from("path/to/myElf.out")
val text = exe.getSection(".text")
text.getWords // returns a Seq[Long] of instructions
text.start // start address of the section
exe.getEntryPoint // returns the start PC of the program
```

- See the `build.sbt` how to add this library to your project
