# See LICENSE for license details.

#*****************************************************************************
# slt8.S
#-----------------------------------------------------------------------------
#
# Test slt8 instruction.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  TEST_RR_OP( 2,  slt8, 0x00000000, 0x00000000, 0x00000000 );
  TEST_RR_OP( 3,  slt8, 0x00000000, 0x01010101, 0x01010101 );
  TEST_RR_OP( 4,  slt8, 0xffffffff, 0x03030303, 0x07070707 );
  TEST_RR_OP( 5,  slt8, 0x00000000, 0x07070707, 0x03030303 );

  TEST_RR_OP( 6,  slt8, 0x00000000, 0x00000000, 0xf8f8f8f8 );
  TEST_RR_OP( 7,  slt8, 0xffffffff, 0xf8f8f8f8, 0x00000000 );
  TEST_RR_OP( 8,  slt8, 0xffffffff, 0xf0f0f0f0, 0xf8f8f8f8 );

  TEST_RR_OP( 9,  slt8, 0xffffffff, 0x00000000, 0x7f7f7f7f );
  TEST_RR_OP( 10, slt8, 0x00000000, 0x7f7f7f7f, 0x00000000 );
  TEST_RR_OP( 11, slt8, 0x00000000, 0x7f7f7f7f, 0x1f1f1f1f );

  TEST_RR_OP( 12, slt8, 0xffffffff, 0xf8f8f8f8, 0x7f7f7f7f );
  TEST_RR_OP( 13, slt8, 0x00000000, 0x7f7f7f7f, 0xf8f8f8f8 );

  TEST_RR_OP( 14, slt8, 0x00000000, 0x00000000, 0xffffffff );
  TEST_RR_OP( 15, slt8, 0xffffffff, 0xffffffff, 0x01010101 );
  TEST_RR_OP( 16, slt8, 0x00000000, 0xffffffff, 0xffffffff );

  TEST_RR_OP( 17, slt8, 0xff0000ff, 0xf8f8f8f8, 0xf9f0f0f9 );
  TEST_RR_OP( 18, slt8, 0x00ffff00, 0xf8f8f8f8, 0xf0f9f9f0 );
  TEST_RR_OP( 19, slt8, 0x00ffff00, 0x03030303, 0x02121202 );
  TEST_RR_OP( 20, slt8, 0xff0000ff, 0x03030303, 0x12020212 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 21, slt8, 0xffffffff, 0x0f0f0f0f, 0x1f1f1f1f );
  TEST_RR_SRC2_EQ_DEST( 22, slt8, 0x00000000, 0x2c2c2c2c, 0x1f1f1f1f );
  TEST_RR_SRC12_EQ_DEST( 23, slt8, 0x00000000, 0x0f0f0f0f );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RR_DEST_BYPASS( 24, 0, slt8, 0xffffffff, 0x1d1d1d1d, 0x1f1f1f1f );
  TEST_RR_DEST_BYPASS( 25, 1, slt8, 0x00000000, 0x20202020, 0x1f1f1f1f );
  TEST_RR_DEST_BYPASS( 26, 2, slt8, 0xffffffff, 0x1e1e1e1e, 0x1f1f1f1f );

  TEST_RR_SRC12_BYPASS( 27, 0, 0, slt8, 0x00000000, 0x20202020, 0x1f1f1f1f );
  TEST_RR_SRC12_BYPASS( 28, 0, 1, slt8, 0xffffffff, 0x1d1d1d1d, 0x1f1f1f1f );
  TEST_RR_SRC12_BYPASS( 29, 0, 2, slt8, 0x00000000, 0x21212121, 0x1f1f1f1f );
  TEST_RR_SRC12_BYPASS( 30, 1, 0, slt8, 0xffffffff, 0x1c1c1c1c, 0x1f1f1f1f );
  TEST_RR_SRC12_BYPASS( 31, 1, 1, slt8, 0x00000000, 0x22222222, 0x1f1f1f1f );
  TEST_RR_SRC12_BYPASS( 32, 2, 0, slt8, 0xffffffff, 0x1b1b1b1b, 0x1f1f1f1f );

  TEST_RR_SRC21_BYPASS( 33, 0, 0, slt8, 0x00000000, 0x23232323, 0x1f1f1f1f );
  TEST_RR_SRC21_BYPASS( 34, 0, 1, slt8, 0xffffffff, 0x1a1a1a1a, 0x1f1f1f1f );
  TEST_RR_SRC21_BYPASS( 35, 0, 2, slt8, 0x00000000, 0x24242424, 0x1f1f1f1f );
  TEST_RR_SRC21_BYPASS( 36, 1, 0, slt8, 0xffffffff, 0x19191919, 0x1f1f1f1f );
  TEST_RR_SRC21_BYPASS( 37, 1, 1, slt8, 0x00000000, 0x25252525, 0x1f1f1f1f );
  TEST_RR_SRC21_BYPASS( 38, 2, 0, slt8, 0xffffffff, 0x18181818, 0x1f1f1f1f );

  TEST_RR_ZEROSRC1( 39, slt8, 0x00000000, 0xffffffff );
  TEST_RR_ZEROSRC2( 40, slt8, 0xffffffff, 0xffffffff );
  TEST_RR_ZEROSRC12( 41, slt8, 0x00000000 );
  TEST_RR_ZERODEST( 42, slt8, 0x1c1c1c1c, 0x3f3f3f3f );

  TEST_PASSFAIL
