# See LICENSE for license details.

#*****************************************************************************
# add16.S
#-----------------------------------------------------------------------------
#
# Test add16 instruction.
#

#include <riscv_test.h>
#include <test_macros.h>

RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  TEST_RR_OP( 2,  add16, 0x00000000, 0x00000000, 0x00000000 );
  TEST_RR_OP( 3,  add16, 0x02020202, 0x01010101, 0x01010101 );
  TEST_RR_OP( 4,  add16, 0x0a0a0a0a, 0x03030303, 0x07070707 );

  TEST_RR_OP( 5,  add16, 0xf8000000, 0x00000000, 0xf8000000 );
  TEST_RR_OP( 6,  add16, 0xf800f800, 0xf800f800, 0x00000000 );
  TEST_RR_OP( 7,  add16, 0x00f800f8, 0x00000000, 0x00f800f8 );
  TEST_RR_OP( 8,  add16, 0x00f800f8, 0x00f800f8, 0x00000000 );

  TEST_RR_OP( 9,  add16, 0x04020402, 0x0c010c01, 0xf801f801 );
  TEST_RR_OP( 10, add16, 0x01040104, 0x000c000c, 0x00f800f8 );
  TEST_RR_OP( 11, add16, 0xffffffff, 0x88777788, 0x77888877 );
  TEST_RR_OP( 12, add16, 0xffffffff, 0x77888877, 0x88777788 );

  TEST_RR_OP( 13, add16, 0xffffffff, 0x00000000, 0xffffffff );
  TEST_RR_OP( 14, add16, 0x01000100, 0xffffffff, 0x01010101 );
  TEST_RR_OP( 15, add16, 0xfffefffe, 0xffffffff, 0xffffffff );

  TEST_RR_OP( 16, add16, 0x80808080, 0x01010101, 0x7f7f7f7f );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 17, add16, 0x19181918, 0x0d8d0d8d, 0x0b8b0b8b );
  TEST_RR_SRC2_EQ_DEST( 18, add16, 0x1a191a19, 0x0e8e0e8e, 0x0b8b0b8b );
  TEST_RR_SRC12_EQ_DEST( 19, add16, 0x1b1a1b1a, 0x0d8d0d8d );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RR_DEST_BYPASS( 20, 0, add16, 0x19181918, 0x0d8d0d8d, 0x0b8b0b8b );
  TEST_RR_DEST_BYPASS( 21, 1, add16, 0x1a191a19, 0x0e8e0e8e, 0x0b8b0b8b );
  TEST_RR_DEST_BYPASS( 22, 2, add16, 0x1b1a1b1a, 0x0f8f0f8f, 0x0b8b0b8b );

  TEST_RR_SRC12_BYPASS( 23, 0, 0, add16, 0x19181918, 0x0d8d0d8d, 0x0b8b0b8b );
  TEST_RR_SRC12_BYPASS( 24, 0, 1, add16, 0x1a191a19, 0x0e8e0e8e, 0x0b8b0b8b );
  TEST_RR_SRC12_BYPASS( 25, 0, 2, add16, 0x1b1a1b1a, 0x0f8f0f8f, 0x0b8b0b8b );
  TEST_RR_SRC12_BYPASS( 26, 1, 0, add16, 0x19181918, 0x0d8d0d8d, 0x0b8b0b8b );
  TEST_RR_SRC12_BYPASS( 27, 1, 1, add16, 0x1a191a19, 0x0e8e0e8e, 0x0b8b0b8b );
  TEST_RR_SRC12_BYPASS( 28, 2, 0, add16, 0x1b1a1b1a, 0x0f8f0f8f, 0x0b8b0b8b );

  TEST_RR_SRC21_BYPASS( 29, 0, 0, add16, 0x19181918, 0x0d8d0d8d, 0x0b8b0b8b );
  TEST_RR_SRC21_BYPASS( 30, 0, 1, add16, 0x1a191a19, 0x0e8e0e8e, 0x0b8b0b8b );
  TEST_RR_SRC21_BYPASS( 31, 0, 2, add16, 0x1b1a1b1a, 0x0f8f0f8f, 0x0b8b0b8b );
  TEST_RR_SRC21_BYPASS( 32, 1, 0, add16, 0x19181918, 0x0d8d0d8d, 0x0b8b0b8b );
  TEST_RR_SRC21_BYPASS( 33, 1, 1, add16, 0x1a191a19, 0x0e8e0e8e, 0x0b8b0b8b );
  TEST_RR_SRC21_BYPASS( 34, 2, 0, add16, 0x1b1a1b1a, 0x0f8f0f8f, 0x0b8b0b8b );

  TEST_RR_ZEROSRC1( 35, add16, 0x0e0e0e0e, 0x0e0e0e0e );
  TEST_RR_ZEROSRC2( 36, add16, 0x20202020, 0x20202020 );
  TEST_RR_ZEROSRC12( 37, add16, 0 );
  TEST_RR_ZERODEST( 38, add16, 0x10101010, 0x1d1d1d1d );

  TEST_PASSFAIL
