# See LICENSE for license details.

#*****************************************************************************
# sll8.S
#-----------------------------------------------------------------------------
#
# Test sll8 instruction.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  TEST_RR_OP( 2,  sll8, 0x01010101, 0x01010101, 0x00000000 );
  TEST_RR_OP( 3,  sll8, 0x02020202, 0x01010101, 0x01010101 );
  TEST_RR_OP( 4,  sll8, 0x08080808, 0x01010101, 0x03030303 );
  TEST_RR_OP( 5,  sll8, 0x20202020, 0x01010101, 0x05050505 );
  TEST_RR_OP( 6,  sll8, 0x80808080, 0x01010101, 0x07070707 );

  TEST_RR_OP( 7,  sll8, 0xffffffff, 0xffffffff, 0x00000000 );
  TEST_RR_OP( 8,  sll8, 0xfefefefe, 0xffffffff, 0x01010101 );
  TEST_RR_OP( 9,  sll8, 0xf8f8f8f8, 0xffffffff, 0x03030303 );
  TEST_RR_OP( 10, sll8, 0xe0e0e0e0, 0xffffffff, 0x05050505 );
  TEST_RR_OP( 11, sll8, 0x80808080, 0xffffffff, 0x07070707 );

  TEST_RR_OP( 12, sll8, 0x05050505, 0x05050505, 0x00000000 );
  TEST_RR_OP( 13, sll8, 0x0a0a0a0a, 0x05050505, 0x01010101 );
  TEST_RR_OP( 14, sll8, 0x28282828, 0x05050505, 0x03030303 );
  TEST_RR_OP( 15, sll8, 0xa0a0a0a0, 0x05050505, 0x05050505 );
  TEST_RR_OP( 16, sll8, 0x80808080, 0x05050505, 0x07070707 );

  # Verify that shifts only use bottom three bits of 8 bit data

  TEST_RR_OP( 17, sll8, 0x05050505, 0x05050505, 0xf8f8f8f8 );
  TEST_RR_OP( 18, sll8, 0x0a0a0a0a, 0x05050505, 0xf9f9f9f9 );
  TEST_RR_OP( 19, sll8, 0x28282828, 0x05050505, 0xfbfbfbfb );
  TEST_RR_OP( 20, sll8, 0xa0a0a0a0, 0x05050505, 0xfdfdfdfd );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 21, sll8, 0x08080808, 0x01010101, 0x03030303 );
  TEST_RR_SRC2_EQ_DEST( 22, sll8, 0x20202020, 0x01010101, 0x05050505 );
  TEST_RR_SRC12_EQ_DEST( 23, sll8, 0x18181818, 0x03030303 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RR_DEST_BYPASS( 24, 0, sll8, 0x08080808, 0x01010101, 0x03030303 );
  TEST_RR_DEST_BYPASS( 25, 1, sll8, 0x20202020, 0x01010101, 0x05050505 );
  TEST_RR_DEST_BYPASS( 26, 2, sll8, 0x80808080, 0x01010101, 0x07070707 );

  TEST_RR_SRC12_BYPASS( 27, 0, 0, sll8, 0x08080808, 0x01010101, 0x03030303 );
  TEST_RR_SRC12_BYPASS( 28, 0, 1, sll8, 0x20202020, 0x01010101, 0x05050505 );
  TEST_RR_SRC12_BYPASS( 29, 0, 2, sll8, 0x80808080, 0x01010101, 0x07070707 );
  TEST_RR_SRC12_BYPASS( 30, 1, 0, sll8, 0x08080808, 0x01010101, 0x03030303 );
  TEST_RR_SRC12_BYPASS( 31, 1, 1, sll8, 0x20202020, 0x01010101, 0x05050505 );
  TEST_RR_SRC12_BYPASS( 32, 2, 0, sll8, 0x80808080, 0x01010101, 0x07070707 );

  TEST_RR_SRC21_BYPASS( 33, 0, 0, sll8, 0x08080808, 0x01010101, 0x03030303 );
  TEST_RR_SRC21_BYPASS( 34, 0, 1, sll8, 0x20202020, 0x01010101, 0x05050505 );
  TEST_RR_SRC21_BYPASS( 35, 0, 2, sll8, 0x80808080, 0x01010101, 0x07070707 );
  TEST_RR_SRC21_BYPASS( 36, 1, 0, sll8, 0x08080808, 0x01010101, 0x03030303 );
  TEST_RR_SRC21_BYPASS( 37, 1, 1, sll8, 0x20202020, 0x01010101, 0x05050505 );
  TEST_RR_SRC21_BYPASS( 38, 2, 0, sll8, 0x80808080, 0x01010101, 0x07070707 );

  TEST_RR_ZEROSRC1( 39, sll8, 0x00000000, 0x05050505 );
  TEST_RR_ZEROSRC2( 40, sll8, 0x80808080, 0x80808080 );
  TEST_RR_ZEROSRC12( 41, sll8, 0x00000000 );
  TEST_RR_ZERODEST( 42, sll8, 0x10101010, 0x10101010 );

  TEST_PASSFAIL

