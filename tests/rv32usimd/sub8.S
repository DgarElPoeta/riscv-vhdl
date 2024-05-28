# See LICENSE for license details.

#*****************************************************************************
# sub8.S
#-----------------------------------------------------------------------------
#
# Test sub8 instruction.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  TEST_RR_OP( 2,  sub8, 0x00000000, 0x00000000, 0x00000000 );
  TEST_RR_OP( 3,  sub8, 0x00000000, 0x01010101, 0x01010101 );
  TEST_RR_OP( 4,  sub8, 0xfcfcfcfc, 0x03030303, 0x07070707 );

  TEST_RR_OP( 5,  sub8, 0x08080808, 0x00000000, 0xf8f8f8f8 );
  TEST_RR_OP( 6,  sub8, 0xf8f8f8f8, 0xf8f8f8f8, 0x00000000 );
  
  TEST_RR_OP( 7,  sub8, 0x08000800, 0x00000000, 0xf800f800 );
  TEST_RR_OP( 8,  sub8, 0xf800f800, 0xf800f800, 0x00000000 );
  TEST_RR_OP( 9,  sub8, 0x00080008, 0x00000000, 0x00f800f8 );
  TEST_RR_OP( 10, sub8, 0x00f800f8, 0x00f800f8, 0x00000000 );

  TEST_RR_OP( 11, sub8, 0x6e6e6e6e, 0x72727272, 0x04040404 );
  TEST_RR_OP( 12, sub8, 0xa0a0a0a0, 0xe0e0e0e0, 0x40404040 );

  TEST_RR_OP( 13, sub8, 0x01010101, 0x00000000, 0xffffffff );
  TEST_RR_OP( 14, sub8, 0xfefffeff, 0xff00ff00, 0x01010101 );
  TEST_RR_OP( 15, sub8, 0x00000000, 0xffffffff, 0xffffffff );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 16, sub8, 0x01fe01fe, 0x0c0c0c0c, 0x0b0e0b0e );
  TEST_RR_SRC2_EQ_DEST( 17, sub8, 0x02ff02ff, 0x0d0d0d0d, 0x0b0e0b0e );
  TEST_RR_SRC12_EQ_DEST( 18, sub8, 0, 0x0d0d0d0d );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RR_DEST_BYPASS( 19, 0, sub8, 0x01fe01fe, 0x0c0c0c0c, 0x0b0e0b0e );
  TEST_RR_DEST_BYPASS( 20, 1, sub8, 0x02ff02ff, 0x0d0d0d0d, 0x0b0e0b0e );
  TEST_RR_DEST_BYPASS( 21, 2, sub8, 0x03ff03ff, 0x0e0e0e0e, 0x0b0f0b0f );

  TEST_RR_SRC12_BYPASS( 22, 0, 0, sub8, 0x01fe01fe, 0x0c0c0c0c, 0x0b0e0b0e );
  TEST_RR_SRC12_BYPASS( 23, 0, 1, sub8, 0x02ff02ff, 0x0d0d0d0d, 0x0b0e0b0e );
  TEST_RR_SRC12_BYPASS( 24, 0, 2, sub8, 0x03ff03ff, 0x0e0e0e0e, 0x0b0f0b0f );
  TEST_RR_SRC12_BYPASS( 25, 1, 0, sub8, 0x01fe01fe, 0x0c0c0c0c, 0x0b0e0b0e );
  TEST_RR_SRC12_BYPASS( 26, 1, 1, sub8, 0x02ff02ff, 0x0d0d0d0d, 0x0b0e0b0e );
  TEST_RR_SRC12_BYPASS( 27, 2, 0, sub8, 0x03ff03ff, 0x0e0e0e0e, 0x0b0f0b0f );

  TEST_RR_SRC21_BYPASS( 28, 0, 0, sub8, 0x01fe01fe, 0x0c0c0c0c, 0x0b0e0b0e );
  TEST_RR_SRC21_BYPASS( 29, 0, 1, sub8, 0x02ff02ff, 0x0d0d0d0d, 0x0b0e0b0e );
  TEST_RR_SRC21_BYPASS( 30, 0, 2, sub8, 0x03ff03ff, 0x0e0e0e0e, 0x0b0f0b0f );
  TEST_RR_SRC21_BYPASS( 31, 1, 0, sub8, 0x01fe01fe, 0x0c0c0c0c, 0x0b0e0b0e );
  TEST_RR_SRC21_BYPASS( 32, 1, 1, sub8, 0x02ff02ff, 0x0d0d0d0d, 0x0b0e0b0e );
  TEST_RR_SRC21_BYPASS( 33, 2, 0, sub8, 0x03ff03ff, 0x0e0e0e0e, 0x0b0f0b0f );

  TEST_RR_ZEROSRC1( 34, sub8, 0x0f0f0f0f, 0xf1f1f1f1 );
  TEST_RR_ZEROSRC2( 35, sub8, 0x20202020, 0x20202020 );
  TEST_RR_ZEROSRC12( 36, sub8, 0 );
  TEST_RR_ZERODEST( 37, sub8, 0x10101010, 0x1e1e1e1e );

  TEST_PASSFAIL

