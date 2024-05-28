# See LICENSE for license details.

#*****************************************************************************
# sll16.S
#-----------------------------------------------------------------------------
#
# Test sll16 instruction.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  TEST_RR_OP( 2,  sll16, 0x00010001, 0x00010001, 0x00000000 );
  TEST_RR_OP( 3,  sll16, 0x00020002, 0x00010001, 0x00010001 );
  TEST_RR_OP( 4,  sll16, 0x01000100, 0x00010001, 0x00080008 );
  TEST_RR_OP( 5,  sll16, 0x04000400, 0x00010001, 0x000a000a );
  TEST_RR_OP( 6,  sll16, 0x80008000, 0x00010001, 0x000f000f );

  TEST_RR_OP( 7,  sll16, 0xffffffff, 0xffffffff, 0x00000000 );
  TEST_RR_OP( 8,  sll16, 0xfffefffe, 0xffffffff, 0x00010001 );
  TEST_RR_OP( 9,  sll16, 0xff00ff00, 0xffffffff, 0x00080008 );
  TEST_RR_OP( 10, sll16, 0xfc00fc00, 0xffffffff, 0x000a000a );
  TEST_RR_OP( 11, sll16, 0x80008000, 0xffffffff, 0x000f000f );

  TEST_RR_OP( 12, sll16, 0x00050005, 0x00050005, 0x00000000 );
  TEST_RR_OP( 13, sll16, 0x000a000a, 0x00050005, 0x00010001 );
  TEST_RR_OP( 14, sll16, 0x05000500, 0x00050005, 0x00080008 );
  TEST_RR_OP( 15, sll16, 0x14001400, 0x00050005, 0x000a000a );
  TEST_RR_OP( 16, sll16, 0x80008000, 0x00050005, 0x000f000f );

  # Verify that shifts only use bottom four bits of 16 bit data

  TEST_RR_OP( 17, sll16, 0x00050005, 0x00050005, 0xfff0fff0 );
  TEST_RR_OP( 18, sll16, 0x05000500, 0x00050005, 0xfff8fff8 );
  TEST_RR_OP( 19, sll16, 0x14001400, 0x00050005, 0xfffafffa );
  TEST_RR_OP( 20, sll16, 0x80008000, 0x00050005, 0xffffffff );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 21, sll16, 0x01000100, 0x00010001, 0x00080008 );
  TEST_RR_SRC2_EQ_DEST( 22, sll16, 0x04000400, 0x00010001, 0x000a000a );
  TEST_RR_SRC12_EQ_DEST( 23, sll16, 0x03800380, 0x00070007 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RR_DEST_BYPASS( 24, 0, sll16, 0x01000100, 0x00010001, 0x00080008 );
  TEST_RR_DEST_BYPASS( 25, 1, sll16, 0x04000400, 0x00010001, 0x000a000a );
  TEST_RR_DEST_BYPASS( 26, 2, sll16, 0x80008000, 0x00010001, 0x000f000f );

  TEST_RR_SRC12_BYPASS( 27, 0, 0, sll16, 0x01000100, 0x00010001, 0x00080008 );
  TEST_RR_SRC12_BYPASS( 28, 0, 1, sll16, 0x04000400, 0x00010001, 0x000a000a );
  TEST_RR_SRC12_BYPASS( 29, 0, 2, sll16, 0x80008000, 0x00010001, 0x000f000f );
  TEST_RR_SRC12_BYPASS( 30, 1, 0, sll16, 0x01000100, 0x00010001, 0x00080008 );
  TEST_RR_SRC12_BYPASS( 31, 1, 1, sll16, 0x04000400, 0x00010001, 0x000a000a );
  TEST_RR_SRC12_BYPASS( 32, 2, 0, sll16, 0x80008000, 0x00010001, 0x000f000f );

  TEST_RR_SRC21_BYPASS( 33, 0, 0, sll16, 0x01000100, 0x00010001, 0x00080008 );
  TEST_RR_SRC21_BYPASS( 34, 0, 1, sll16, 0x04000400, 0x00010001, 0x000a000a );
  TEST_RR_SRC21_BYPASS( 35, 0, 2, sll16, 0x80008000, 0x00010001, 0x000f000f );
  TEST_RR_SRC21_BYPASS( 36, 1, 0, sll16, 0x01000100, 0x00010001, 0x00080008 );
  TEST_RR_SRC21_BYPASS( 37, 1, 1, sll16, 0x04000400, 0x00010001, 0x000a000a );
  TEST_RR_SRC21_BYPASS( 38, 2, 0, sll16, 0x80008000, 0x00010001, 0x000f000f );

  TEST_RR_ZEROSRC1( 39, sll16, 0x00000000, 0x05050505 );
  TEST_RR_ZEROSRC2( 40, sll16, 0x80008000, 0x80008000 );
  TEST_RR_ZEROSRC12( 41, sll16, 0x00000000 );
  TEST_RR_ZERODEST( 42, sll16, 0x10001000, 0xffffffff );

  TEST_PASSFAIL

