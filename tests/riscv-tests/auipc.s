# 0 "isa/rv32ui/auipc.S"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "isa/rv32ui/auipc.S"
# See LICENSE for license details.

# 1 "env/student/riscv_test.h" 1





# 1 "env/student/../encoding.h" 1
# 7 "env/student/riscv_test.h" 2
# 4 "isa/rv32ui/auipc.S" 2



# 1 "isa/rv32ui/../rv64ui/auipc.S" 1
# See LICENSE for license details.

#*****************************************************************************
# auipc.S
#-----------------------------------------------------------------------------

# Test auipc instruction.



# 1 "isa/macros/scalar/test_macros.h" 1






#-----------------------------------------------------------------------
# Helper macros
#-----------------------------------------------------------------------
# 20 "isa/macros/scalar/test_macros.h"
# We use a macro hack to simpify code generation for various numbers
# of bubble cycles.
# 36 "isa/macros/scalar/test_macros.h"
#-----------------------------------------------------------------------
# RV64UI MACROS
#-----------------------------------------------------------------------

#-----------------------------------------------------------------------
# Tests for instructions with immediate operand
#-----------------------------------------------------------------------
# 92 "isa/macros/scalar/test_macros.h"
#-----------------------------------------------------------------------
# Tests for an instruction with register operands
#-----------------------------------------------------------------------
# 120 "isa/macros/scalar/test_macros.h"
#-----------------------------------------------------------------------
# Tests for an instruction with register-register operands
#-----------------------------------------------------------------------
# 214 "isa/macros/scalar/test_macros.h"
#-----------------------------------------------------------------------
# Test memory instructions
#-----------------------------------------------------------------------
# 347 "isa/macros/scalar/test_macros.h"
#-----------------------------------------------------------------------
# Test jump instructions
#-----------------------------------------------------------------------
# 376 "isa/macros/scalar/test_macros.h"
#-----------------------------------------------------------------------
# RV64UF MACROS
#-----------------------------------------------------------------------

#-----------------------------------------------------------------------
# Tests floating-point instructions
#-----------------------------------------------------------------------
# 735 "isa/macros/scalar/test_macros.h"
#-----------------------------------------------------------------------
# Pass and fail code (assumes test num is in gp)
#-----------------------------------------------------------------------
# 747 "isa/macros/scalar/test_macros.h"
#-----------------------------------------------------------------------
# Test data section
#-----------------------------------------------------------------------
# 12 "isa/rv32ui/../rv64ui/auipc.S" 2

.macro init; .endm
.section .text; .global _start; _start: li x1, 0; li x2, 0; li x3, 0; li x4, 0; li x5, 0; li x6, 0; li x7, 0; li x8, 0; li x9, 0; li x10, 0; li x11, 0; li x12, 0; li x13, 0; li x14, 0; li x15, 0; li x16, 0; li x17, 0; li x18, 0; li x19, 0; li x20, 0; li x21, 0; li x22, 0; li x23, 0; li x24, 0; li x25, 0; li x26, 0; li x27, 0; li x28, 0; li x29, 0; li x30, 0; li x31, 0;; li gp, 0;

  test_2: li gp, 2; .align 3; lla a0, 1f + 10000; jal a1, 1f; 1: sub a0, a0, a1;; li x7, ((10000) & ((1 << (32 - 1) << 1) - 1)); bne a0, x7, fail;






  test_3: li gp, 3; .align 3; lla a0, 1f - 10000; jal a1, 1f; 1: sub a0, a0, a1;; li x7, ((-10000) & ((1 << (32 - 1) << 1) - 1)); bne a0, x7, fail;






  bne x0, gp, pass; fail: mv a0, gp; li a7, 93; ecall;; pass: li a0, 1; li a7, 93; ecall;



  .data
 .align 4; .global begin_signature; begin_signature:

 

.align 4; .global end_signature; end_signature:
# 8 "isa/rv32ui/auipc.S" 2
