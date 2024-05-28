# See LICENSE for license details.

#*****************************************************************************
# srl8.S
#-----------------------------------------------------------------------------
#
# Test srl8 instruction.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  TEST_RR_OP( 2,  srl8, 0x80808080, 0x80808080, 0x00000000 );
  TEST_RR_OP( 3,  srl8, 0x40404040, 0x80808080, 0x01010101 );
  TEST_RR_OP( 4,  srl8, 0x10101010, 0x80808080, 0x03030303 );
  TEST_RR_OP( 5,  srl8, 0x04040404, 0x80808080, 0x05050505 );
  TEST_RR_OP( 6,  srl8, 0x01010101, 0x80808080, 0x07070707 );

  TEST_RR_OP( 7,  srl8, 0xffffffff, 0xffffffff, 0x00000000 );
  TEST_RR_OP( 8,  srl8, 0x7f7f7f7f, 0xffffffff, 0x01010101 );
  TEST_RR_OP( 9,  srl8, 0x1f1f1f1f, 0xffffffff, 0x03030303 );
  TEST_RR_OP( 10, srl8, 0x07070707, 0xffffffff, 0x05050505 );
  TEST_RR_OP( 11, srl8, 0x01010101, 0xffffffff, 0x07070707 );

  TEST_RR_OP( 12, srl8, 0x50505050, 0x50505050, 0x00000000 );
  TEST_RR_OP( 13, srl8, 0x28282828, 0x50505050, 0x01010101 );
  TEST_RR_OP( 14, srl8, 0x0a0a0a0a, 0x50505050, 0x03030303 );
  TEST_RR_OP( 15, srl8, 0x02020202, 0x50505050, 0x05050505 );
  TEST_RR_OP( 16, srl8, 0x00000000, 0x50505050, 0x07070707 );

  # Verify that shifts only use bottom three bits of 8 bit data

  TEST_RR_OP( 17, srl8, 0x50505050, 0x50505050, 0xf8f8f8f8 );
  TEST_RR_OP( 18, srl8, 0x28282828, 0x50505050, 0xf9f9f9f9 );
  TEST_RR_OP( 19, srl8, 0x0a0a0a0a, 0x50505050, 0xfbfbfbfb );
  TEST_RR_OP( 20, srl8, 0x02020202, 0x50505050, 0xfdfdfdfd );
  TEST_RR_OP( 21, srl8, 0x00000000, 0x50505050, 0xffffffff );
  
  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 22, srl8, 0x40404040, 0x80808080, 0x01010101  );
  TEST_RR_SRC2_EQ_DEST( 23, srl8, 0x04040404, 0x80808080, 0x05050505 );
  TEST_RR_SRC12_EQ_DEST( 24, srl8, 0x1e1e1e1e, 0xf3f3f3f3 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RR_DEST_BYPASS( 25, 0, srl8, 0x40404040, 0x80808080, 0x01010101 );
  TEST_RR_DEST_BYPASS( 26, 1, srl8, 0x04040404, 0x80808080, 0x05050505 );
  TEST_RR_DEST_BYPASS( 27, 2, srl8, 0x01010101, 0x80808080, 0x07070707 );

  TEST_RR_SRC12_BYPASS( 28, 0, 0, srl8, 0x40404040, 0x80808080, 0x01010101 );
  TEST_RR_SRC12_BYPASS( 29, 0, 1, srl8, 0x04040404, 0x80808080, 0x05050505 );
  TEST_RR_SRC12_BYPASS( 30, 0, 2, srl8, 0x01010101, 0x80808080, 0x07070707 );
  TEST_RR_SRC12_BYPASS( 31, 1, 0, srl8, 0x40404040, 0x80808080, 0x01010101 );
  TEST_RR_SRC12_BYPASS( 32, 1, 1, srl8, 0x04040404, 0x80808080, 0x05050505 );
  TEST_RR_SRC12_BYPASS( 33, 2, 0, srl8, 0x01010101, 0x80808080, 0x07070707 );

  TEST_RR_SRC21_BYPASS( 34, 0, 0, srl8, 0x40404040, 0x80808080, 0x01010101 );
  TEST_RR_SRC21_BYPASS( 35, 0, 1, srl8, 0x04040404, 0x80808080, 0x05050505 );
  TEST_RR_SRC21_BYPASS( 36, 0, 2, srl8, 0x01010101, 0x80808080, 0x07070707 );
  TEST_RR_SRC21_BYPASS( 37, 1, 0, srl8, 0x40404040, 0x80808080, 0x01010101 );
  TEST_RR_SRC21_BYPASS( 38, 1, 1, srl8, 0x04040404, 0x80808080, 0x05050505 );
  TEST_RR_SRC21_BYPASS( 39, 2, 0, srl8, 0x01010101, 0x80808080, 0x07070707 );

  TEST_RR_ZEROSRC1( 40, srl8, 0x00000000, 0x05050505 );
  TEST_RR_ZEROSRC2( 41, srl8, 0x80808080, 0x80808080 );
  TEST_RR_ZEROSRC12( 42, srl8, 0x00000000 );
  TEST_RR_ZERODEST( 43, srl8, 0x10101010, 0x10101010 );

  TEST_PASSFAIL

