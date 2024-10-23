# 0 "isa/rv32ui/ori.S"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "isa/rv32ui/ori.S"
# See LICENSE for license details.

# 1 "env/student/riscv_test.h" 1





# 1 "env/student/../encoding.h" 1
# 7 "env/student/riscv_test.h" 2
# 4 "isa/rv32ui/ori.S" 2



# 1 "isa/rv32ui/../rv64ui/ori.S" 1
# See LICENSE for license details.

#*****************************************************************************
# ori.S
#-----------------------------------------------------------------------------

# Test ori instruction.



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
# 12 "isa/rv32ui/../rv64ui/ori.S" 2

.macro init; .endm
.section .text; .global _start; _start: li x1, 0; li x2, 0; li x3, 0; li x4, 0; li x5, 0; li x6, 0; li x7, 0; li x8, 0; li x9, 0; li x10, 0; li x11, 0; li x12, 0; li x13, 0; li x14, 0; li x15, 0; li x16, 0; li x17, 0; li x18, 0; li x19, 0; li x20, 0; li x21, 0; li x22, 0; li x23, 0; li x24, 0; li x25, 0; li x26, 0; li x27, 0; li x28, 0; li x29, 0; li x30, 0; li x31, 0;; li gp, 0;

  #-------------------------------------------------------------
  # Logical tests
  #-------------------------------------------------------------

  test_2: li gp, 2; li x1, ((0xffffffffff00ff00) & ((1 << (32 - 1) << 1) - 1)); ori x14, x1, ((0xf0f) | (-(((0xf0f) >> 11) & 1) << 11));; li x7, ((0xffffffffffffff0f) & ((1 << (32 - 1) << 1) - 1)); bne x14, x7, fail;;
  test_3: li gp, 3; li x1, ((0x000000000ff00ff0) & ((1 << (32 - 1) << 1) - 1)); ori x14, x1, ((0x0f0) | (-(((0x0f0) >> 11) & 1) << 11));; li x7, ((0x000000000ff00ff0) & ((1 << (32 - 1) << 1) - 1)); bne x14, x7, fail;;
  test_4: li gp, 4; li x1, ((0x0000000000ff00ff) & ((1 << (32 - 1) << 1) - 1)); ori x14, x1, ((0x70f) | (-(((0x70f) >> 11) & 1) << 11));; li x7, ((0x0000000000ff07ff) & ((1 << (32 - 1) << 1) - 1)); bne x14, x7, fail;;
  test_5: li gp, 5; li x1, ((0xfffffffff00ff00f) & ((1 << (32 - 1) << 1) - 1)); ori x14, x1, ((0x0f0) | (-(((0x0f0) >> 11) & 1) << 11));; li x7, ((0xfffffffff00ff0ff) & ((1 << (32 - 1) << 1) - 1)); bne x14, x7, fail;;

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  test_6: li gp, 6; li x1, ((0xff00ff00) & ((1 << (32 - 1) << 1) - 1)); ori x1, x1, ((0x0f0) | (-(((0x0f0) >> 11) & 1) << 11));; li x7, ((0xff00fff0) & ((1 << (32 - 1) << 1) - 1)); bne x1, x7, fail;;

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  test_7: li gp, 7; li x4, 0; 1: li x1, ((0x000000000ff00ff0) & ((1 << (32 - 1) << 1) - 1)); ori x14, x1, ((0x0f0) | (-(((0x0f0) >> 11) & 1) << 11)); addi x6, x14, 0; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x7, ((0x000000000ff00ff0) & ((1 << (32 - 1) << 1) - 1)); bne x6, x7, fail;;
  test_8: li gp, 8; li x4, 0; 1: li x1, ((0x0000000000ff00ff) & ((1 << (32 - 1) << 1) - 1)); ori x14, x1, ((0x70f) | (-(((0x70f) >> 11) & 1) << 11)); nop; addi x6, x14, 0; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x7, ((0x0000000000ff07ff) & ((1 << (32 - 1) << 1) - 1)); bne x6, x7, fail;;
  test_9: li gp, 9; li x4, 0; 1: li x1, ((0xfffffffff00ff00f) & ((1 << (32 - 1) << 1) - 1)); ori x14, x1, ((0x0f0) | (-(((0x0f0) >> 11) & 1) << 11)); nop; nop; addi x6, x14, 0; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x7, ((0xfffffffff00ff0ff) & ((1 << (32 - 1) << 1) - 1)); bne x6, x7, fail;;

  test_10: li gp, 10; li x4, 0; 1: li x1, ((0x000000000ff00ff0) & ((1 << (32 - 1) << 1) - 1)); ori x14, x1, ((0x0f0) | (-(((0x0f0) >> 11) & 1) << 11)); addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x7, ((0x000000000ff00ff0) & ((1 << (32 - 1) << 1) - 1)); bne x14, x7, fail;;
  test_11: li gp, 11; li x4, 0; 1: li x1, ((0x0000000000ff00ff) & ((1 << (32 - 1) << 1) - 1)); nop; ori x14, x1, ((0xf0f) | (-(((0xf0f) >> 11) & 1) << 11)); addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x7, ((0xffffffffffffffff) & ((1 << (32 - 1) << 1) - 1)); bne x14, x7, fail;;
  test_12: li gp, 12; li x4, 0; 1: li x1, ((0xfffffffff00ff00f) & ((1 << (32 - 1) << 1) - 1)); nop; nop; ori x14, x1, ((0x0f0) | (-(((0x0f0) >> 11) & 1) << 11)); addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x7, ((0xfffffffff00ff0ff) & ((1 << (32 - 1) << 1) - 1)); bne x14, x7, fail;;

  test_13: li gp, 13; ori x1, x0, ((0x0f0) | (-(((0x0f0) >> 11) & 1) << 11));; li x7, ((0x0f0) & ((1 << (32 - 1) << 1) - 1)); bne x1, x7, fail;;
  test_14: li gp, 14; li x1, ((0x00ff00ff) & ((1 << (32 - 1) << 1) - 1)); ori x0, x1, ((0x70f) | (-(((0x70f) >> 11) & 1) << 11));; li x7, ((0) & ((1 << (32 - 1) << 1) - 1)); bne x0, x7, fail;;

  bne x0, gp, pass; fail: mv a0, gp; li a7, 93; ecall;; pass: li a0, 0; li a7, 93; ecall;



  .data
 .align 4; .global begin_signature; begin_signature:

 

.align 4; .global end_signature; end_signature:
# 8 "isa/rv32ui/ori.S" 2
