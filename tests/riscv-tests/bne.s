# 0 "isa/rv32ui/bne.S"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "isa/rv32ui/bne.S"
# See LICENSE for license details.

# 1 "env/student/riscv_test.h" 1





# 1 "env/student/../encoding.h" 1
# 7 "env/student/riscv_test.h" 2
# 4 "isa/rv32ui/bne.S" 2



# 1 "isa/rv32ui/../rv64ui/bne.S" 1
# See LICENSE for license details.

#*****************************************************************************
# bne.S
#-----------------------------------------------------------------------------

# Test bne instruction.



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
# 12 "isa/rv32ui/../rv64ui/bne.S" 2

.macro init; .endm
.section .text; .global _start; _start: li x1, 0; li x2, 0; li x3, 0; li x4, 0; li x5, 0; li x6, 0; li x7, 0; li x8, 0; li x9, 0; li x10, 0; li x11, 0; li x12, 0; li x13, 0; li x14, 0; li x15, 0; li x16, 0; li x17, 0; li x18, 0; li x19, 0; li x20, 0; li x21, 0; li x22, 0; li x23, 0; li x24, 0; li x25, 0; li x26, 0; li x27, 0; li x28, 0; li x29, 0; li x30, 0; li x31, 0;; li gp, 0;

  #-------------------------------------------------------------
  # Branch tests
  #-------------------------------------------------------------

  # Each test checks both forward and backward branches

  test_2: li gp, 2; li x1, 0; li x2, 1; bne x1, x2, 2f; bne x0, gp, fail; 1: bne x0, gp, 3f; 2: bne x1, x2, 1b; bne x0, gp, fail; 3:;
  test_3: li gp, 3; li x1, 1; li x2, 0; bne x1, x2, 2f; bne x0, gp, fail; 1: bne x0, gp, 3f; 2: bne x1, x2, 1b; bne x0, gp, fail; 3:;
  test_4: li gp, 4; li x1, -1; li x2, 1; bne x1, x2, 2f; bne x0, gp, fail; 1: bne x0, gp, 3f; 2: bne x1, x2, 1b; bne x0, gp, fail; 3:;
  test_5: li gp, 5; li x1, 1; li x2, -1; bne x1, x2, 2f; bne x0, gp, fail; 1: bne x0, gp, 3f; 2: bne x1, x2, 1b; bne x0, gp, fail; 3:;

  test_6: li gp, 6; li x1, 0; li x2, 0; bne x1, x2, 1f; bne x0, gp, 2f; 1: bne x0, gp, fail; 2: bne x1, x2, 1b; 3:;
  test_7: li gp, 7; li x1, 1; li x2, 1; bne x1, x2, 1f; bne x0, gp, 2f; 1: bne x0, gp, fail; 2: bne x1, x2, 1b; 3:;
  test_8: li gp, 8; li x1, -1; li x2, -1; bne x1, x2, 1f; bne x0, gp, 2f; 1: bne x0, gp, fail; 2: bne x1, x2, 1b; 3:;

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  test_9: li gp, 9; li x4, 0; 1: li x1, 0; li x2, 0; bne x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_10: li gp, 10; li x4, 0; 1: li x1, 0; li x2, 0; nop; bne x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_11: li gp, 11; li x4, 0; 1: li x1, 0; li x2, 0; nop; nop; bne x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_12: li gp, 12; li x4, 0; 1: li x1, 0; nop; li x2, 0; bne x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_13: li gp, 13; li x4, 0; 1: li x1, 0; nop; li x2, 0; nop; bne x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_14: li gp, 14; li x4, 0; 1: li x1, 0; nop; nop; li x2, 0; bne x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;

  test_15: li gp, 15; li x4, 0; 1: li x1, 0; li x2, 0; bne x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_16: li gp, 16; li x4, 0; 1: li x1, 0; li x2, 0; nop; bne x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_17: li gp, 17; li x4, 0; 1: li x1, 0; li x2, 0; nop; nop; bne x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_18: li gp, 18; li x4, 0; 1: li x1, 0; nop; li x2, 0; bne x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_19: li gp, 19; li x4, 0; 1: li x1, 0; nop; li x2, 0; nop; bne x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_20: li gp, 20; li x4, 0; 1: li x1, 0; nop; nop; li x2, 0; bne x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;

  #-------------------------------------------------------------
  # Test delay slot instructions not executed nor bypassed
  #-------------------------------------------------------------

  test_21: li gp, 21; li x1, 1; bne x1, x0, 1f; addi x1, x1, 1; addi x1, x1, 1; addi x1, x1, 1; addi x1, x1, 1; 1: addi x1, x1, 1; addi x1, x1, 1;; li x7, ((3) & ((1 << (32 - 1) << 1) - 1)); bne x1, x7, fail;
# 64 "isa/rv32ui/../rv64ui/bne.S"
  bne x0, gp, pass; fail: mv a0, gp; li a7, 93; ecall;; pass: li a0, 1; li a7, 93; ecall;



  .data
 .align 4; .global begin_signature; begin_signature:

 

.align 4; .global end_signature; end_signature:
# 8 "isa/rv32ui/bne.S" 2
