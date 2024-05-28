# See LICENSE for license details.

#*****************************************************************************
# sra8.S
#-----------------------------------------------------------------------------
#
# Test sra8 instruction.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  TEST_RR_OP( 2,  sra8, 0x80808080, 0x80808080, 0x00000000 );
  TEST_RR_OP( 3,  sra8, 0xc0c0c0c0, 0x80808080, 0x01010101 );
  TEST_RR_OP( 4,  sra8, 0xf0f0f0f0, 0x80808080, 0x03030303 );
  TEST_RR_OP( 5,  sra8, 0xfcfcfcfc, 0x80808080, 0x05050505 );
  TEST_RR_OP( 6,  sra8, 0xffffffff, 0x80808080, 0x07070707 );

  TEST_RR_OP( 7,  sra8, 0x7f7f7f7f, 0x7f7f7f7f, 0x00000000 );
  TEST_RR_OP( 8,  sra8, 0x3f3f3f3f, 0x7f7f7f7f, 0x01010101 );
  TEST_RR_OP( 9,  sra8, 0x0f0f0f0f, 0x7f7f7f7f, 0x03030303 );
  TEST_RR_OP( 10, sra8, 0x03030303, 0x7f7f7f7f, 0x05050505 );
  TEST_RR_OP( 11, sra8, 0x00000000, 0x7f7f7f7f, 0x07070707 );

  TEST_RR_OP( 12, sra8, 0xc0c0c0c0, 0xc0c0c0c0, 0x00000000 );
  TEST_RR_OP( 13, sra8, 0xe0e0e0e0, 0xc0c0c0c0, 0x01010101 );
  TEST_RR_OP( 14, sra8, 0xf8f8f8f8, 0xc0c0c0c0, 0x03030303 );
  TEST_RR_OP( 15, sra8, 0xfefefefe, 0xc0c0c0c0, 0x05050505 );
  TEST_RR_OP( 16, sra8, 0xffffffff, 0xc0c0c0c0, 0x07070707 );

  # Verify that shifts only use bottom three bits of 8 bit data

  TEST_RR_OP( 17, sra8, 0xc0c0c0c0, 0xc0c0c0c0, 0xf8f8f8f8 );
  TEST_RR_OP( 18, sra8, 0xe0e0e0e0, 0xc0c0c0c0, 0xf9f9f9f9 );
  TEST_RR_OP( 19, sra8, 0xf8f8f8f8, 0xc0c0c0c0, 0xfbfbfbfb );
  TEST_RR_OP( 20, sra8, 0xfefefefe, 0xc0c0c0c0, 0xfdfdfdfd );
  TEST_RR_OP( 21, sra8, 0xffffffff, 0xc0c0c0c0, 0xffffffff );
  
  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 22, sra8, 0xf0f0f0f0, 0x80808080, 0x03030303  );
  TEST_RR_SRC2_EQ_DEST( 23, sra8, 0xfcfcfcfc, 0x80808080, 0x05050505 );
  TEST_RR_SRC12_EQ_DEST( 24, sra8, 0xf8f8f8f8, 0xf1f1f1f1 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RR_DEST_BYPASS( 25, 0, sra8, 0xf0f0f0f0, 0x80808080, 0x03030303 );
  TEST_RR_DEST_BYPASS( 26, 1, sra8, 0xfcfcfcfc, 0x80808080, 0x05050505 );
  TEST_RR_DEST_BYPASS( 27, 2, sra8, 0xffffffff, 0x80808080, 0x07070707 );

  TEST_RR_SRC12_BYPASS( 28, 0, 0, sra8, 0xf0f0f0f0, 0x80808080, 0x03030303 );
  TEST_RR_SRC12_BYPASS( 29, 0, 1, sra8, 0xfcfcfcfc, 0x80808080, 0x05050505 );
  TEST_RR_SRC12_BYPASS( 30, 0, 2, sra8, 0xffffffff, 0x80808080, 0x07070707 );
  TEST_RR_SRC12_BYPASS( 31, 1, 0, sra8, 0xf0f0f0f0, 0x80808080, 0x03030303 );
  TEST_RR_SRC12_BYPASS( 32, 1, 1, sra8, 0xfcfcfcfc, 0x80808080, 0x05050505 );
  TEST_RR_SRC12_BYPASS( 33, 2, 0, sra8, 0xffffffff, 0x80808080, 0x07070707 );

  TEST_RR_SRC21_BYPASS( 34, 0, 0, sra8, 0xf0f0f0f0, 0x80808080, 0x03030303 );
  TEST_RR_SRC21_BYPASS( 35, 0, 1, sra8, 0xfcfcfcfc, 0x80808080, 0x05050505 );
  TEST_RR_SRC21_BYPASS( 36, 0, 2, sra8, 0xffffffff, 0x80808080, 0x07070707 );
  TEST_RR_SRC21_BYPASS( 37, 1, 0, sra8, 0xf0f0f0f0, 0x80808080, 0x03030303 );
  TEST_RR_SRC21_BYPASS( 38, 1, 1, sra8, 0xfcfcfcfc, 0x80808080, 0x05050505 );
  TEST_RR_SRC21_BYPASS( 39, 2, 0, sra8, 0xffffffff, 0x80808080, 0x07070707 );

  TEST_RR_ZEROSRC1( 40, sra8, 0x00000000, 0x05050505 );
  TEST_RR_ZEROSRC2( 41, sra8, 0x80808080, 0x80808080 );
  TEST_RR_ZEROSRC12( 42, sra8, 0x00000000 );
  TEST_RR_ZERODEST( 43, sra8, 0x10101010, 0x10101010 );

  TEST_PASSFAIL

